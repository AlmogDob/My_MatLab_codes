mu = 3.986e5; % [km^3/s^2]
R_earth = 6378; % [km] 
T = 6e3; %[sec]
e = 0;
a = (mu*T^2/4/pi^2)^(1/3); %[km]
n = 2*pi/T;

delta_L_t5 = 20--10;
delta_L = 20;

k = 4 * delta_L_t5 / 3 / n / (5*24*60*60-0)^2

t_B = sqrt(8 * delta_L / 3 / n / k);
delta_h = -2 * k * t_B

delta_v = 2 * sqrt(2 * n * k * delta_L / 3)