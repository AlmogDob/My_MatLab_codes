%% A
clc; clear;

global_variabels

pos0_vec = [0;-1;1]; %[km]
v0_vec = [0;0;-0.74267*n]; %[km/sec]
% v0_vec = [0;5.000000000000000e-04;-5.000000000000000e-04]; %[km/sec]
posf_vec = [0;0;0];
vf_vec = [0;0;0];

x0_vec = [pos0_vec(1);v0_vec(1);pos0_vec(2);v0_vec(2);pos0_vec(3);v0_vec(3)];
xf_vec = [posf_vec(1);vf_vec(1);posf_vec(2);vf_vec(2);posf_vec(3);vf_vec(3)];
t_f = 2000;

rpos0_vec = pos0_vec;
rv0_vec = (posf_vec-pos0_vec)./t_f;

xr0_vec = [rpos0_vec(1);rv0_vec(1);rpos0_vec(2);rv0_vec(2);rpos0_vec(3);rv0_vec(3)];

state = [x0_vec;xr0_vec];
time_interval = [0, t_f];

 % This is where we integrate the equations of motion.
[t_out, state_out] = ode45(@Satellite, time_interval, state, odeset('RelTol',1e-6,'AbsTol',1e-6));

miss_distance = norm([state_out(end,1),state_out(end,2),state_out(end,3)]);
miss_velocity = norm([state_out(end,4),state_out(end,5),state_out(end,6)]);

plot3(state_out(:,1),state_out(:,3),state_out(:,5), "LineWidth", 2, "Color", "#7E2F8E")
hold on
plot3(state_out(:,7),state_out(:,9),state_out(:,11), "LineWidth", 2, "Color", "r")
xlabel("x")
ylabel("y")
zlabel("z")
% plot3([state_out(1,1), state_out(end,1)], [state_out(1,2), state_out(end,2)], [state_out(1,3), state_out(end,3)])


