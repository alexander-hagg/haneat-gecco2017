%% afunct - Apply selected activation function to value x
%

function [ value] = afunct(func, x )

switch func
    case 1
        value = x;
    case 2
        value = (x>0);
    case 3
        value= (x>0).*x;
    case 4
        value = (1./(1+exp(-4.9*x)));
    case 5
        value = (exp(-(x-0).^2/(2*1^2)));
    case 6
        value = 0.05 + tanh(x) + -0.1.*sin(7.*x) + -0.05.*cos(3.*x);
    case 7
        value = 1./ (1 + exp(-x));
    case 8
        value = sin(x);
    otherwise
        disp('ERROR in afunct - you did not select a valid activation function. ... Please check the fctPool configuration parameter')
end



