function [X]=HW7xode(t,x)
tf=2000;
x0=[0,0,-1,0,1,-7.7765e-4]';
T=100*60; %sec
n=2*pi/T; %1/sec
a_max=4e-5;
F=[0, 1, 0, 0, 0, 0; 3*n^2, 0, 0, 2*n, 0, 0; 0, 0, 0, 1, 0, 0; 0, -2*n, 0, 0, 0, 0; 0 0 0 0 0 1; 0 0 0 0 -n^2 0];
G=[0,0,0;1,0,0;0,0,0;0,1,0;0,0,0;0,0,1];
PSI=eye(6);
Mtf=getM(tf,F,G);
v=-(PSI*Mtf*expm(F'*tf*PSI'))^-1*PSI*expm(F*tf)*x0;
lambda=expm(-F'*(t-tf))*PSI'*v;
f=-G'*lambda;


f_norm=norm(f);
if f_norm>a_max
    f=a_max*(f/f_norm);
end
X=F*[x(1);x(2);x(3);x(4);x(5);x(6)]+G*f;
