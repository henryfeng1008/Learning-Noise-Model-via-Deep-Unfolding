function [xHat,x,SNR,Cost] = ISTA(lambda, display)
% Benchmark ISTA
%%  generate data and set early stop
tic
earlyStop = 50;
[x, y, H] = dataGenerator;
t = 1 / max(eig(H' * H));
xPre = H' * y;
i = 1;
costPre = Inf;
maxStep = 10000;
%%  iterative thresholding algorithm
while i <= maxStep
    xHat = softThreshold((xPre - t * H' * (H * xPre - y)), lambda * t, 0);
    costNow = (norm(x - xHat))^2;
    diff = costPre - costNow;
    if diff > 0 && diff < 0.001
        cost(i) = costNow;
        SNR(i) = 10 * log10(((norm(x))^2/(norm(x - xHat))^2));
        converge = converge + 1;
        if converge == earlyStop
            i = i + 1;
            break
        end
    else
        converge = 0;
    end
    cost(i) = costNow;
    SNR(i) = 10 * log10(((norm(x))^2/(norm(x - xHat))^2));
    xPre = xHat;
    costPre = costNow;
    i = i + 1;
end
xHat = xPre;
Cost = (norm(x - xHat))^2;
toc
i
%%  plot figures

if display == 1
    figure(2)
    plot(1:i-1,SNR);
    title('SNR')
    figure(3)
    plot(1:i-1,cost);
    title('Cost')
    SNR = 10 * log10(((norm(x))^2/(norm(x - xHat))^2));
    Cost = 0.5 * (norm(x - xHat))^2;
end
end