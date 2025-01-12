function [X]=Hw4ode (t,x,F,G,K,flag)
a_max=0.04*10^-3; %km/sec^2
if flag==1
f=-K*x;
f_norm=norm(f);

if f_norm>a_max
    f=a_max*(f/f_norm);
end
X=F*x+G*f;
end
if flag==2
    xk=x;
    if t>=500 % z feedbeck is off
       xk(5)=0;
    end
    f=-K*xk;
f_norm=norm(f);

if f_norm>a_max
    f=a_max*(f/f_norm);
end
X=F*x+G*f;
end
end
