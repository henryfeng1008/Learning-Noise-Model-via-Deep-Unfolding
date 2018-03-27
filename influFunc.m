function out = influFunc(x, influenceFunc, derivative)
%   Nonlinear influence function
%%  parameters
K = influenceFunc.K;
delta = influenceFunc.delta;

k = -K:K;
xNum = size(x, 1);
grid = zeros(xNum, size(k, 2));
for i = 1:xNum
    grid(i,:) = (x(i) / delta - k);
end
out = gaussian(grid, derivative);
end