clear all
close all;
clc;
%% Parameters
%global F G K
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
F=zeros(6);
G=zeros(6,3);
Fxy=[0, 1, 0, 0; 3*n^2, 0, 0, 2*n; 0, 0, 0, 1; 0, -2*n, 0, 0];
Gxy=[0,0;1,0;0,0;0,1];
Fz=[0, 1; -n^2, 0];
Gz=[0;1];
F(1:4,1:4)=Fxy;
F(5:6,5:6)=Fz;
G(1:4,1:2)=Gxy;
G(5:6,3)=Gz;
%% calculating poles:
%P=[-0.6*n+1i*n,-0.6*n-1i*n,-4*n-1i*n,-4*n+1i*n,-0.6*n-1i*n,-0.6*n+1i*n];
p1=[-n*20+1i*n,-n*20-1i*n];
%p2=[-4/200+1i*4/2000,-4/200-1i*4/2000];
P=[p1,4*p1,p1];
K=place(F,G,P);
%%
options=odeset('AbsTol',3e-9,'RelTol',3e-9);
res0=[x0,x0_dot,y0,y0_dot,z0,z0_dot];
[t,res]=ode45(@(t,res) Hw5ode(t,res,F,G,K),[0:2000],res0,options);

%%
x=res(:,1);
vx=res(:,2);
y=res(:,3);
vy=res(:,4);
z=res(:,5);
vz=res(:,6);
%%
figure(1)
plot3(x,y,z)
grid on
hold on
plot3(x0,y0,z0,'hexagram')
plot3(0,0,0,'pentagram')
legend ('Trajectory','Starting Point','Target')
xlabel('X [km]')
ylabel('Y [km]')
zlabel('Z [km]')
title 'X-Y-Z Plot Of The Rendezvous Trajectory'
subtitle 'Dor Katz - 318301355'
%%
figure(2)
plot(t,x);
hold on
grid on
plot(t,y);
plot(t,z);
legend('X','Y','Z')
title ('X, Y and Z vs. Time')
xlabel 'Time [sec]'
ylabel 'Distance [km]'
subtitle 'Dor Katz - 318301355'
%%
miss=norm([x(end),y(end),z(end)])*10^3 %m
missV=norm([vx(end),vy(end),vz(end)])*10^5 %cm/sec
%% caculating thrust
fx=zeros(1,length(t));
fy=fx;
fz=fx;
f_tot=fx;
for i=1:length(t)
    if (x(i)^2+y(i)^2)^0.5>10^-3
    xr=[0 0 0 0 0.1 0]';
    else
    xr=[0 0 0 0 0 0]';
    end
    r=[x(i),vx(i),y(i),vy(i),z(i),vz(i)]';
a_max=0.04*10^-3; %km/sec^2
%if abs(x(5))>=10*10^-3
Gu=-F*xr-G*K*(r-xr);

if norm(Gu)>a_max
    Gu=(a_max/norm(Gu))*Gu;
end
fx(i)=Gu(2);
fy(i)=Gu(4);
fz(i)=Gu(6);
f_tot(i)=norm([fx(i),fy(i),fz(i)]);
end
delv_kmsec=trapz(f_tot)
delv_metersec=delv_kmsec*10^3
%%
figure(3)
plot(t,fx);
hold on
grid on
plot(t,fy);
plot(t,fz);
plot(t,f_tot)
title ('Thrust acceleration vs. Time')
xlabel 'Time [sec]'
ylabel 'Acceleration [km/sec^2]'
subtitle 'Dor Katz - 318301355'
yline([-0.04*10^-3,0.04*10^-3],'r--')
ylim([-5,5]*10^-5)
legend('fx','fy','fz','Total f')
%%
figure(4)
plot(t(889:end),x(889:end)*10^3)
hold on
grid on
plot(t(889:end),y(889:end)*10^3)
plot(t(889:end),z(889:end)*10^3)
ylabel('Distance [m]')
xlabel('Time [sec]')
title 'X, Y and Z in Final Approch'
yline([-1,1],'--')
legend('X','Y','Z')
subtitle 'Dor Katz - 318301355'