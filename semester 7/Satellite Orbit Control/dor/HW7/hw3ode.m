function [X]=hw3ode(t,x)
x1=x(1);
x2=x(2);
x3=x(3);
x4=x(4);
x5=x(5);
x6=x(6);
T=100*60; %sec
n=2*pi/T;

fx=-2*n*x5;
fy=0;
fz=n^2*x3;

X=[x4; x5; x6;fx+2*n*x5+3*n^2*x1; fy-2*n*x4; fz-n^2*x3];
