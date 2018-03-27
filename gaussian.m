function y = gaussian(x, derivative)
temp = - x.^2 / 2;
g = exp(temp);
switch derivative
    case 0
        y = g;
    case 1  %   dx
        y = - x .* g;
    case 2  %   dxdx
        y = - g + x .^2 .* g;
end