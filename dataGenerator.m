function [x, y, H] = dataGenerator
% Generat data and matrix
% y = Hx + e
% x is the truth with dimension 256, sparsity 0.2
% H is a M * N matrix with Gaussian dist N(0, 1/M)
% e is a dimension M Gaussian noise with mix Gaussian ~ a * N(0, theta_1^2) + (1 - a) * N(0, theta_2^2)

%  Parameters
N = 256; M = 150;
sparse = 0.2; 
theta = 0.6;
theta_1 = 0.4; theta_2 = 0.2;

%  Generate x
k = round(N * (1 - sparse));
z = randsample(1:N, k);
filter = ones(1, N);
filter(z) = 0;
x = randi([0,255],1, N);
% x = normrnd(0, 1, [1, N]);
x = filter .* x;

%  Generate H
H = normrnd(0, 1/M, [M, N]);

%  Generate e
prob = randi([0,10])/10;
if prob > 0.6
    e = normrnd(0, theta_1^1, [M, 1]);
else
    e = normrnd(0, theta_1^2, [M, 1]);
end
%  Calculate y
y = H * x' + e;
x = x';

end