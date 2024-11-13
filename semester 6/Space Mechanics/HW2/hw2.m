%% 1.c
r_0 = [-3500; 7600; 0]; % [km]
v_0 = [-1.8; -2.0339; 6.2]; % [km/sec]
Mu = 3.986e5; % [km^3/sec^2]

[a, e, i, small_omega, big_omega, f, epsilon, h] = kepler_orbital_elements(r_0, v_0, Mu)

%% 1.d.i
tic
% Initial Conditions
r_0 = [-3500; 7600; 0]; % [km]
v_0 = [-1.8; -2.0339; 6.2]; % [km/sec]
planet

state_initial = [r_0; v_0];

time_in_minutes = 20;
time_interval = [0 time_in_minutes*60];

% This is where we integrate the equations of motion.
[t_out, state_out] = ode45(@Satellite, time_interval, state_initial,odeset('RelTol',1e-5));

% fig1 = figure ("Name","3D figure of the orbit trajectory along with the Earth drawing",'Position',[700 100 900 500]);
% hold all
% 
% earth_sphere
% plot3(state_out(:,1),state_out(:,2),state_out(:,3), "LineWidth", 2, "Color", "#D95319")
% 
% xlabel('X [km]')
% ylabel('Y [km]')
% zlabel('Z [km]')
% grid on
% grid minor
% title("3D figure of the orbit trajectory aloog with the Earth drawing")
% subtitle("Almog Dobrescu 214254252")
% legend({'The Earth','The orbit'},'FontSize',11 ,'Location','southeast')
% %exportgraphics(fig1, 'grap1.png','Resolution',1200);

r_20_min_vector = [state_out(end,1);state_out(end,2);state_out(end,3)]
v_20_min_vector = [state_out(end,4);state_out(end,5);state_out(end,6)]
toc

epsilons = [];
hs = [];
rs = [state_out(:,1),state_out(:,2),state_out(:,3)];
vs = [state_out(:,4),state_out(:,5),state_out(:,6)];

for j = 1:length(state_out(:,1))
    [a, e, i, small_omega, big_omega, f, epsilon, h] = kepler_orbital_elements(rs(j,:), vs(j,:), Mu);
    epsilons(j) = epsilon;
    hs(j) = h;
    
end

fig2 = figure ("Name","Numerical Integration - Conservation of Energy And Angular Momentum",'Position',[700 250 900 500]);
hold all

plot(t_out, epsilons, "LineWidth", 1.5, "Color", "#0072BD")
plot(t_out, hs, "LineWidth", 1.5, "Color", "#77AC30")

ylabel('Magnitude [-]')
xlabel('Time [sec]')
grid on
grid minor
title("Numerical Integration - Conservation of Energy And Angular Momentum")
subtitle("Almog Dobrescu 214254252")
legend({'Energy','Angular Momentum'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig2, 'grap2.png','Resolution',1200);

%% 1.d.ii
time_in_minutes = 20;
time_interval = [0 time_in_minutes*60];

r_0_vector = [-3500; 7600; 0]; % [km]
r_0 = norm(r_0_vector);
v_0_vector = [-1.8; -2.0339; 6.2]; % [km/sec]
v_0 = norm(v_0_vector);
Mu = 3.986e5; % [km^3/sec^2]

[a, e, i, small_omega, big_omega, f_0, epsilon, h] = kepler_orbital_elements(r_0_vector, v_0_vector, Mu);
% f_0 = 2*pi + f_0;
tic
eta = sqrt(1-e^2);
E_0 = mod(2*pi*1 + atan2(eta*sin(f_0)/(1+e*cos(f_0)), (e+cos(f_0))/(1+e*cos(f_0))),2*pi);
M_0 = E_0 - e*sin(E_0);

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

r_20_min_vector_L = F*r_0_vector + G*v_0_vector
r_20_min_L = norm(r_20_min_vector_L);

F_t = -sqrt(Mu*a)/(r_20_min_L*r_0)*sin(delta_E);
G_t = 1 - a/r_20_min_L*(1-cos(delta_E));

v_20_min_vector_L = F_t*r_0_vector + G_t*v_0_vector
toc

[a, e, i, small_omega, big_omega, f, epsilon, h] = kepler_orbital_elements(r_20_min_vector_L, v_20_min_vector_L, Mu);

epsilon
h

%% 

delta_r_vector = r_20_min_vector - r_20_min_vector_L
delta_v_vector = v_20_min_vector - v_20_min_vector_L



