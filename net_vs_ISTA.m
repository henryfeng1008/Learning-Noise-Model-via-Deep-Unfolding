clear
load trainedISTA.mat

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

figure(3)
plot(1:example,netCost,'r',1:example,ISTACost,'b');
title(['Cost compare'])
xlabel('example')
ylabel('Cost')
legend('Trained ISTA','ISTA')

figure(4)
plot(1:example,netSNR,'r',1:example,ISTASNR,'b');
title(['SNR compare'])
xlabel('example')
ylabel('SNR')
legend('Trained ISTA','ISTA')