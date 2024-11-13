clc;
close all;

K_u = 1.2; % [-]
R_a = 2.08; % [ohm]
K_m = 24e-3; % [N*m/A]
J = 0.0051; % [kg*m^2]
K_b = 0.024; % [V*sec/rad]
L_a = 0.26e-3; % [H]
b = 0.009; % [kg*m^2/rad*sec]
N_r = 57/11; % [-]

simulation_time = 100; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 0.0001; % [sec]

u_t = 1; % [V]
T_d = 0; % [N*m]

%% Q1.3.

Q13_sim = sim("Q1sim.slx");

fig1 = figure ("Name","θ - Step Response for u(t) = 1*1(t); Td(t) = 0",'Position',[100 350 900 500]);
hold all
grid on
grid minor

plot (Q13_sim.theta.time, Q13_sim.theta.signals.values ,'LineWidth',2,'Color',"#0072BD")


title ("θ - Step Response for u(t) = 1*1(t); Td(t) = 0");
subtitle("Almog Dobrescu 214254252")
ylabel("θ(t) [rad]")
xlabel("t [sec]")
grid on
grid minor
legend({'θ(t)'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig1, '1.3grap1.png','Resolution',1200);

%% Q1.4

K_u = 1.2; % [-]
R_a = 2.08; % [ohm]
K_m = 24e-3; % [N*m/A]
J = 0.0051; % [kg*m^2]
K_b = 0.024; % [V*sec/rad]
L_a = 0; % [H]
b = 0.009; % [kg*m^2/rad*sec]
N_r = 57/11; % [-]

simulation_time = 100; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]

u_t = 1; % [V]
T_d = 0; % [N*m]

Q14_sim = sim("Q1sim.slx");

fig2 = figure ("Name","θ - Step Response for u(t) = 1*1(t); T_d(t) = 0; L_a = 0",'Position',[250 350 900 500]);
hold all
grid on
grid minor

plot (Q13_sim.theta.time, Q13_sim.theta.signals.values ,'LineWidth',2,'Color',"#0072BD")
plot (Q14_sim.theta.time, Q14_sim.theta.signals.values ,'--','LineWidth',2,'Color',"#D95319")

title ("θ - Step Response for u(t) = 1*1(t); T_d(t) = 0; L_a = 0");
subtitle("Almog Dobrescu 214254252")
ylabel("θ(t) [rad]")
xlabel("t [sec]")
legend({'θ(t), L_a = 0.26e-3', 'θ(t), L_a = 0'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig2, '1.4grap1.png','Resolution',1200);

%% Q2.1.

p = tf(0.1492,[0.01061 0.0342 0]);
mp = 0.20;
zeta = (abs(log(mp))) / sqrt(pi^2 + (abs(log(mp))^2));
ts_5 = 1;
omega_n = (log(1/0.05)) / (zeta * ts_5);

% rltool(p);

%% Q2.3.

p = tf(0.1492,[0.01061 0.0342 0]);

poles_p = pole(p);

rad2deg(atan2(4.2849,-4.2));
rad2deg(atan2(4.2849,-7.4234));

s = complex(-4.2, 4.2849);
expr = (0.1492*(s+5.3028)) / (0.01061*s^2 + 0.0342*s);
k = 1/abs(expr);

% rltool(p)

%% Q2.4.

p = tf(K_u*K_m*N_r,[J*L_a J*R_a+b*L_a b*R_a+K_b*K_m*N_r^2 0]);
c = 0.4239*tf([1 5.3028],1);
G = c*p / (1+c*p);
bandwidth(G);

%% Q2.5.

K_u = 1.2; % [-]
R_a = 2.08; % [ohm]
K_m = 24e-3; % [N*m/A]
J = 0.0051; % [kg*m^2]
K_b = 0.024; % [V*sec/rad]
L_a = 0; % [H]
b = 0.009; % [kg*m^2/rad*sec]
N_r = 57/11; % [-]

simulation_time = 100; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]

theta_ref = pi/4; % [V]
T_d = 0; % [N*m]
k_p = 2.2479;
k_d = 0.4239;

