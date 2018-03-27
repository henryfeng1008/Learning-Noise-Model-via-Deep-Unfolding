function err = errEval(x, xHat)
%   Error evaluation by MSE
err = 0.5 * (norm(x-xHat))^2;
end