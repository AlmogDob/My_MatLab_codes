%% 1.1.a
syms theta big_omega i a e f small_omega
first_matrix_rotation = [cos(big_omega) sin(big_omega) 0;-sin(big_omega) cos(big_omega) 0;0 0 1];
second_matrix_rotation = [1 0 0;0 cos(i) sin(i);0 -sin(i) cos(i)];
third_matrix_rotation = [cos(theta) sin(theta) 0;-sin(theta) cos(theta) 0;0 0 1];
DCM_ECI_to_LVLH = third_matrix_rotation * second_matrix_rotation * first_matrix_rotation;
DCM_LVLH_to_ECI = DCM_ECI_to_LVLH.';

%% 1.1.b
syms theta big_omega i a e f small_omega
first_matrix_rotation = [cos(big_omega) sin(big_omega) 0;-sin(big_omega) cos(big_omega) 0;0 0 1];
second_matrix_rotation = [1 0 0;0 cos(i) sin(i);0 -sin(i) cos(i)];
third_matrix_rotation = [cos(small_omega + f) sin(small_omega + f) 0;-sin(small_omega + f) cos(small_omega + f) 0;0 0 1];
DCM_ECI_to_LVLH = third_matrix_rotation * second_matrix_rotation * first_matrix_rotation;
DCM_LVLH_to_ECI = DCM_ECI_to_LVLH.';

r = a*(1-e^2)/(1+e*cos(f));
r_LVLH = [r;0;0];
r_ECI = DCM_LVLH_to_ECI * r_LVLH;
r_dot_ECI = diff(r_ECI,f);

%% 1.2.c
mu = 3.98603e5;
[a,e,i,small_omega, big_omega,f] = kepler_orbital_elements([2.5 -6.6 1.059]*10.^3, [3.8 0.40885 -6.422], mu)

%% 1.2.d
syms big_omega i a e f small_omega mu v_f(f) r_f(f)
first_matrix_rotation = [cos(big_omega) sin(big_omega) 0;-sin(big_omega) cos(big_omega) 0;0 0 1];
second_matrix_rotation = [1 0 0;0 cos(i) sin(i);0 -sin(i) cos(i)];
third_matrix_rotation = [cos(small_omega + f) sin(small_omega + f) 0;-sin(small_omega + f) cos(small_omega + f) 0;0 0 1];
DCM_ECI_to_LVLH = third_matrix_rotation * second_matrix_rotation * first_matrix_rotation;
DCM_LVLH_to_ECI = DCM_ECI_to_LVLH.';

r = a*(1-e^2)/(1+e*cos(f));
r_LVLH = [r;0;0];
r_ECI = DCM_LVLH_to_ECI * r_LVLH;
r_dot_ECI_wrt_f = diff(r_ECI,f);
f_dot = (sqrt(mu)*(1+e*cos(f))^2)/(a*(1-e^2))^(3/2);
r_dot_ECI_wrt_time = r_dot_ECI_wrt_f .* f_dot;

a = 12e3; % [km]
e = 0.345; % [-]
i = 60*pi/180; % [rad]
small_omega = 20*pi/180; % [rad]
big_omega = 110*pi/180; % [rad]
mu = 3.986e5; % [km^3/s^2]
number_of_rotaions = 10;
number_of_points = 1000;

values_for_f = linspace(0,2*pi*number_of_rotaions,number_of_points);
rs = zeros(3,length(values_for_f));
vs = zeros(3,length(values_for_f));
as = zeros(1,length(values_for_f));
es = zeros(1,length(values_for_f));
is = zeros(1,length(values_for_f));
small_omegas = zeros(1,length(values_for_f));
big_omegas = zeros(1,length(values_for_f));
fs = zeros(1,length(values_for_f));

v_f(f) = subs(r_dot_ECI_wrt_time);
r_f(f) = subs(r_ECI);
for j = 1:length(values_for_f)
    f = values_for_f(j);
    rs(:,j) = r_f(f);
    vs(:,j) = v_f(f);
    [as(j),es(j),is(j),small_omegas(j), big_omegas(j),fs(j)] = kepler_orbital_elements(rs(:,j), vs(:,j),mu); 
    %function [a,e,i,small_omega, big_omega,f] = kepler_orbital_elements(r_vector,v_vector, mu)
    j
