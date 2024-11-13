function [value_of_the_integral] = Integration_by_Simpsons_method_for_E_of_x(x1, x2, h)
% Integration_by_Simpsons_method_for_E_of_x calculats the integral between
% x1 and x2 of E(x) with a constants h
%   Detailed explanation goes here
format long
%definging constants and variabels
E_0 = 2050; % [V/m]
L = 0.12; % [m]
a = (pi/4)^0.5; % [-]
b = 0.08; % [-]
n = 2;
N = ceil((x2-x1)/(n*h));
to_continue = true;
I = zeros(1,N);
i = 1; % iteretion number
lowerlimit = x1;
upperlimit = lowerlimit + 2*h;

%defining the function E(x)
syms x;
E = E_0*cos(((a*x)/(L))^2)*exp(-b*(x/L)^(3/2));
E = matlabFunction(E);

while (to_continue)
    I(i) = (h/3)*(E(lowerlimit)+4*E(lowerlimit+h)+E(upperlimit));
    i = i+1;
    lowerlimit = upperlimit;
    upperlimit = lowerlimit + 2*h;
    if i > N 
        to_continue = false;
    end
end
value_of_the_integral = sum(I);
end