t = 0:0.01:2;

p = tf(K_u*K_m*N_r,[J*L_a J*R_a+b*L_a b*R_a+K_b*K_m*N_r^2 0]);
c = 0.4239*tf([1 5.3028],1);
G = c*p / (1+c*p);

[Q25y, Q25time] = step(G*theta_ref,t);
infoQ25 = stepinfo(G*theta_ref, "SettlingTimeThreshold",0.05);

fig3 = figure ("Name","θ - Step Response for θ_ref = π/4*1(t); T_d(t) = 0; L_a = 0",'Position',[400 350 900 500]);
hold all
grid on
grid minor

plot(Q25time, Q25y,'LineWidth',2,'Color',"#0072BD")

title ("θ - Step Response for θ_ref = π/4*1(t); T_d(t) = 0; L_a = 0");
subtitle("Almog Dobrescu 214254252    ")
ylabel("θ(t) [rad]")
xlabel("t [sec]")
legend({'θ(t)'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig3, '2.5grap1.png','Resolution',1200);

%%

K_u = 1.2; % [-]
R_a = 2.08; % [ohm]
K_m = 24e-3; % [N*m/A]
J = 0.0051; % [kg*m^2]
K_b = 0.024; % [V*sec/rad]
L_a = 0; % [H]
b = 0.009; % [kg*m^2/rad*sec]
N_r = 57/11; % [-]

simulation_time = 100; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]

theta_ref = pi/4; % [V]
T_d = 0; % [N*m]
k_p = 2.2479;
k_d = 0.4239;

t = 0:0.01:2;

p = tf(K_u*K_m*N_r,[J*L_a J*R_a+b*L_a b*R_a+K_b*K_m*N_r^2 0]);
c = 0.4239*tf([1 5.3028],1);
G = 1 / (1+c*p);

[Q251y, Q251time] = step(G*theta_ref,t);

fig4 = figure ("Name","e - Step Response for θ_ref = π/4*1(t); T_d(t) = 0; L_a = 0",'Position',[550 350 900 500]);
hold all
grid on
grid minor

plot(Q251time, Q251y,'LineWidth',2,'Color',"#0072BD")

