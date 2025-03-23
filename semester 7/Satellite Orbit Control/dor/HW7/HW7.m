clear all
close all;
clc;
%% Parameters
tf=2000; %sec
x0=0;
y0=-1;%km
z0=1;%km
mu=3.986*10^5;
T=100*60; %sec
n=2*pi/T; %1/sec
alpha=0.01; %deg
a0=(mu*T^2/(4*pi^2))^(1/3);
z0_dot_n=-((a0*tand(alpha))^2-z0^2)^0.5;
z0_dot=z0_dot_n*n;
x0_dot=0;
y0_dot=-2*n*x0;
%%
F=[0, 1, 0, 0, 0, 0; 3*n^2, 0, 0, 2*n, 0, 0; 0, 0, 0, 1, 0, 0; 0, -2*n, 0, 0, 0, 0; 0 0 0 0 0 1; 0 0 0 0 -n^2 0];
G=[0,0,0;1,0,0;0,0,0;0,1,0;0,0,0;0,0,1];
a_max=4*10^-5;
%%
Q=eye(6);
R=diag([(1/a_max)^2,(1/a_max)^2,(1/a_max)^2]);
[K6,S,P6]=lqr(F,G,Q,R);
p1=[-1/200+1i*n,-1/200-1i*n];
P4=[p1,4*p1,p1];
K4=place(F,G,P4);
options=odeset('AbsTol',3e-9,'RelTol',3e-9);
flag=1;
res0=[x0,x0_dot,y0,y0_dot,z0,z0_dot];
res03=[x0,y0,x0_dot,y0_dot,z0,z0_dot];
[t7,res7]=ode45('HW7xode',[0:2000],res0);
[t6,res6]=ode45(@(t,res) Hw6ode(t,res,F,G,K6),[0:2000],res0,options);
[t4,res4]=ode45(@(t,res) Hw4ode(t,res,F,G,K4,flag),[0:2000],res0,options);
[t3,res3]=ode45('hw3bode',[0:2000],res03,options);
%%
miss_meter=norm([res7(end,1),res7(end,3),res7(end,5)])*10^3
vmiis_cmsec=norm([res7(end,2),res7(end,4),res7(end,6)])*10^5
%%
PSI=eye(6);
Mtf=getM(tf,F,G);
fx7=zeros(length(t7),1);
fy7=fx7;
fz7=fx7;
f_tot7=fx7;
v=-(PSI*Mtf*expm(F'*tf*PSI'))^-1*PSI*expm(F*tf)*res0';
for i=1:length(t7)
    t=t7(i);
