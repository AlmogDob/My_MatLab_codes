clc; clear; close all;

%% Q1_1
x0_vec_Q1_1 = [0.2;0.6];

state = [x0_vec_Q1_1;x0_vec_Q1_1;x0_vec_Q1_1]; % [Feedback; Backstepping; Lyapunov]
time_interval = [0:0.005:15];

 % This is where we integrate the equations of motion.
[t_out, state_out] = ode45(@SolverQ1_1, time_interval, state, odeset('RelTol',5e-14,'AbsTol',5e-14));

x_vec_Q1_1_Feedback = state_out(:, 1:2);
x_vec_Q1_1_Backstepping = state_out(:, 3:4);
x_vec_Q1_1_Lyapunov = state_out(:, 5:6);

u_Q1_1_Feedback = [];
u_Q1_1_Backstepping = [];
u_Q1_1_Lyapunov = [];
for i = 1:length(t_out)

    u_Q1_1_Feedback(i) = Q1_1_Feedback_controller(x_vec_Q1_1_Feedback(i,1), x_vec_Q1_1_Feedback(i,2));
    u_Q1_1_Backstepping(i) = Q1_1_Backstepping_controller(x_vec_Q1_1_Backstepping(i,1), x_vec_Q1_1_Backstepping(i,2));
    u_Q1_1_Lyapunov(i) = Q1_1_Lyapunov_controller(x_vec_Q1_1_Lyapunov(i,1), x_vec_Q1_1_Lyapunov(i,2));
end

fig1 = figure ("Name","1",'Position',[100 200 900 600]);
sgtitle(sprintf("First system: x1=%g | x2=%g - AVISHAG DVIR - 214039653", x0_vec_Q1_1(1), x0_vec_Q1_1(2)))
colors = hsv(3)*0.92;

subplot(3,1,1)
plot(t_out, x_vec_Q1_1_Feedback(:, 1), "LineWidth", 1, "Color", colors(1,:))
hold all
plot(t_out, x_vec_Q1_1_Feedback(:, 2), "LineWidth", 1, "Color", colors(2,:))
plot(t_out, u_Q1_1_Feedback, '--', "LineWidth", 1, "Color", colors(3,:))
xlabel('t [sec]')
ylabel('Magnitude [-]')
grid on
grid minor
title("Feedback Linearization")
legend({'x1', 'x2', 'u'},'FontSize',11 ,'Location','southeast')

subplot(3,1,2)
plot(t_out, x_vec_Q1_1_Backstepping(:, 1), "LineWidth", 1, "Color", colors(1,:))
hold all
plot(t_out, x_vec_Q1_1_Backstepping(:, 2), "LineWidth", 1, "Color", colors(2,:))
plot(t_out, u_Q1_1_Backstepping, '--', "LineWidth", 1, "Color", colors(3,:))
xlabel('t [sec]')
ylabel('Magnitude [-]')
grid on
grid minor
title("Backstepping")
legend({'x1', 'x2', 'u'},'FontSize',11 ,'Location','southeast')

subplot(3,1,3)
plot(t_out, x_vec_Q1_1_Lyapunov(:, 1), "LineWidth", 1, "Color", colors(1,:))
hold all
plot(t_out, x_vec_Q1_1_Lyapunov(:, 2), "LineWidth", 1, "Color", colors(2,:))
plot(t_out, u_Q1_1_Lyapunov, '--', "LineWidth", 1, "Color", colors(3,:))
xlabel('t [sec]')
ylabel('Magnitude [-]')
grid on
grid minor
title("Lyapunov")
legend({'x1', 'x2', 'u'},'FontSize',11 ,'Location','southeast')
% exportgraphics(fig1, 'graph1.png','Resolution',300);

%% Q1_2
x0_vec_Q1_2 = [0.2;0.6];

state = [x0_vec_Q1_2;x0_vec_Q1_2;x0_vec_Q1_2]; % [Feedback; Backstepping; Lyapunov]
time_interval = [0:0.005:15];

 % This is where we integrate the equations of motion.
[t_out, state_out] = ode45(@SolverQ1_2, time_interval, state, odeset('RelTol',5e-14,'AbsTol',5e-14));

x_vec_Q1_2_Feedback = state_out(:, 1:2);
x_vec_Q1_2_Backstepping = state_out(:, 3:4);
x_vec_Q1_2_Lyapunov = state_out(:, 5:6);

u_Q1_2_Feedback = [];
u_Q1_2_Backstepping = [];
u_Q1_2_Lyapunov = [];
for i = 1:length(t_out)

    u_Q1_2_Feedback(i) = Q1_2_Feedback_controller(x_vec_Q1_2_Feedback(i,1), x_vec_Q1_2_Feedback(i,2));
    u_Q1_2_Backstepping(i) = Q1_2_Backstepping_controller(x_vec_Q1_2_Backstepping(i,1), x_vec_Q1_2_Backstepping(i,2));
    u_Q1_2_Lyapunov(i) = Q1_2_Lyapunov_controller(x_vec_Q1_2_Lyapunov(i,1), x_vec_Q1_2_Lyapunov(i,2));
end

fig2 = figure ("Name","2",'Position',[700 200 900 600]);
sgtitle(sprintf("Second system: x1=%g | x2=%g - AVISHAG DVIR - 214039653", x0_vec_Q1_2(1), x0_vec_Q1_2(2)))
colors = hsv(3)*0.92;

