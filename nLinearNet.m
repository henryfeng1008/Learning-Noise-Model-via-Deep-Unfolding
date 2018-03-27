function [xHat, c, error] = nLinearNet(param, data, influenceFunc, network )
% Proposed network for nonlinearity
% H is a M * N matrix with Gaussian dist N(0, 1/M)
% x is a N dimension column vector
% y is a M dimension column vector
% N > M
%%  initialize
%   global parameter
gamma = param.gamma;
lambda = param.lambda;

%   data
x = data.original;
y = data.noisy;
H = data.matrix;

%   influence function parameter
delta = influenceFunc.delta;
K = influenceFunc.K;

%   network parameter
layers = network.layers;
learnRate = network.learnRate;
weights = network.weights;
batch = network.batch;

dLdw = 0;
for b = 1:batch
    xPre = H' * y;
    %% forward
    for iLayer = 1:layers
        
        gradDx(:,:,iLayer)  = influFunc((y - H * xPre), influenceFunc, 1);
        gradDx2(:,:,iLayer) = influFunc((y - H * xPre), influenceFunc, 2);
        z(:,iLayer) = xPre + (gamma / delta) * H' * gradDx(:,:,iLayer) * weights;
        xHat = softThreshold(z(:,iLayer), gamma * lambda, 0);
        %     xHat = softThreshold(z(:,iLayer), lambda, 0);
        xPre = xHat;
    end
    error = errEval(x, xHat);
    %%  backward
    %   get gradient
    dXdwPre = zeros(length(x),length(weights));
    
    for jLayer = 1:layers
        dXdw = dXdwPre ...
            + (gamma/delta) * H' * gradDx(:,:,jLayer)...
            - (gamma/delta^2) * H' * ((H * dXdwPre) .* repmat((gradDx2(:,:,jLayer) * weights),[1 length(weights)]));
        dThreshold = softThreshold(z(:,iLayer), gamma * lambda, 1);
        %     dThreshold = softThreshold(z(:,iLayer), lambda, 1);
        dXdw = dXdw .* repmat(dThreshold,[1 length(weights)]);
        dXdwPre = dXdw;
    end
    dLdw = dLdw + dXdw' * (xHat - x);
end
dLdw = dLdw / batch;
c = weights - learnRate * dLdw;
% c = softThreshold(c,lambda, 0);
% c = max(0,c);
end
