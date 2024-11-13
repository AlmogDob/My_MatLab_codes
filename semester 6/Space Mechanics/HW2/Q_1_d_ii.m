time_in_minutes = 20;
time_interval = [0 time_in_minutes*60];

r_0_vector = [-3500; 7600; 0]; % [km]
r_0 = norm(r_0_vector);
v_0_vector = [-1.8; -2.0339; 6.2]; % [km/sec]
v_0 = norm(v_0_vector);
Mu = 3.986e5; % [km^3/sec^2]

[a, e, i, small_omega, big_omega, f_0, epsilon, h] = kepler_orbital_elements(r_0_vector, v_0_vector, Mu);
% f_0 = 2*pi + f_0;

eta = sqrt(1-e^2);
E_0 = mod(2*pi*1 + atan2(eta*sin(f_0)/(1+e*cos(f_0)), (e+cos(f_0))/(1+e*cos(f_0))),2*pi);
M_0 = E_0 + e*sin(E_0);

n = sqrt(Mu/a^3);
M = n*(time_interval(2) - time_interval(1)) + M_0;

sum = 0;
for k = 1:100
    sum = sum + 1/k * besselj(k, k*e) * sin(k*M);
end

E = M + 2*sum;

delta_E = E - E_0;

F = 1 - a/r_0 * (1 - cos(delta_E));
G = a/Mu * dot(r_0_vector, v_0_vector) * (1 - cos(delta_E)) + r_0 * sqrt(a/Mu) * sin(delta_E);

r_20_min_vector_L = F*r_0_vector + G*v_0_vector;
r_20_min_L = norm(r_20_min_vector_L);

F_t = -sqrt(Mu*a)/(r_20_min_L*r_0)*sin(delta_E);
G_t = 1 - a/r_20_min_L*(1-cos(delta_E));

v_20_min_vector_L = F_t*r_0_vector + G_t*v_0_vector;
%%

x = [F, G ;F_t, G_t];
det(x)

