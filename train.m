%%  initialization
clear;
close all;
% clc;
tic
%   global parameter
param.lambda = 5 * 1e-1;

%   influence function parameter
influenceFunc.delta = 1;
influenceFunc.K = 800;

%   network parameter
network.layers = 10;
network.learnRate = 3 * 1e-5;
network.batch = 5;

%   initial weights that simulate ISTA
K = influenceFunc.K;
x_test = [-K:0.1:K]';
y_test = influFunc((x_test), influenceFunc, 1);
c = glmfit(y_test,x_test);
c(1) = [];
network.weights = c;

%   train
iterations = 300;

% [x, y, H] = dataGenerator;
% data.original = x;
% data.noisy = y;
% data.matrix = H;
% param.gamma = 1 / max(eig(H' * H));
%%   train
fprintf('training\n')
for i = 1:iterations
    [x, y, H] = dataGenerator;
    data.original = x;
    data.noisy = y;
    data.matrix = H;
    param.gamma = 1 / max(eig(H' * H));
    
    [xHat, c, error(i)] = nLinearNet(param, data, influenceFunc, network);
    SNR(i) = 10 * log10((norm(x))^2/(norm(x - xHat))^2);
    network.weights = c;
end

[xHat, x]
toc

save trainedISTA.mat

figure(1)
plot(1:iterations, error);
title('Cost')

figure(2)
plot(1:iterations, SNR);
title('SNR')