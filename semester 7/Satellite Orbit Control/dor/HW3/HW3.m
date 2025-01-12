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
n=2*pi/T;
alpha=0.01; %deg
a0=(mu*T^2/(4*pi^2))^(1/3);
z0_dot_n=-((a0*tand(alpha))^2-z0^2)^0.5;
z0_dot=z0_dot_n*n;
x0_dot=0;
y0_dot=-2*n*x0;

%% suquestion 1 ode
x0=[0,-1,1,0,1/2000,-1/2000];
options=odeset('AbsTol',3e-14,'RelTol',3e-14);
time=[0,tf];
[t,xy]=ode45('hw3ode',time,x0,options);
%% plotting
x=xy(:,1);
y=xy(:,2);
z=xy(:,3);
figure(1)
plot3(x,y,z)
grid on
hold on
plot3(0,-1,1,'hexagram')
plot3(0,0,0,'pentagram')
legend ('Trajectory','Starting Point','Target')
xlabel('X [km]')
ylabel('Y [km]')
zlabel('Z [km]')
title 'HW3.Q1.X-Y-Z Plot Of The Rendezvous Trajectory'
subtitle 'Dor Katz - 318301355'
figure(2)
plot(t,x,t,y,t,z)
grid on
legend ('X vs. Time','Y vs. Time','Z vs. Time')
ylabel('Distance [km]')
xlabel('Time [sec]')
title 'HW3.Q1.X-Y-Z Plot VS. Time'
subtitle 'Dor Katz - 318301355'