end
perigee = r_f(0);
apogee = r_f(180*pi/180);
ascending_node = r_f(2*pi-small_omega);
%%
fig1 = figure ("Name","3D figure of the orbit trajectory along with the Earth drawing",'Position',[100 100 900 500]);
% axis equal
hold all

earth_sphere
plot3(rs(1,:),rs(2,:),rs(3,:), "LineWidth", 2, "Color", "#D95319")
plot3(perigee(1), perigee(2), perigee(3),"hexagram", "LineWidth", 2, "Color", "#0072BD")
plot3(apogee(1), apogee(2), apogee(3),"hexagram", "LineWidth", 2, "Color", "#77AC30")
plot3(ascending_node(1), ascending_node(2), ascending_node(3),"hexagram", "LineWidth", 2, "Color", "#4DBEEE")

xlabel('X [km]')
ylabel('Y [km]')
zlabel('Z [km]')
grid on
grid minor
title("3D figure of the orbit trajectory aloog with the Earth drawing")
subtitle("Almog Dobrescu 214254252")
legend({'The Earth','The orbit','perigee','apogee','ascending node'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig1, 'grap1.png','Resolution',1200);

%%

fig2 = figure ("Name","The position components in the ECI frames as functions of the true anomaly",'Position',[300 100 900 500]);
% axis equal
hold all

plot(values_for_f, rs(1,:), "LineWidth", 1.5, "Color", "#0072BD")
plot(values_for_f, rs(2,:), "LineWidth", 1.5, "Color", "#77AC30")
plot(values_for_f, rs(3,:), "LineWidth", 1.5, "Color", "#D95319")

xlabel('f [rad]')
ylabel('Magnitude [km]')

grid on
grid minor
title("The position components in the ECI frames as functions of the true anomaly")
subtitle("Almog Dobrescu 214254252")
legend({'X','Y','Z'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig2, 'grap2.png','Resolution',1200);

%%

fig3 = figure ("Name","The velocity components in the ECI frames as functions of the true anomaly",'Position',[300 100 900 500]);
% axis equal
hold all

plot(values_for_f, vs(1,:), "LineWidth", 1.5, "Color", "#0072BD")
plot(values_for_f, vs(2,:), "LineWidth", 1.5, "Color", "#77AC30")
plot(values_for_f, vs(3,:), "LineWidth", 1.5, "Color", "#D95319")

xlabel('f [rad]')
ylabel('Magnitude [km/sec]')

grid on
grid minor
title("The velocity components in the ECI frames as functions of the true anomaly")
subtitle("Almog Dobrescu 214254252")
legend({'X dot','Y dot','Z dot'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig3, 'grap3.png','Resolution',1200);

%%

fig4 = figure ("Name","The velocity components in the ECI frames as functions of the true anomaly",'Position',[300 100 900 500]);
% axis equal
hold all

plot(values_for_f, as.*10^-3, "LineWidth", 1.5, "Color", "#0072BD")
plot(values_for_f, es, "LineWidth", 1.5, "Color", "#D95319")
plot(values_for_f, is, "LineWidth", 1.5, "Color", "#EDB120")
plot(values_for_f, small_omegas,'--', "LineWidth", 1.5, "Color", "#00FF00")
plot(values_for_f, big_omegas, "LineWidth", 1.5, "Color", "#77AC30")
plot(values_for_f, fs, "LineWidth", 1.5, "Color", "#4DBEEE")

xlabel('f [rad]')
ylabel('Magnitude [-]')

grid on
grid minor
title("The velocity components in the ECI frames as functions of the true anomaly")
subtitle("Almog Dobrescu 214254252")
legend({'calculated a [10^3 km]','calculated e [-]','calculated i [rad]','calculated small omega [rad]','calculated big omega [rad]','calculated f [rad]'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig4, 'grap4.png','Resolution',1200);

