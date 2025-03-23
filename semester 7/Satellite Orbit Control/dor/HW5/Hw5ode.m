function [X]=Hw5ode (t,x,F,G,K)
if (x(1)^2+x(3)^2)^0.5>10^-3
    xr=[0 0 0 0 0.05 0]';
    else
    xr=[0 0 0 0 0 0]';
end
a_max=0.04*10^-3; %km/sec^2
%if abs(x(5))>=10*10^-3
Gu=-F*xr-G*K*(x-xr);

if norm(Gu)>a_max
    Gu=(a_max/norm(Gu))*Gu;
end
X=F*x+Gu;

end
% if x(5)<10*10^-3
%     if x(1)^2+x(3)^2>10^-5
%         Kf=zeros(3,6);
%         Kf(1,:)=K(1,:);
%         Kf(2,:)=K(2,:);
%         Kf(3,:)=[0,0,0,0,0,0];
%         if x(6)~=0
%         Kf(3,6)=F(6,5)*x(5)/x(6);
%         else
%             G(3,5)=1;
%             Kf(3,5)=F(6,5);
%         end
%     else
%        Kf=zeros(3,6);
%        Kf(3,:)=K(3,:);
%     end
%     f=-Kf*x;
% f_norm=norm(f);
% 
% if f_norm>a_max
%     f=a_max*(f/f_norm);
% end
% X=F*x+G*f;
% end
%end