lambda=expm(-F'*(t-tf))*PSI'*v;
f=-G'*lambda;

 f_norm=norm(f);
if f_norm>a_max
    f=a_max*(f/f_norm);
    f_norm=a_max;
end
fx7(i)=f(1);
fy7(i)=f(2);
fz7(i)=f(3);
f_tot7(i)=f_norm;
end
%%
figure(1)
plot3(res7(:,1),res7(:,3),res7(:,5))
grid on
hold all
plot3(res6(:,1),res6(:,3),res6(:,5))
plot3(res4(:,1),res4(:,3),res4(:,5))
plot3(res3(:,1),res3(:,2),res3(:,5))
plot3(x0,y0,z0,'hexagram')
plot3(0,0,0,'pentagram')
legend ('Trajectory of HW7','Trajectory of HW6','Trajectory of HW4','Trajectory of HW3','Starting Point','Target')
xlabel('X [km]')
ylabel('Y [km]')
zlabel('Z [km]')
title 'X-Y-Z Plot Of The Rendezvous Trajectory'
subtitle 'Dor Katz - 318301355'
%%
figure(2)
plot(t7,res7(:,1),'r','LineWidth',1.8);
hold on
grid on
plot(t7,res7(:,3),'b','LineWidth',1.8);
plot(t7,res7(:,5),'g','LineWidth',1.8);
plot(t6,res6(:,1),'r');
plot(t6,res6(:,3),'b');
plot(t6,res6(:,5),'g');
plot(t4,res4(:,1),'r--');
plot(t4,res4(:,3),'b--');
plot(t4,res4(:,5),'g--');
plot(t3,res3(:,1),'r-.','LineWidth',1.5);
plot(t3,res3(:,2),'b-.','LineWidth',1.5);
plot(t3,res3(:,5),'g-.','LineWidth',1.5);

legend('X of HW7','Y of HW7','Z of HW7','X of HW6','Y of HW6','Z of HW6','X of HW4','Y of HW4','Z of HW4','X of HW3','Y of HW3','Z of HW3')
title ('X, Y and Z vs. Time')
xlabel 'Time [sec]'
ylabel 'Distance [km]'
subtitle 'Dor Katz - 318301355'

%%
fx6=zeros(1,length(t6));
fy6=fx6;
fz6=fx6;
f_tot6=fx6;
fx4=zeros(1,length(t4));
fy4=fx4;
fz4=fx4;
f_tot4=fx4;
for i=1:length(t4)
  
    f=-K4*res4(i,:)';
    f_norm=norm(f);

    if f_norm>a_max
        f=a_max*(f/f_norm);
    end
    fx4(i)=f(1);
    fy4(i)=f(2);
    fz4(i)=f(3);
    f_tot4(i)=norm([fx4(i),fy4(i),fz4(i)]);
end
for i=1:length(t6)
  
    f=-K6*res6(i,:)';
    f_norm=norm(f);

    if f_norm>a_max
        f=a_max*(f/f_norm);
    end
    fx6(i)=f(1);
    fy6(i)=f(2);
    fz6(i)=f(3);
    f_tot6(i)=norm([fx6(i),fy6(i),fz6(i)]);
end


fx3=zeros(length(t3),1);
fy3=zeros(1,length(t3),1);
fz3=zeros(1,length(t3),1);
f_tot3=zeros(1,length(t3),1);
a_max3=8*10^-6; %km/sec^2
for i=[1:length(t3)]
    t=t3(i);
    x1=res3(i,1);
    x2=res3(i,2);
    x3=res3(i,3);
    x4=res3(i,4);
    x5=res3(i,5);
    x6=res3(i,6);
   Phixy=[4-3*cos(n*(tf-t)) 0 (1/n)*sin(n*(tf-t)) (2/n)*(1-cos(n*(tf-t)));...
    6*(sin(n*(tf-t))-n*(tf-t)) 1 (2/n)*(cos(n*(tf-t))-1) (1/n)*(4*sin(n*(tf-t))-3*n*(tf-t));...
    3*n*sin(n*(tf-t)) 0 cos(n*(tf-t)) 2*sin(n*(tf-t));...
    6*n*(cos(n*(tf-t))-1) 0 -2*sin(n*(tf-t)) 4*cos(n*(tf-t))-3];
PHIxy11=[Phixy(1,1) Phixy(1,2); Phixy(2,1) Phixy(2,2)];
PHIxy12=[Phixy(1,3) Phixy(1,4); Phixy(2,3) Phixy(2,4)];
Cxy=-inv(PHIxy12)*PHIxy11;
PHIz=[cos(n*(tf-t)) sin(n*(tf-t))/n; -n*sin(n*(tf-t)) cos(n*(tf-t))];
Cz=-PHIz(1,1)/PHIz(1,2);
    vgxy=Cxy*[x1;x2]-[x3;x4];
vgz=-[n/(tan(n*(tf-t))) 1]*[x5;x6];
Vg=[vgxy;vgz];
Vg_hat=Vg/norm(Vg);
C=[Cxy(1,1),Cxy(1,2),0;Cxy(2,1),Cxy(2,2),0;0,0,Cz];
P=-(C*Vg);
pvg=dot(P,Vg_hat);
q=(a_max3^2-dot(P,P)+pvg^2)^0.5;
xyf=Phixy*[x1;x2;x3;x4];
zzf=PHIz*[x5;x6];
norm([xyf(1),xyf(2),zzf(1)])
if norm([xyf(1),xyf(2),zzf(1)])<=1e-3
    fx3(i)=0;
    fy3(i)=0;
    fz3(i)=0;
    f_tot3(i)=0;
else
    if isreal(q)
        a=P+(q-pvg)*Vg_hat;
    if isnan(a(1))
        a(1)=0;
    end
    if isnan(a(2))
        a(2)=0;
    end
    if isnan(a(3))
        a(3)=0;
    end
        fx3(i)=a(1);
        fy3(i)=a(2);
        fz3(i)=a(3);
        f_tot3(i)=norm(a);
    else
        a=[0;0;0];
        fx3(i)=0;
        fy3(i)=0;
        fz3(i)=0;
        f_tot3(i)=0;
    end
end
    
    
end
DelV7=cumtrapz(f_tot7)*10^3; %meter_sec
DelV6=cumtrapz(f_tot6)*10^3; %meter_sec
DelV4=cumtrapz(f_tot4)*10^3; %meter_sec
DelV3=cumtrapz(f_tot3)*10^3;
DelV3(end)=DelV3(end)+(norm([res3(end,3),res3(end,4),res3(end,6)]))*10^3;%meter_sec

%%
figure(3)
plot(t7,fx7,'r','LineWidth',1.8)
hold on
grid on
plot(t7,fy7,'b','LineWidth',1.8)
plot(t7,fz7,'g','LineWidth',1.8)
plot(t7,f_tot7,'m','LineWidth',1.8)
plot(t6,fx6,'r');
plot(t6,fy6,'b');
plot(t6,fz6,'g');
plot(t6,f_tot6,'m');
plot(t4,fx4,'r--');
plot(t4,fy4,'b--');
plot(t4,fz4,'g--');
plot(t4,f_tot4,'m--');
plot(t3,fx3,'r-.','LineWidth',1.5);
plot(t3,fy3,'b-.','LineWidth',1.5);
plot(t3,fz3,'g-.','LineWidth',1.5);
plot(t3,f_tot3,'m-.','LineWidth',1.5);
title ('Thrust acceleration vs. Time')
xlabel 'Time [sec]'
ylabel 'Acceleration [km/sec^2]'
subtitle 'Dor Katz - 318301355'
yline([-0.04*10^-3,0.04*10^-3],'k--')
ylim([-5,5]*10^-5)
legend('fx of HW7','fy of HW7','fz of HW7','Total f of HW7','fx of HW6','fy of HW6','fz of HW6','Total f of HW6','fx of HW4','fy of HW4','fz of HW4','Total f of HW4','fx of HW3','fy of HW3','fz of HW3','Total f of HW3')
%%
figure(4)
plot(t7,fx7,'r','LineWidth',1.8)
hold on
grid on
plot(t7,fy7,'b','LineWidth',1.8)
plot(t7,fz7,'g','LineWidth',1.8)
plot(t7,f_tot7,'m','LineWidth',1.8)
title ('Thrust acceleration vs. Time')
xlabel 'Time [sec]'
ylabel 'Acceleration [km/sec^2]'
subtitle 'Dor Katz - 318301355'
legend('fx of HW7','fy of HW7','fz of HW7','Total f of HW7')
%%
figure(5)
plot(t7,DelV7)
hold on
grid on
plot(t6,DelV6)
plot(t4,DelV4)
plot(t3,DelV3)
xlabel 'Time [sec]'
ylabel '\Delta V [m/sec]'
title 'Accumulated \Delta V vs. time'
subtitle 'Dor Katz - 318301355'
legend ('\Delta V of HW7','\Delta V of HW6','\Delta V of HW4','\Delta V of HW3')
