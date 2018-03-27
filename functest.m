clear
load influenceFunc
x = [-256:0.1:256];
influenceFunc.K = 250;
influenceFunc.delta = 1;
out = influFunc(x', influenceFunc, 1);
w = zeros(2*influenceFunc.K+1,1);
w(influenceFunc.K+1,1) = 1;
y = out*w;
plot(x,y)