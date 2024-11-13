%% 1.d.i

% Initial Conditions
r_0 = [-3500; 7600; 0]; % [km]
v_0 = [-1.8; -2.0339; 6.2]; % [km/sec]
planet

state_initial = [r_0; v_0];

time_in_minutes = 20;
time_interval = [0 time_in_minutes*60];

% This is where we integrate the equations of motion.
[t_out, state_out] = ode45(@Satellite, time_interval, state_initial,odeset('RelTol',1e-5));


r_20_min = [state_out(end,1);state_out(end,2);state_out(end,3)]
v_20_min = [state_out(end,4);state_out(end,5);state_out(end,6)]