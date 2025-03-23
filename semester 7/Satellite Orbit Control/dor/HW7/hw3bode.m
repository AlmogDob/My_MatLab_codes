function [X]=hw3bode(t,x)
x1=x(1);
x2=x(2);
x3=x(3);
x4=x(4);
x5=x(5);
x6=x(6);
T=6000;
n=2*(pi/T);
tf=2000; %sec
a_max=8*10^-6; %km/sec^2
%%
Phixy=[4-3*cos(n*(tf-t)) 0 (1/n)*sin(n*(tf-t)) (2/n)*(1-cos(n*(tf-t)));...
    6*(sin(n*(tf-t))-n*(tf-t)) 1 (2/n)*(cos(n*(tf-t))-1) (1/n)*(4*sin(n*(tf-t))-3*n*(tf-t));...
    3*n*sin(n*(tf-t)) 0 cos(n*(tf-t)) 2*sin(n*(tf-t));...
    6*n*(cos(n*(tf-t))-1) 0 -2*sin(n*(tf-t)) 4*cos(n*(tf-t))-3];
PHIxy11=[4-3*cos(n*(tf-t)) 0; 6*(sin(n*(tf-t))-n*(tf-t)) 1];
PHIxy12=[(1/n)*sin(n*(tf-t)) (2/n)*(1-cos(n*(tf-t))); (2/n)*(cos(n*(tf-t))-1) (1/n)*(4*sin(n*(tf-t))-3*n*(tf-t))];
Cxy=-inv(PHIxy12)*PHIxy11;
PHIz=[cos(n*(tf-t)) sin(n*(tf-t))/n; -n*sin(n*(tf-t)) cos(n*(tf-t))];
PHIxyz=[4-3*cos(n*(tf-t)) 0 (1/n)*sin(n*(tf-t)) (2/n)*(1-cos(n*(tf-t))) 0 0;...
    6*(sin(n*(tf-t))-n*(tf-t)) 1 (2/n)*(cos(n*(tf-t))-1) (1/n)*(4*sin(n*(tf-t))-3*n*(tf-t)) 0 0;...
    3*n*sin(n*(tf-t)) 0 cos(n*(tf-t)) 2*sin(n*(tf-t)) 0 0;...
    6*n*(cos(n*(tf-t))-1) 0 -2*sin(n*(tf-t)) 4*cos(n*(tf-t))-3 0 0;...
    0 0 0 0 cos(n*(tf-t)) sin(n*(tf-t))/n;...
    0 0 0 0 -n*sin(n*(tf-t)) cos(n*(tf-t))];
Cz=-cos(n*(tf-t))/(sin(n*(tf-t))/n);
%%
vgxy=Cxy*[x1;x2]-[x3;x4];
vgz=-[n/(tan(n*(tf-t))) 1]*[x5;x6];
Vg=[vgxy;vgz];
Vg_hat=Vg/norm(Vg);
C=[Cxy(1,1),Cxy(1,2),0;Cxy(2,1),Cxy(2,2),0;0,0,Cz];
P=-(C*Vg);
pvg=dot(P,Vg_hat);
q=(a_max^2-dot(P,P)+pvg^2)^0.5;
%%
xyf=Phixy*x(1:4);
zzf=PHIz*x(5:6);
norm([xyf(1),xyf(2),zzf(1)])
if norm([xyf(1),xyf(2),zzf(1)])<=1e-3
    fx=0;
    fy=0;
    fz=0;
else
if isreal(q)
    a=P+(q-pvg)*Vg_hat;
    fx=a(1);
    fy=a(2);
    fz=a(3);
    if isnan(fx)
        fx=0;
    end
    if isnan(fy)
        fy=0;
    end
    if isnan(fz)
        fz=0;
    end
else
    fx=0;
    fy=0;
    fz=0;
end
end
X=[x3 ; x4 ; fx+2*n*x4+3*n^2*x1; fy-2*n*x3; x6; fz-n^2*x5];
