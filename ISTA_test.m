function [Cost, SNR] = ISTA_test(data, param, network)
% Benchmark ISTA
%%  generate data and set early stop
y = data.noisy;
H = data.matrix;
x = data.original;

gamma = param.gamma;
lambda = param.lambda;

earlyStop = 50;
t = 1 / max(eig(H' * H));
xPre = H' * y;
i = 1;
costPre = Inf;
maxStep = network.layers;

%%  iterative thresholding algorithm
for i = 1:maxStep
    xHat = softThreshold((xPre - gamma * H' * (H * xPre - y)), lambda * t, 0);
    xPre = xHat;
end
Cost = errEval(x, xHat);
SNR = 10 * log10((norm(x))^2/(norm(x - xHat))^2);
end