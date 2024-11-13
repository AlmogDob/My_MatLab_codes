clc; close all;
a_ = 12000; %[km]
e_ = 0.345;
i_ = deg2rad(60); %[rad]
w_ = deg2rad(20); %[rad]
omega_ = deg2rad(110); %[rad]
mu = 3.986*10^5; % km^3/s^2
f_space = linspace(0, 2*pi*10 , 1000); % true anomaly range

syms f
p_ = a_*(1-e_^2)/(1+e_*cos(f));
theta_ = w_ + f;
x_ECI = p_*(cos(theta_)*cos(omega_) - sin(theta_)*cos(i_)*sin(omega_));
y_ECI = p_*(cos(theta_)*sin(omega_) + sin(theta_)*cos(i_)*cos(omega_));
z_ECI = p_*(sin(theta_)*sin(i_));
vx_ECI = sqrt(mu/(a_*(1-e_^2)))*e_*sin(f)*(cos(theta_)*cos(omega_)-sin(theta_)*cos(i_)*sin(omega_)) + sqrt(mu/(a_*(1-e_^2)))*(1+e_*cos(f))*(-sin(theta_)*cos(omega_)-cos(theta_)*cos(i_)*sin(omega_));
vy_ECI = sqrt(mu/(a_*(1-e_^2)))*e_*sin(f)*(cos(theta_)*sin(omega_)+sin(theta_)*cos(i_)*cos(omega_)) + sqrt(mu/(a_*(1-e_^2)))*(1+e_*cos(f))*(-sin(theta_)*sin(omega_)+cos(theta_)*cos(i_)*cos(omega_));
vz_ECI = sqrt(mu/(a_*(1-e_^2)))*e_*sin(f)*(sin(theta_)*sin(i_)) + sqrt(mu/(a_*(1-e_^2)))*(1+e_*cos(f))*(cos(theta_)*sin(i_));

rim = zeros(3, length(f_space));
vim = zeros(3, length(f_space));
aim = zeros(1, length(f_space));
eim = zeros(1, length(f_space));
iim = zeros(1, length(f_space));
wim = zeros(1, length(f_space));
omegaim = zeros(1, length(f_space));
fim = zeros(1, length(f_space));

for k = 1:length(f_space)
    f_val = f_space(k);
    r_k = double(subs([x_ECI; y_ECI; z_ECI], f, f_val));
    v_k = double(subs([vx_ECI; vy_ECI; vz_ECI], f, f_val));
    rim(:, k) = r_k;
    vim(:, k) = v_k;
    [aim(k), eim(k), iim(k), wim(k), omegaim(k), fim(k)] = kepler_solver(r_k, v_k, mu); 
end

% Plot 3D orbit trajectory with Earth
figure;
earth_sphere;
hold on;
plot3(rim(1, :), rim(2, :), rim(3, :), 'Color', "#7E2F8E", 'LineWidth', 2);

f_val = 0; % rad
Pr = double(subs([x_ECI; y_ECI; z_ECI], f, f_val));
f_val = pi; % rad
Ap = double(subs([x_ECI; y_ECI; z_ECI], f, f_val));
f_val = 2*pi - w_; % rad
ascending_node = double(subs([x_ECI; y_ECI; z_ECI], f, f_val));

plot3(Pr(1), Pr(2), Pr(3), "pentagram", "LineWidth", 2, "Color", "#4DBEEE"); % Perigee
plot3(Ap(1), Ap(2), Ap(3), "pentagram", "LineWidth", 2, "Color", "#77AC30"); % Apogee
plot3(ascending_node(1), ascending_node(2), ascending_node(3), "pentagram", "LineWidth", 2, "Color", "#A2142F"); % Ascending node

grid on;
title("The orbit trajectory around the earth in 3D");
subtitle("Nofar Koskas, 206918757");
legend('Earth', 'Orbit', 'Perigee', 'Apogee', 'Ascending node');

% Position components in the ECI frame as a function of true anomaly
figure;
plot(rad2deg(f_space), rim(1, :), 'r', 'LineWidth', 1.5);
hold on;
plot(rad2deg(f_space), rim(2, :), 'g', 'LineWidth', 1.5);
plot(rad2deg(f_space), rim(3, :), 'b', 'LineWidth', 1.5);
xlabel('True Anomaly [degrees]');
ylabel('Position [km]');
legend('x_{ECI}', 'y_{ECI}', 'z_{ECI}');
title('Position Components in ECI Frame as a Function of True Anomaly');
subtitle("Nofar Koskas, 206918757");
grid on;

% Velocity components in the ECI frame as a function of true anomaly
figure;
plot(rad2deg(f_space), vim(1, :), 'r', 'LineWidth', 1.5);
hold on;
plot(rad2deg(f_space), vim(2, :), 'g', 'LineWidth', 1.5);
plot(rad2deg(f_space), vim(3, :), 'b', 'LineWidth', 1.5);
xlabel('True Anomaly [degrees]');
ylabel('Velocity [km/s]');
legend('v_{x, ECI}', 'v_{y, ECI}', 'v_{z, ECI}');
title('Velocity Components in ECI Frame as a Function of True Anomaly');
subtitle("Nofar Koskas, 206918757");
grid on;

% Keplerian orbital elements as a function of true anomaly in one plot
figure;
plot(rad2deg(f_space), aim/1000, 'LineWidth', 1.5);
hold on;
plot(rad2deg(f_space), eim, 'LineWidth', 1.5);
plot(rad2deg(f_space), iim, 'LineWidth', 1.5);
plot(rad2deg(f_space), wim, 'LineWidth', 1.5);
plot(rad2deg(f_space), omegaim, 'LineWidth', 1.5);
plot(rad2deg(f_space), fim, 'LineWidth', 1.5);
xlabel('True Anomaly [degrees]');
ylabel('Orbital Elements');
legend('Semi-major Axis [10^3 km]', 'Eccentricity', 'Inclination [deg]', 'Argument of Perigee [deg]', 'RAAN [deg]', 'True Anomaly [deg]');
title('Keplerian Orbital Elements as a Function of True Anomaly');
subtitle("Nofar Koskas, 206918757");
grid on;

% Kepler elements function
function [a, e, i, w, omega, f] = kepler_solver(r_vec, v_vec, mu)
    r_norm = norm(r_vec);
    v_norm = norm(v_vec);
    h_vec = cross(r_vec, v_vec);
    h_norm = norm(h_vec);
    e_vec = cross(v_vec, h_vec)*(1/mu) - r_vec / r_norm;
    e = norm(e_vec);
    p = h_norm^2 / mu;
    a = p / (1 - e^2);
    n_vec = [-h_vec(2), h_vec(1), 0];
    n_norm = norm(n_vec);
    omega = atan2d(n_vec(2) / n_norm, n_vec(1) / n_norm);
    w = atan2d(sign(e_vec(3)) * sqrt(1 - (dot(n_vec, e_vec) / (n_norm * e))^2), dot(n_vec, e_vec) / (n_norm * e));
    f = atan2d(sign(dot(r_vec, v_vec)) * sqrt(1 - (dot(r_vec, e_vec) / (r_norm * e))^2), dot(r_vec, e_vec) / (r_norm * e));
    i = acosd(h_vec(3) / h_norm);
end