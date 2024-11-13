%% 1.b
clear; clc;
nt_s = linspace(0, 1*2*pi, 5000);
x_s = 0.001.*(1-cos(nt_s));
y_s = -0.002.*(sin(nt_s) - nt_s);
D_s = sqrt(y_s.^2 + x_s.^2);

plot3(x_s, y_s,nt_s)