title ("e - Step Response for θ_ref = π/4*1(t); T_d(t) = 0; L_a = 0");
subtitle("Almog Dobrescu 214254252    ")
ylabel("e(t) [rad]")
xlabel("t [sec]")
legend({'e(t)'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig4, '2.5grap2.png','Resolution',1200);

%%

K_u = 1.2; % [-]
R_a = 2.08; % [ohm]
K_m = 24e-3; % [N*m/A]
J = 0.0051; % [kg*m^2]
K_b = 0.024; % [V*sec/rad]
L_a = 0; % [H]
b = 0.009; % [kg*m^2/rad*sec]
N_r = 57/11; % [-]

simulation_time = 2.5; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 0.0001; % [sec]

theta_ref = pi/4; % [V]
T_d = 0; % [N*m]
k_p = 2.2479;
k_d = 0.4239;
t = simulation_start_time:integration_step_time:simulation_time;

p = tf(K_u*K_m*N_r,[J*L_a J*R_a+b*L_a b*R_a+K_b*K_m*N_r^2 0]);
poles_p = pole(p);
epsilon = 1/abs(poles_p(2)*75);

Q26_sim = sim("Q2sim.slx");

pure_c = 0.4239*tf([1 5.3028],1);
pure_G = pure_c*p / (1+pure_c*p);

psudo_c = k_p + tf([k_d 1], [epsilon 1]);
psudo_G = psudo_c*p / (1+psudo_c*p);

[Q25y, Q25time] = step(pure_G*theta_ref,t);

fig5 = figure ("Name","θ - Step Response for θ_ref = π/4*1(t); T_d(t) = 0; L_a = 0",'Position',[700 350 900 500]);
hold all
grid on
grid minor

plot(Q25time, Q25y,'LineWidth',2,'Color',"#0072BD")
plot (Q26_sim.theta.time, Q26_sim.theta.signals.values ,'--','LineWidth',2,'Color',"#D95319")

title ("θ - Step Response for θ_ref = π/4*1(t); T_d(t) = 0; L_a = 0");
subtitle("Almog Dobrescu 214254252")
ylabel("θ(t) [rad]")
xlabel("t [sec]")
legend({'θ(t), pure PD', 'θ(t), pseudo PD'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig5, '2.6grap1.png','Resolution',1200);


pure_G = 1 / (1+pure_c*p);
[Q25y2, Q25time2] = step(pure_G*theta_ref,t);

fig6 = figure ("Name","e - Step Response for θ_ref = π/4*1(t); T_d(t) = 0; L_a = 0",'Position',[100 200 900 500]);
hold all
grid on
grid minor

plot(Q25time2, Q25y2,'LineWidth',2,'Color',"#0072BD")
plot (Q26_sim.e_output.time, Q26_sim.e_output.signals.values ,'--','LineWidth',2,'Color',"#D95319")

title ("e - Step Response for θ_ref = π/4*1(t); T_d(t) = 0; L_a = 0");
subtitle("Almog Dobrescu 214254252")
ylabel("e(t) [rad]")
xlabel("t [sec]")
legend({'e(t), pure PD', 'e(t), pseudo PD'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig6, '2.6grap2.png','Resolution',1200);

fig7 = figure ("Name","u - Step Response for θ_ref = π/4*1(t); T_d(t) = 0; L_a = 0",'Position',[250 200 900 500]);
hold all
grid on
grid minor

plot (Q26_sim.u_output.time, Q26_sim.u_output.signals.values ,'LineWidth',2,'Color',"#D95319")

title ("u - Step Response for θ_ref = π/4*1(t); T_d(t) = 0; L_a = 0");
subtitle("Almog Dobrescu 214254252")
ylabel("u(t) [V]")
xlabel("t [sec]")
legend({'u(t), pseudo PD'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig7, '2.6grap3.png','Resolution',1200);

%% 

K_u = 1.2; % [-]
R_a = 2.08; % [ohm]
K_m = 24e-3; % [N*m/A]
J = 0.0051; % [kg*m^2]
K_b = 0.024; % [V*sec/rad]
L_a = 0; % [H]
b = 0.009; % [kg*m^2/rad*sec]
N_r = 57/11; % [-]
zeta = sqrt(2)/2;
omega_n = 60; % [rad/sec]

simulation_time = 2.5; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 0.0001; % [sec]

theta_ref = pi/4; % [V]
T_d = 0; % [N*m]
k_p = 2.2479;
k_d = 0.4239;
t = simulation_start_time:integration_step_time:simulation_time;

p = tf(K_u*K_m*N_r,[J*L_a J*R_a+b*L_a b*R_a+K_b*K_m*N_r^2 0]);
poles_p = pole(p);
epsilon = 1/abs(poles_p(2)*75);

Q27_sim = sim("Q27sim.slx");
infoQ27 = stepinfo(Q27_sim.theta.signals.values,Q27_sim.theta.time,'SettlingTimeThreshold',0.05);

fig8 = figure ("Name","Step Response for θ_ref = π/4*1(t) with Pre-Filter",'Position',[400 200 900 500]);
hold all
grid on
grid minor

plot (Q27_sim.theta.time, Q27_sim.theta.signals.values ,'LineWidth',2,'Color',"#0072BD")
plot (Q27_sim.e_output.time, Q27_sim.e_output.signals.values ,'LineWidth',2,'Color',"#D95319")
plot (Q27_sim.u_output.time, Q27_sim.u_output.signals.values ,'-.','LineWidth',2,'Color',"#7E2F8E")

title ("Step Response for θ_ref = π/4*1(t) with Pre-Filter");
subtitle("Almog Dobrescu 214254252")
ylabel("Amplitude")
xlabel("t [sec]")
legend({'θ(t)', 'e(t)', 'u(t)'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig8, '2.7grap1.png','Resolution',1200);
