clc; clear;

z0 = 500;
Re = 6371;
a0 = (Re+z0)*1000;
rho = 6.96e-13;
mu = 3.986e5*1000*1000*1000;
n0 = sqrt(mu/(a0^3));
Cd1 = 2.2;
Cd2 = 2.4;
S1 = 5;
S2 = 10;
m1 = 300;
m2 = 1000;
omega_e = 2*pi/24/60/60;

Kd1 = S1*Cd1/m1;
Kd2 = S2*Cd2/m2;

a_dot1 = -rho*sqrt(mu*a0)*Kd1
a_dot2 = -rho*sqrt(mu*a0)*Kd2

t = 5*24*60*60;

delta_y1_km = -3/4*n0*a_dot1*t^2/1000
delta_y2_km = -3/4*n0*a_dot2*t^2/1000

delta_delta_km = (delta_y1_km - delta_y2_km)

delta_y = delta_delta_km + 100


h_top = [500 450 400 350 300 250]*1000;
h_bot = [450 400 350 300 250 200]*1000;
H = [60.828 58.515 53.298 53.628 45.546 37.105]*1000;
rho_b = [1.58e-12 3.72e-12 9.5e-12 2.41e-11 7.24e-11 2.78e-10];
for j = 1:length(h_bot)
    a_avg = (Re*1000 + (h_top(j)+h_bot(j))/2);
    v = sqrt(mu/a_avg);
    F(j) = (1-omega_e*a_avg/v)^2;
    delta_t(j) = H(j)/rho_b(j)/sqrt(mu*a_avg)/Kd1*(exp((h_top(j)-h_bot(j))/H(j))-1)/F(j)
end
sum(delta_t)/60/60/24


