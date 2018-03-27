clear
load trainedISTA.mat

%   fit weights that make the trained-ISTA = ISTA
k = influenceFunc.K;
x = [-k:0.1:k]';
y = influFunc((x), influenceFunc, 1);
c = glmfit(y,x);
c(1) = [];
network.weights = c;
example = 100;

fprintf('testing\n')

for i = 1:example
    [x, y, H] = dataGenerator;
    data.original = x;
    data.noisy = y;
    data.matrix = H;
    [netCost(i), netSNR(i)] = nLinearNet_test(param, data, influenceFunc, network);
    [ISTACost(i), ISTASNR(i)] = ISTA_test(data, param, network);
end

figure(1)
subplot(2,1,1)
plot(1:example,netCost,'r');
subplot(2,1,2)
plot(1:example,ISTACost,'b');
title(['Cost compare'])
xlabel('example')
ylabel('Cost')
legend('Net','ISTA')

figure(4)
plot(1:example,netSNR,'r',1:example,ISTASNR,'b');
title(['SNR compare'])
xlabel('example')
ylabel('SNR')
legend('Net','ISTA')