%% Q1
clc; clear;

mu0 = 3.986e5;
T0 = 2*60*60;
Zp0 = 400;
Re = 6371;
LTAN0 = 14*60*60;
LTAN1 = 13*60*60;
time = 5*24*60*60;
Omega_dot_s_rad = 1.99e-7;
Omega_dot_s_deg = Omega_dot_s_rad*180/pi;
J2 = 1.0826e-3;
n0 = 2*pi/T0;

a0 = (mu0*T0^2/(4*pi^2))^(1/3);
rp0 = Zp0+Re;
e0 = 1-rp0/a0;
p0 = a0*(1-e0^2);

Omega_dot_deg = 15*(LTAN1 - LTAN0)/time/3600 + Omega_dot_s_deg;
Omega_dot_rad = Omega_dot_deg*pi/180

i_rad = acos(Omega_dot_rad/(-3/2*J2*n0*(Re/p0)^2))

%% Q2
clc; clear;

mu = 3.986e5;

Zp = 500;
Re = 6371;
J2 = 1.0826e-3;
i_deg = 116.5651;

rp = Zp+Re;
omega_deg = 180-asind(sind(50)/sind(i_deg));

syms e a s

n = (mu/a^3)^0.5;
p = a*(1-e^2);
a = rp/(1-e);

eq1 = -3/2*J2*n*(Re/p)^2*cos(i_deg*pi/180) == 1.99e-7;
eq1 = subs(eq1);
% solution = double(solve(eq1,e,"IgnoreProperties",true))
solution = solve(eq1,e,"ReturnConditions",true);
poly = sym2poly(8301118257252967787255214445145015872726681075667711986445410740526685093888*s^4 + 133621778236439233343944270608736688335416862602442807648318666203225779150265*s^3 + 334456388651293957733791096265049938024437139201986727053392712685463856699691*s - 251445206078764279861238951813599779297170328445309607188938605280197005760811*s^2 - 92116186950174394407668198383011608971783457224104247716091612500592353680825);
e_s = roots(poly);
e = e_s(4);
a = double(subs(a));