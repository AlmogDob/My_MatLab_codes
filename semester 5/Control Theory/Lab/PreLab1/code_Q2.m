clc;

simulation_time_start = 1; % [sec]
simulation_time_end = 12; % [sec]
simulation_time_step = 0.0001; % [sec]
K_u = 1.2; % [-]
R_a = 2.2; % [ohm]
K_m = 24e-3; % [N*m/A]
J = 0.005; % [kg*m^2]
K_b = 0.024; % [V*s/rad]
L_a = 0.26e-3; % [H]
b = 0.0043; % [kg*m^2/rad*s]
N_r = 4.9;
T_d = 0; % [N*m]
u = 7; % [V]
K_p = 1;
theta_ref = pi/4; % [rad]

% sim('simulation.slx');

%%

theta_t = ans.theta.time;
theta_values = ans.theta.signals.values;

fig1 = figure ("Name","θ - Step Response for u(t) = 7*1(t); Td(t) = 0",'Position',[100 350 900 500]);
hold all
grid on
grid minor

plot(theta_t, theta_values ,'LineWidth',2,'Color',"#7E2F8E")

title ("θ - Step Response for u(t) = 7*1(t); Td(t) = 0");
subtitle("Almog Dobrescu 214254252")
ylabel("θ(t) [rad]")
xlabel("t [sec]")
grid on
grid minor
legend({'Step Response for u(t) = 7*1(t); Td(t) = 0'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig1, '2.1grap1.png','Resolution',1200);

%%

omega_t = ans.omega.time;
omega_values = ans.omega.signals.values;

fig2 = figure ("Name","ω - Step Response for u(t) = 7*1(t); Td(t) = 0",'Position',[400 350 900 500]);
hold all
grid on
grid minor

plot(omega_t, omega_values ,'LineWidth',2,'Color',"#7E2F8E")

title ("ω - Step Response for u(t) = 7*1(t); Td(t) = 0");
subtitle("Almog Dobrescu 214254252")
ylabel("ω(t) [rad]")
xlabel("t [sec]")
grid on
grid minor
legend({'Step Response for u(t) = 7*1(t); Td(t) = 0'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig2, '2.1grap2.png','Resolution',1200);

%%

omega_over_u_roots = roots([J*L_a J*R_a+b*L_a R_a*b+N_r^2*K_m*K_b]);

%% Q.2.2
K_p = 1;
sim('simulation.slx');

theta_t = ans.theta.time;
theta_values = ans.theta.signals.values;

fig3 = figure ("Name","θ - Step Response for θref(t) = π/4*1(t); Td(t) = 0; kp = 1",'Position',[700 350 900 500]);
hold all
grid on
grid minor

plot(theta_t, theta_values ,'LineWidth',2,'Color',"#7E2F8E")
%plot(theta_t, ones(length(theta_t),1).*(pi/4),'LineWidth',1,'Color',"#A2142F");

title ("θ - Step Response for θref(t) = π/4*1(t); Td(t) = 0; kp = 1");
subtitle("Almog Dobrescu 214254252")
ylabel("θ(t) [rad]")
xlabel("t [sec]")
grid on
grid minor
legend({'Step Response for θref(t) = π/4*1(t); Td(t) = 0; kp = 1','π/4'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig3, '2.2grap1.png','Resolution',1200);

%%

K_p = 0.5;
sim('simulation.slx');

theta_t = ans.theta.time;
theta_values = ans.theta.signals.values;

fig4 = figure ("Name","θ - Step Response for θref(t) = π/4*1(t); Td(t) = 0; kp = 0.5",'Position',[100 150 900 500]);
hold all
grid on
grid minor

plot(theta_t, theta_values ,'LineWidth',2,'Color',"#7E2F8E")
%plot(theta_t, ones(length(theta_t),1).*(pi/4),'LineWidth',1,'Color',"#A2142F");

title ("θ - Step Response for θref(t) = π/4*1(t); Td(t) = 0; kp = 0.5");
subtitle("Almog Dobrescu 214254252")
ylabel("θ(t) [rad]")
xlabel("t [sec]")
grid on
grid minor
legend({'Step Response for θref(t) = π/4*1(t); Td(t) = 0; kp = 0.5','π/4'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig4, '2.2grap2.png','Resolution',1200);

%%
clc;
format long

temp = figure;
max_num = 1;
min_num = 0.1;
step_size = 0.1;
K_p_s = min_num:step_size:max_num;
num_of_interation = (max_num - min_num)/step_size + 1
for index = 1:num_of_interation
    %disp(K_p_s(index));
    K_p = K_p_s(index);
    sim('simulation.slx');
    theta_values = ans.theta.signals.values;
    theta_t = ans.theta.time;
    M_p = (max(theta_values) - pi/4)/(pi/4)
    plot(theta_t, theta_values)
    if M_p >= 0.2 
        my_K_p = K_p_s(index);
        disp("kp is: " + my_K_p);
        break
    end
end

%%

K_p = my_K_p;

sim('simulation.slx');

u_t = ans.u.time;
u_values = ans.u.signals.values;

fig5 = figure ("Name","u - Step Response for θref(t) = π/4*1(t); Td(t) = 0; kp = 0.4201",'Position',[400 150 900 500]);
hold all
grid on
grid minor

plot(u_t, u_values ,'LineWidth',2,'Color',"#7E2F8E")

title ("u - Step Response for θref(t) = π/4*1(t); Td(t) = 0; kp = 0.4201");
subtitle("Almog Dobrescu 214254252")
ylabel("u(t) [rad]")
xlabel("t [sec]")
grid on
grid minor
legend({'Step Response for θref(t) = π/4*1(t); Td(t) = 0; kp = 0.4201'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig5, '2.2grap3.png','Resolution',1200);

theta_t = ans.theta.time;
theta_values = ans.theta.signals.values;

fig6 = figure ("Name","θ - Step Response for θref(t) = π/4*1(t); Td(t) = 0; kp = 0.4201",'Position',[700 150 900 500]);
hold all
grid on
grid minor

plot(theta_t, theta_values ,'LineWidth',2,'Color',"#7E2F8E")

title ("θ - Step Response for θref(t) = π/4*1(t); Td(t) = 0; kp = 0.4201");
subtitle("Almog Dobrescu 214254252")
ylabel("θ(t) [rad]")
xlabel("t [sec]")
grid on
grid minor
legend({'Step Response for θref(t) = π/4*1(t); Td(t) = 0; kp = 0.4201'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig6, '2.2grap4.png','Resolution',1200);

