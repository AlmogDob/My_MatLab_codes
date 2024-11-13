function [ts, x1s, x2s, z1s, z2s] = ODE_Full_Solution(Initial_Condition, Final_Height)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global h t_b Gama_Const

t_n = Initial_Condition(1);
x1_n = Initial_Condition(2);
x2_n = Initial_Condition(3);
z1_n = Initial_Condition(4);
z2_n = Initial_Condition(5);


num_of_iteretion = 0;

ts = [];
x1s = [];
x2s = [];
z1s = [];
z2s = [];

while not(z1_n < Final_Height)
    a11 = h*f1(x2_n);
    a21 = h*f2(t_n, x2_n, z2_n);
    a31 = h*f3(z2_n);
    a41 = h*f4(t_n, x2_n, z2_n);
    
    a12 = h*f1(x2_n + 0.5*a21);
    a22 = h*f2(t_n + 0.5*h, x2_n + 0.5*a21, z2_n + 0.5*a41);
    a32 = h*f3(z2_n + 0.5*a41);
    a42 = h*f4(t_n + 0.5*h, x2_n + 0.5*a21, z2_n + 0.5*a41);
    
    a13 = h*f1(x2_n + 2*a22 - a21);
    a23 = h*f2(t_n + h, x2_n + 2*a22 - a21, z2_n + 2*a42 - a41);
    a33 = h*f3(z2_n + 2*a42 - a41);
    a43 = h*f4(t_n + h, x2_n + 2*a22 - a21, z2_n + 2*a42 - a41);
    
    ts(end + 1) = t_n;
    x1s(end + 1) = x1_n;
    z1s(end + 1) = z1_n;
    x2s(end + 1) = x2_n;
    z2s(end + 1) = z2_n;

    x1_n_plus_1 = x1_n + (1/6)*(a11+4*a12+a13);
    x2_n_plus_1 = x2_n + (1/6)*(a21+4*a22+a23);
    z1_n_plus_1 = z1_n + (1/6)*(a31+4*a32+a33);
    z2_n_plus_1 = z2_n + (1/6)*(a41+4*a42+a43);

    t_n = t_n + h;
    x1_n = x1_n_plus_1;
    x2_n = x2_n_plus_1;
    z1_n = z1_n_plus_1;
    z2_n = z2_n_plus_1;
    
    if Gama_Const == true
        Limit = t_b/h;
    else
        Limit = 1000000;
    end

    if num_of_iteretion > (Limit)
        break
    end
    num_of_iteretion = num_of_iteretion + 1;
end

end