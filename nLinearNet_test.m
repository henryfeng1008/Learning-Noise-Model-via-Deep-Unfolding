function [Cost, SNR] = nLinearNet_test(param, data, influenceFunc, network )
% Proposed network for nonlinearity
% H is a M * N matrix with Gaussian dist N(0, 1/M)
% x is a N dimension column vector
% y is a M dimension column vector
% N > M
%%  initialize
%   parameter
gamma = param.gamma;
lambda = param.lambda;

%   data
x = data.original;
y = data.noisy;
H = data.matrix;

%   influence function
delta = influenceFunc.delta;
K = influenceFunc.K;

%   network
layers = network.layers;
weights = network.weights;

xPre = H' * y;
%% forward
for iLayer = 1:layers
    gradDx(:,:,iLayer)  = influFunc((H * xPre - y), influenceFunc, 1);
    z(:,iLayer) = xPre - (gamma / delta) * H' * gradDx(:,:,iLayer) * weights;
    xHat = softThreshold(z(:,iLayer), gamma * lambda, 0);
%     xHat = max(0,z(:,iLayer));
    xPre = xHat;
end
Cost = errEval(x, xHat);
SNR = 10 * log10((norm(x))^2/(norm(x - xHat))^2);
end