subplot(3,1,1)
plot(t_out, x_vec_Q1_2_Feedback(:, 1), "LineWidth", 1, "Color", colors(1,:))
hold all
plot(t_out, x_vec_Q1_2_Feedback(:, 2), "LineWidth", 1, "Color", colors(2,:))
plot(t_out, u_Q1_2_Feedback, '--', "LineWidth", 1, "Color", colors(3,:))
xlabel('t [sec]')
ylabel('Magnitude [-]')
grid on
grid minor
title("Feedback Linearization")
legend({'x1', 'x2', 'u'},'FontSize',11 ,'Location','southeast')

subplot(3,1,2)
plot(t_out, x_vec_Q1_2_Backstepping(:, 1), "LineWidth", 1, "Color", colors(1,:))
hold all
plot(t_out, x_vec_Q1_2_Backstepping(:, 2), "LineWidth", 1, "Color", colors(2,:))
plot(t_out, u_Q1_2_Backstepping, '--', "LineWidth", 1, "Color", colors(3,:))
xlabel('t [sec]')
ylabel('Magnitude [-]')
grid on
grid minor
title("Backstepping")
legend({'x1', 'x2', 'u'},'FontSize',11 ,'Location','southeast')

subplot(3,1,3)
plot(t_out, x_vec_Q1_2_Lyapunov(:, 1), "LineWidth", 1, "Color", colors(1,:))
hold all
plot(t_out, x_vec_Q1_2_Lyapunov(:, 2), "LineWidth", 1, "Color", colors(2,:))
plot(t_out, u_Q1_2_Lyapunov, '--', "LineWidth", 1, "Color", colors(3,:))
xlabel('t [sec]')
ylabel('Magnitude [-]')
grid on
grid minor
title("Lyapunov")
legend({'x1', 'x2', 'u'},'FontSize',11 ,'Location','southeast')
% exportgraphics(fig2, 'graph2.png','Resolution',300);

%% Q2

x0_vec_Q2 = [-0.1; 0.4; -0.04];

global_variable

state_Q2 = [x0_vec_Q2];
time_interval_Q2 = [0:0.005:30];

 % This is where we integrate the equations of motion.
[t_out_Q2, state_out_Q2] = ode45(@SolverQ2, time_interval_Q2, state_Q2, odeset('RelTol',5e-10,'AbsTol',5e-10));

u_Q2 = [];
e = [];
for i = 1:length(t_out_Q2)
    u_Q2(i) = Q2_controller(t_out_Q2(i), omega, state_out_Q2(i,1), state_out_Q2(i,2), state_out_Q2(i,3));
    xi1 = state_out_Q2(i,1);
    xi2 = state_out_Q2(i,2); 
    xi3 = 1 - 4 * state_out_Q2(i,3).^2 ./ (1 + state_out_Q2(i,1)).^2;
    t = t_out_Q2(i);
    r = 0.2 * sin(omega * t);
    r_dot = 0.2 * omega * cos(omega * t);
    r_dot_dot = -0.2 * omega^2 * sin(omega * t);
    e1 = xi1 - r;
    e2 = xi2 - r_dot;
    e3 = xi3 - r_dot_dot;
    e(i, :) = [e1, e2, e3];
end

fig3 = figure ("Name","3",'Position',[500 100 900 600]);
sgtitle(sprintf("Question 2: x1=%g | x2=%g | x3=%g - AVISHAG DVIR - 214039653", x0_vec_Q2(1), x0_vec_Q2(2), x0_vec_Q2(3)))
colors = hsv(4)*0.8;

subplot(3,1,1)
plot(t_out_Q2, state_out_Q2(:, 1), "LineWidth", 1, "Color", colors(1,:))
hold all
plot(t_out_Q2, state_out_Q2(:, 2), "LineWidth", 1, "Color", colors(2,:))
plot(t_out_Q2, state_out_Q2(:, 3), "LineWidth", 1, "Color", colors(3,:))
plot(t_out_Q2, u_Q2, '--', "LineWidth", 1, "Color", colors(4,:))
xlabel('t [sec]')
ylabel('Magnitude [-]')
ylim([-6,1])
grid on
grid minor
title("System respons")
legend({'x1', 'x2', 'x3', 'u'},'FontSize',11 ,'Location','southeast')

subplot(3,1,2)
plot(t_out_Q2, state_out_Q2(:, 1), "LineWidth", 1, "Color", colors(1,:))
hold all
plot(t_out_Q2, 0.2*sin(omega*t_out_Q2), '--', "LineWidth", 1, "Color", colors(4,:))
xlabel('t [sec]')
ylabel('Magnitude [-]')
grid on
grid minor
title("System respons")
legend({'y', 'r'},'FontSize',11 ,'Location','southeast')

subplot(3,1,3)
for i = 1:length(t_out_Q2)
    if (norm(e(i,:)) < 0.01*norm(e(1,:)))
        break
    end
end
plot(t_out_Q2, (e(:, 1).^2 + e(:, 2).^2 + e(:, 3).^2).^0.5, "LineWidth", 1, "Color", colors(2,:))
hold all
plot(t_out_Q2(i)*ones(length(linspace(-1.5,1.5))), linspace(-1.5,1.5),'--', "LineWidth", 1, "Color", colors(4,:))
xlabel('t [sec]')
ylabel('Magnitude [-]')
grid on
grid minor
title("Error as a function of time | 0.01%")
legend({'e'},'FontSize',11 ,'Location','southeast')
% exportgraphics(fig3, 'graph3.png','Resolution',300);