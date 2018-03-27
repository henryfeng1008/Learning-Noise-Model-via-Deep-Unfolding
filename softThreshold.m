function y = softThreshold(x, alpha, derivative)
% softthreshold function
if ~derivative
y = sign(x) .* max(abs(x) - alpha, 0);
else
    y = ones(size(x));
    y(abs(x) < alpha) = 0; 
end
end