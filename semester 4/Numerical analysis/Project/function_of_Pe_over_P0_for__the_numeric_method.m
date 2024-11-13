function [f_at_x] = function_of_Pe_over_P0_for__the_numeric_method(x)
% defining the function for the zero finding method
global A_e K_p A_t 
A = ((K_p + 1)/2)^(1/(K_p - 1));
B = (K_p+1)/(K_p-1);
C = A_t/A_e;

f_at_x = A*x^(1/K_p)*(B*(1-x^((K_p-1)/(K_p))))^0.5-C;
end