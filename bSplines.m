function y = bSplines(degree, x)
%   B-splines functions of different degree
y = zeros(size(x));
if degree == 3
    case_1 = (1 >= abs(x)) .* (abs(x) >= 0) == 1;
    case_2 = (2 >= abs(x)) .* (abs(x) >= 1) == 1;
    case_3 = abs(x) >= 2;
    y(case_1) = 2/3 - abs(x(case_1)).^2;
    y(case_2) = 1/6 * (2 - abs(x(case_2))).^3;
    y(case_3) = 0;
elseif degree == 2
    case_1 = (1/2 >= abs(x)) .* (abs(x) >= 0) == 1;
    case_2 = (3/2 >= abs(x)) .* (abs(x) >= 1/2) == 1;
    case_3 = abs(x) >= 3/2;
    y(case_1) = 3/4 - abs(x(case_1)).^2;
    y(case_2) = 9/8 - 1/2 * abs(x(case_2)) .*  (3 - abs(x(case_2)));
    y(case_3) = 0;
end
end