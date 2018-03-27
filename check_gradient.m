clear
load c.mat

% influenceFunc.K = 1000;
k = influenceFunc.K;
x = [-k:0.1:k]';
y = influFunc((x), influenceFunc, 1);
tic
c = glmfit(y,x);
toc
c(1) = [];
network.weights = c;

x = data.original;
y = data.noisy;
H = data.matrix;
gamma = param.gamma;
delta = influenceFunc.delta;

xPre = H' * y;
v = H * xPre - y;

tISTA = influFunc(H * xPre - y, influenceFunc, 2) * c;
% tISTA
ISTA = H'* (H * xPre - y);
size(tISTA)
size(ISTA)
% (norm(tISTA - ISTA))^2
% [tISTA, ISTA]