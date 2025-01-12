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
p1=[-1/200+1i*n,-1/200-1i*n];
%p2=[-4/200+1i*4/2000,-4/200-1i*4/2000];
P=[p1,4*p1,p1];
K=place(F,G,P);
%%
options=odeset('AbsTol',3e-14,'RelTol',3e-14);
flag=1;
res0=[x0,x0_dot,y0,y0_dot,z0,z0_dot];
[t,res]=ode45(@(t,res) Hw4ode(t,res,F,G,K,flag),[0:2000],res0,options);

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
f=zeros(length(t),3);
fnorm=zeros(length(t),1);
delv_kmsec=0;
for i=1:length(t)
    u=-K*res(i,:)';
    if norm(u)>0.04*10^-3
        f(i,:)=0.04*10^-3*(u/norm(u));
    else
        f(i,:)=u;
    end
    delv_kmsec=delv_kmsec+norm(f(i,:));
    fnorm(i)=norm(f(i,:));
end
delv_kmsec
delv_metersec=delv_kmsec*10^3
%%
figure(3)
plot(t,f(:,1));
hold on
grid on
plot(t,f(:,2));
plot(t,f(:,3));
plot(t,fnorm)
title ('Thrust acceleration vs. Time')
xlabel 'Time [sec]'
ylabel 'Acceleration [km/sec^2]'
subtitle 'Dor Katz - 318301355'
yline([-0.04*10^-3,0.04*10^-3],'r--')
ylim([-5,5]*10^-5)
legend('fx','fy','fz','Total f')
%% section C
% now z fidbeck is off
flag=2;
[tc,res_c]=ode45(@(t,res) Hw4ode(t,res,F,G,K,flag),[0:2000],res0,options);
xc=res_c(:,1);
vxc=res_c(:,2);
yc=res_c(:,3);
vyc=res_c(:,4);
zc=res_c(:,5);
vzc=res_c(:,6);
%%
figure(4)
plot3(xc,yc,zc)
grid on
hold on
plot3(x0,y0,z0,'hexagram')
plot3(0,0,0,'pentagram')
legend ('Trajectory','Starting Point','Target')
xlabel('X [km]')
ylabel('Y [km]')
zlabel('Z [km]')
title 'X-Y-Z Plot Of The Rendezvous Trajectory With Disconnected Z Feedback'
subtitle 'Dor Katz - 318301355'
%%
figure(5)
plot(tc,xc);
hold on
grid on
plot(tc,yc);
plot(tc,zc);
legend('X','Y','Z')
title ('X, Y and Z vs. Time With Disconnected Z Feedback')
xlabel 'Time [sec]'
ylabel 'Distance [km]'
subtitle 'Dor Katz - 318301355'
%%
missc=norm([xc(end),yc(end),zc(end)])*10^3 %m
misscV=norm([vxc(end),vyc(end),vzc(end)])*10^5 %cm/sec
%% caculating thrust
fc=zeros(length(tc),3);
fcnorm=zeros(length(tc),1);
delv_kmsecc=0;
for i=1:length(tc)
    if tc(i)>=500
        res_c(i,5)=0;
    end
    u=-K*res_c(i,:)';
    if norm(u)>0.04*10^-3
        fc(i,:)=0.04*10^-3*(u/norm(u));
    else
        fc(i,:)=u;
    end        
    delv_kmsec=delv_kmsec+norm(fc(i,:));
    fcnorm(i)=norm(fc(i,:));
end
delv_kmsec
delv_metersec=delv_kmsec*10^3
%%
figure(6)
plot(tc,fc(:,1));
hold on
grid on
plot(tc,fc(:,2));
plot(tc,fc(:,3));
plot(tc,fcnorm)
title ('Thrust acceleration vs. Time With Disconnected Z Feedback')
xlabel 'Time [sec]'
ylabel 'Acceleration [km/sec^2]'
subtitle 'Dor Katz - 318301355'
yline([-0.04*10^-3,0.04*10^-3],'r--')
ylim([-5,5]*10^-5)
legend('fx','fy','fz','Total f')
%%
flag=2;
[t2,res_c2]=ode45(@(t,res) Hw4ode(t,res,F,G,K,flag),[0:80000],res0,options);
x2=res_c2(:,1);
vx2=res_c2(:,2);
y2=res_c2(:,3);
vy2=res_c2(:,4);
z2=res_c2(:,5);
vz2=res_c2(:,6);
missing=1000000;
i=0;
while missing>=1;
    i=i+1;
    missing=norm([x2(i),y2(i),z2(i)])*10^3;
end

time_of_Rendezvous=t2(i)
miss2=norm([x2(i),y2(i),z2(i)])*10^3 %m
miss2V=norm([vx2(i),vy2(i),vz2(i)])*10^5 %cm/sec
