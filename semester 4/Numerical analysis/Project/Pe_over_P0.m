function [Pe_over_P0] = Pe_over_P0()
% finding the ratio between Pe and P0 using the changing chord method (Meitar Mishtane) 
% and returning Pe over P0
global epsilon
f_of_x = @function_of_Pe_over_P0_for__the_numeric_method;
to_stop = false;
num_of_iterations = 0;
x_0 = 0;
x_1 = 0.01;
x_n_minus_1 = x_0;
x_n = x_1;

while not(to_stop)
    x_n_plus_1 = x_n - f_of_x(x_n)*((x_n-x_n_minus_1)/(f_of_x(x_n) - f_of_x(x_n_minus_1)));
    if abs(x_n_plus_1 - x_n) <= epsilon
        to_stop = true;
        break;
    end
    x_n_minus_1 = x_n;
    x_n = x_n_plus_1;
    if num_of_iterations > 2000
        break
    end
    num_of_iterations = num_of_iterations + 1;
end
Pe_over_P0 = x_n;
end