%%
fx=-2*n.*xy(:,5);
fz=n^2.*xy(:,3);
for i=1:length(fx)
f_tot(i)=norm([fx(i),fz(i)]);
end
%%
figure(3)
plot(t,fx,t,fz,t,f_tot)
grid on
legend ('fx vs. Time','fz vs. Time','f_tot vs. Time')
ylabel('Acceleration [km/sec^2]')
xlabel('Time [sec]')
title 'HW3.Q1. Acceleration VS. Time'
subtitle 'Dor Katz - 318301355'
%%
figure(4)
v1=((1/2000)^2+(-1/2000-z0_dot)^2)^0.5;
delv3=v1+cumtrapz(t,f_tot);
v2=delv3(end)+((1/2000)^2+(-1/2000)^2)^0.5;
delv_tot=[0;v1;delv3';v2];
tv=[0;0;t;t(end)];
plot(tv,delv_tot)
grid on
ylabel('\Delta V [km/sec]')
xlabel('Time [sec]')
title 'HW3.Q1. Total \Delta V VS. Time'
subtitle 'Dor Katz - 318301355'

%% subquestion b
clear all
clc;
tf=2000; %sec
x0=0;
y0=-1;%km
z0=1;%km
mu=3.986*10^5;
T=100*60; %sec
n=2*pi/T;
alpha=0.01; %deg
a0=(mu*T^2/(4*pi^2))^(1/3);
z0_dot_n=-((a0*tand(alpha))^2-z0^2)^0.5;
z0_dot=z0_dot_n*n;
x0_dot=0;
y0_dot=-2*n*x0;
x0=[x0,y0,x0_dot,y0_dot,z0,z0_dot];
%options1=odeset('AbsTol',3e-11,'RelTol',3e-11);
time=[0,tf];
[t,xyz]=ode45('hw3bode',time,x0);
x=xyz(:,1);
y=xyz(:,2);
z=xyz(:,5);
vx=xyz(:,3);
vy=xyz(:,4);
vz=xyz(:,6);
%%
figure(5)
plot3(x,y,z)
grid on
hold on
plot3(0,-1,1,'hexagram')
plot3(0,0,0,'pentagram')
legend ('Trajectory','Starting Point','Target')
xlabel('X [km]')
ylabel('Y [km]')
zlabel('Z [km]')
title 'HW3.Q2.X-Y-Z Plot Of The Rendezvous Trajectory'
subtitle 'Dor Katz - 318301355'
%%
figure(6)
plot(t,x,t,y,t,z)
grid on
legend ('X vs. Time','Y vs. Time','Z vs. Time')
ylabel('Distance [km]')
xlabel('Time [sec]')
title 'HW3.Q2.X-Y-Z Plot VS. Time'
subtitle 'Dor Katz - 318301355'
%%
missing_distance_in_meters=((x(end)^2+y(end)^2+z(end)^2)^0.5)*10^3

%% calcultaing the thrusters
fx=zeros(length(t),1);
fy=zeros(1,length(t),1);
fz=zeros(1,length(t),1);
f_tot=zeros(1,length(t),1);
a_max=8*10^-6; %km/sec^2
for i=[1:length(t)]
    Phixy=[4-3*cos(n*(tf-t(i))) 0 (1/n)*sin(n*(tf-t(i))) (2/n)*(1-cos(n*(tf-t(i))));...
    6*(sin(n*(tf-t(i)))-n*(tf-t(i))) 1 (2/n)*(cos(n*(tf-t(i)))-1) (1/n)*(4*sin(n*(tf-t(i)))-3*n*(tf-t(i)));...
    3*n*sin(n*(tf-t(i))) 0 cos(n*(tf-t(i))) 2*sin(n*(tf-t(i)));...
    6*n*(cos(n*(tf-t(i)))-1) 0 -2*sin(n*(tf-t(i))) 4*cos(n*(tf-t(i)))-3];
    PHIxyz=[4-3*cos(n*(tf-t(i))) 0 (1/n)*sin(n*(tf-t(i))) (2/n)*(1-cos(n*(tf-t(i)))) 0 0;...
    6*(sin(n*(tf-t(i)))-n*(tf-t(i))) 1 (2/n)*(cos(n*(tf-t(i)))-1) (1/n)*(4*sin(n*(tf-t(i)))-3*n*(tf-t(i))) 0 0;...
    3*n*sin(n*(tf-t(i))) 0 cos(n*(tf-t(i))) 2*sin(n*(tf-t(i))) 0 0;...
    6*n*(cos(n*(tf-t(i)))-1) 0 -2*sin(n*(tf-t(i))) 4*cos(n*(tf-t(i)))-3 0 0;...
    0 0 0 0 cos(n*(tf-t(i))) sin(n*(tf-t(i)))/n;...
    0 0 0 0 -n*sin(n*(tf-t(i))) cos(n*(tf-t(i)))];
    PHIxy11=[4-3*cos(n*(tf-t(i))) 0; 6*(sin(n*(tf-t(i)))-n*(tf-t(i))) 1];
    PHIxy12=[(1/n)*sin(n*(tf-t(i))) (2/n)*(1-cos(n*(tf-t(i)))); (2/n)*(cos(n*(tf-t(i)))-1) (1/n)*(4*sin(n*(tf-t(i)))-3*n*(tf-t(i)))];
    Cxy=-inv(PHIxy12)*PHIxy11;
    PHIz=[cos(n*(tf-t(i))) sin(n*(tf-t(i)))/n; -n*sin(n*(tf-t(i))) cos(n*(tf-t(i)))];
    Cz=-cos(n*(tf-t(i)))/(sin(n*(tf-t(i)))/n);
    Vgxy=Cxy*[x(i);y(i)]-[vx(i);vy(i)];
    vgz=-[n/(tan(n*(tf-t(i)))) 1]*[z(i);vz(i)];
    Vg=[Vgxy;vgz];
    Vg_hat=Vg/norm(Vg);
    C=[Cxy(1,1),Cxy(1,2),0;Cxy(2,1),Cxy(2,2),0;0,0,Cz];
    P=-(C*Vg);
    pvg=dot(P,Vg_hat);
    q=(a_max^2-dot(P,P)+pvg^2)^0.5;
    xyf=Phixy*[x(i);y(i);vx(i);vy(i)];
    zzf=PHIz*[z(i);vz(i)];
    if norm([xyf(1),xyf(2),zzf(1)])<=1e-3
    fx(i)=0;
    fy(i)=0;
    fz(i)=0;
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
        fx(i)=a(1);
        fy(i)=a(2);
        fz(i)=a(3);
        f_tot(i)=norm(a);
    else
        a=[0;0;0];
        fx(i)=0;
        fy(i)=0;
        fz(i)=0;
        f_tot(i)=0;
    end
    end
    
    
end
del_v=cumtrapz(t,f_tot);
del_v(end)=del_v(end)+norm([vx(end),vy(end),vz(end)]);
%%
figure(7)
plot(t,fx,t,fy,t,fz,t,f_tot)
grid on
legend ('f_x vs. Time','f_y vs. Time','f_z vs.Time','f_{tot} vs. Time')
ylabel('Acceleration [km/sec^2]')
xlabel('Time [sec]')
title 'HW3.Q2. Acceleration VS. Time'
subtitle 'Dor Katz - 318301355'
%% calculating delv
figure(8)
plot(t,del_v)
grid on
ylabel('\Delta V [km/sec]')
xlabel('Time [sec]')
title 'HW3.Q2. Total \Delta V VS. Time'
subtitle 'Dor Katz - 318301355'