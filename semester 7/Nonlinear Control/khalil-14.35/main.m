clc; clear; close all;

time_interval = [0,100/2];
a = 1;

state = [0.1; 1; 0.1]; % [x1, x2, x3]
% This is where we integrate the equations of motion.
[t_out, state_out] = ode45(@ODE, time_interval, state, odeset('RelTol',5e-14,'AbsTol',5e-14));

figure(1)
hold all
plot(t_out, state_out(:,1))
plot(t_out, state_out(:,2))
plot(t_out, state_out(:,3))
legend({'x1','x2','x3'})

figure(2)
hold all
plot(t_out, state_out(:,1))
plot(t_out, a*sin(t_out))
legend({'x1','r'})