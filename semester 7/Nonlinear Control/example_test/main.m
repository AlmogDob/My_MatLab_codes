clc; clear; close all;

time_interval = 0:0.0001:20;

state = [4; 1; 0.1; 0.01]; % [x1, x2, x3, x4]
% This is where we integrate the equations of motion.
[t_out, state_out] = ode45(@ODE, time_interval, state, odeset('RelTol',5e-14,'AbsTol',5e-14));

hold all
plot(t_out, state_out(:,3))
plot(t_out, state_out(:,4))

