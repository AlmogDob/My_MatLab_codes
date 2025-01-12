function [X]=Hw6ode (t,x,F,G,K)
a_max=0.04*10^-3; %km/sec^2
f=-K*x;
f_norm=norm(f);

if f_norm>a_max
    f=a_max*(f/f_norm);
end
X=F*x+G*f;
end