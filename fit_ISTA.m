clear
load influenceFunc

influenceFunc.K = 1000;
influenceFunc.delta = 1;
K = influenceFunc.K
x = [-K:0.1:K]';
y = influFunc((x), influenceFunc, 1);
c = glmfit(y,x);
c(1) = [];

x = [-100:0.01:100]';
y = influFunc((x), influenceFunc, 1);
output = y*c;
plot(x',output);grid on;
c
