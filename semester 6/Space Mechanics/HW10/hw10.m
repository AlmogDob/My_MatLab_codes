clc; clear;

N = datenum(['1-Jan']) - datenum(['1-Jan'])+1

RA = 0.98563*(N-80)
delta = asind(0.39795*cosd(0.98563*(N-173)))

rs = [cosd(delta)*cosd(RA) cosd(delta)*sind(RA) sind(delta)]
h = [1/sqrt(2) 0 1/sqrt(2)]

sin_of_beta = abs(dot(h, rs))
cos_of_beta = abs(sqrt(1-sin_of_beta^2))

l = 1.5;
d = 0.8;
Ap = l*d;
Ah = d^2/4*pi;
A = Ap*cos_of_beta + Ah*sin_of_beta
m = 300;
z = 380;
Re = 6371;
Cd = 2.47;
S = Ap;
inclination = 45;
mu = 3.986e5*1000*1000*1000;
we = 2*pi/24/60/60;
Kd = S*Cd/m;

fs = 4.55e-6*A/m
fsp = fs*cos_of_beta
fsh = fs*sin_of_beta

y = sqrt(((Re+z)^2-(Re/sin_of_beta)^2)/(1-1/sin_of_beta^2))
x = sqrt((Re+z)^2-y^2)

f_in = atan2(-y,x)*180/pi
f_out = atan2(y,x)*180/pi
precent = (f_out-f_in)/360*100

syms a v


rho = 2*fsp/v^2/Kd/(1-we*a/v*cosd(inclination))^2

rho_b = 1.45e-13;
h_b = 600*1000;
h_top = 700*1000;
H = 71.835*1000;
a = Re*1000+(h_top+h_b)/2;
v = sqrt(mu/a);
rho = subs(rho);
h = double(-1*log(rho/rho_b)*H+h_b)/1000
