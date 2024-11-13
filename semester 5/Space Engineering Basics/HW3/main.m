%% Q1.1.i
clc;
close all;

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_1_i = sim("simulink_modelQ1.slx");

[x_sphere, y_sphere, z_sphere] = sphere(30);
x_sphere = x_sphere*R_E;
y_sphere = y_sphere*R_E;
z_sphere = z_sphere*R_E;

fig1 = figure ("Name","The Orbit of the Satellite",'Position',[100 350 900 500]);
hold all
grid on
axis equal

plot3(simQ1_1_i.x.signals.values, simQ1_1_i.y.signals.values, simQ1_1_i.z.signals.values, "LineWidth",2, "Color","#7E2F8E")
s = surf(x_sphere, y_sphere, z_sphere, EdgeColor="none");

title ("The Orbit of the Satellite");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("y [km]")
xlabel("x [km]")
zlabel("z [km]")

legend({'The Orbit'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig1, 'Q1.1grap1.png','Resolution',1200);
disp("Finished Q.1.1.i")
%% Q1.1.ii

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_1_ii = sim("simulink_modelQ1.slx");
r = [simQ1_1_ii.x.signals.values, simQ1_1_ii.y.signals.values, simQ1_1_ii.z.signals.values];
v = [simQ1_1_ii.x_dot.signals.values, simQ1_1_ii.y_dot.signals.values, simQ1_1_ii.z_dot.signals.values];

epsilon = zeros(length(simQ1_1_ii.x.signals.values),1);
for i = 1:length(simQ1_1_ii.x.signals.values)
    epsilon(i) = norm(v(i,:))^2/2 - myu/norm(r(i,:));
end

fig2 = figure ("Name","The Specific Orbital Energy of the Satellite as a Function of Time",'Position',[250 350 900 500]);
hold all
grid on
grid minor

plot(simQ1_1_ii.x.time,epsilon, "LineWidth",2, "Color","#7E2F8E"); 

title ("The Specific Orbital Energy of the Satellite as a Function of Time");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("epsilon(t) [km^2/sec^2]")
xlabel("t [sec]")

legend({'epsilon(t)'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig2, 'Q1.1grap2.png','Resolution',1200);
disp("Finished Q.1.1.ii")
%% Q1.1.iii

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_1_iii = sim("simulink_modelQ1.slx");
r = [simQ1_1_iii.x.signals.values, simQ1_1_iii.y.signals.values, simQ1_1_iii.z.signals.values];
v = [simQ1_1_iii.x_dot.signals.values, simQ1_1_iii.y_dot.signals.values, simQ1_1_iii.z_dot.signals.values];

h = zeros(length(simQ1_1_iii.x.signals.values),3);
for i = 1:length(simQ1_1_iii.x.signals.values)
    h(i,:) = cross(r(i,:), v(i,:));
    i;
end
magintude_h = zeros(length(simQ1_1_iii.x.signals.values),1);
for i = 1:length(simQ1_1_iii.x.signals.values)
    magintude_h(i) = norm(h(i,:));
    i;
end

fig3 = figure ("Name","The Specific Angular Momentum of the Satellite as a Function of Time",'Position',[400 350 900 500]);
hold all
grid on
grid minor

plot(simQ1_1_iii.x.time,magintude_h, "LineWidth",2, "Color","#7E2F8E"); 

title ("The Specific Angular Momentum of the Satellite as a Function of Time");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("h(t) [km^2/sec]")
xlabel("t [sec]")

legend({'h(t)'},'FontSize',11 ,'Location','southeast')
% exportgraphics(fig3, 'Q1.1grap3.png','Resolution',1200);
disp("Finished Q.1.1.iii")
%% Q1.1.iv

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_1_iv = sim("simulink_modelQ1.slx");
r = [simQ1_1_iv.x.signals.values, simQ1_1_iv.y.signals.values, simQ1_1_iv.z.signals.values];
v = [simQ1_1_iv.x_dot.signals.values, simQ1_1_iv.y_dot.signals.values, simQ1_1_iv.z_dot.signals.values];

magintude_r = zeros(length(simQ1_1_iv.x.signals.values),1);
for i = 1:length(simQ1_1_iv.x.signals.values)
    magintude_r(i) = norm(r(i,:));
    i;
end

fig4 = figure ("Name","The Magnitude of r as a Function of Time",'Position',[550 350 900 500]);
hold all
grid on
grid minor

plot(simQ1_1_iv.x.time,magintude_r, "LineWidth",1.5, "Color","#7E2F8E"); 

title ("The Magnitude of r as a Function of Time");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("r(t) [km]")
xlabel("t [sec]")

legend({'r(t)'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig4, 'Q1.1grap4.png','Resolution',1200);
disp("Finished Q.1.1.iv")
%% Q1.1.v

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_1_v = sim("simulink_modelQ1.slx");
r = [simQ1_1_v.x.signals.values, simQ1_1_v.y.signals.values, simQ1_1_v.z.signals.values];
v = [simQ1_1_v.x_dot.signals.values, simQ1_1_v.y_dot.signals.values, simQ1_1_v.z_dot.signals.values];

magintude_v = zeros(length(simQ1_1_v.x.signals.values),1);
for i = 1:length(simQ1_1_v.x.signals.values)
    magintude_v(i) = norm(v(i,:));
    i;
end

fig5 = figure ("Name","The Magnitude of v as a Function of Time",'Position',[700 350 900 500]);
hold all
grid on
grid minor

plot(simQ1_1_v.x.time,magintude_v, "LineWidth",1.5, "Color","#7E2F8E"); 

title ("The Magnitude of v as a Function of Time");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("v(t) [km/sec]")
xlabel("t [sec]")

legend({'v(t)'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig5, 'Q1.1grap5.png','Resolution',1200);
disp("Finished Q.1.1.v")
%% Q1.1.vi

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_1_vi = sim("simulink_modelQ1.slx");
r = [simQ1_1_vi.x.signals.values, simQ1_1_vi.y.signals.values, simQ1_1_vi.z.signals.values];
v = [simQ1_1_vi.x_dot.signals.values, simQ1_1_vi.y_dot.signals.values, simQ1_1_vi.z_dot.signals.values];

h = zeros(length(simQ1_1_vi.x.signals.values),3);
% for i = 1:length(simQ1_1_vi.x.signals.values)
%     h(i,:) = cross(r(i,:), v(i,:));
%     i
% end

phi = zeros(length(simQ1_1_vi.x.signals.values),1);
for i = 1:length(simQ1_1_vi.x.signals.values)
    h(i,:) = cross(r(i,:), v(i,:));
    phi(i) = acos(norm(h(i,:)/(norm(r(i,:)*norm(v(i,:))))));
    if dot(r(i,:), v(i,:)) < 0
        phi(i) = -phi(i);
    end
    i;
end

fig6 = figure ("Name","The flight path angle φ as a Function of Time",'Position',[100 200 900 500]);
hold all
grid on
grid minor

plot(simQ1_1_vi.x.time,phi, "LineWidth",1.5, "Color","#7E2F8E"); 

title ("The flight path angle φ as a Function of Time");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("φ(t) [rad]")
xlabel("t [sec]")

legend({'φ(t)'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig6, 'Q1.1grap6.png','Resolution',1200);
disp("Finished Q.1.1.vi")
%% Q.1.vii

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_1_vii = sim("simulink_modelQ1.slx");
r = [simQ1_1_vii.x.signals.values, simQ1_1_vii.y.signals.values, simQ1_1_vii.z.signals.values];
v = [simQ1_1_vii.x_dot.signals.values, simQ1_1_vii.y_dot.signals.values, simQ1_1_vii.z_dot.signals.values];

h = zeros(length(simQ1_1_vii.x.signals.values),3);
epsilon = zeros(length(simQ1_1_vii.x.signals.values),1);
magintude_h = zeros(length(simQ1_1_vii.x.signals.values),1);
for i = 1:length(simQ1_1_vii.x.signals.values)
    h(i,:) = cross(r(i,:), v(i,:));
    magintude_h(i) = norm(h(i,:));
    epsilon(i) = norm(v(i,:))^2/2 - myu/norm(r(i,:));
    i;
end

epsilon_avg = sum(epsilon)/length(epsilon);
magintude_h_avg = sum(magintude_h)/length(magintude_h);

a = -myu/(2*epsilon_avg);
e = sqrt(1+(2*epsilon_avg*magintude_h_avg^2)/(myu^2));
disp("Finished Q.1.1.vii")
%% Q1.1

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

integration_step_time_vector = [300, 200, 100, 50, 10, 1, 0.1];
colors = ["#0072BD", "#D95319", "#EDB120", "#7E2F8E", "#77AC30", "#4DBEEE", "#A2142F"];

fig7 = figure ("Name","Convergence Check for Orbital Energy of the Satellite",'Position',[250 200 900 500]);
hold all
grid on
grid minor

for index = 1:length(integration_step_time_vector)
    integration_step_time = integration_step_time_vector(index);
    simQ1_1 = sim("simulink_modelQ1.slx");

    r = [simQ1_1.x.signals.values, simQ1_1.y.signals.values, simQ1_1.z.signals.values];
    v = [simQ1_1.x_dot.signals.values, simQ1_1.y_dot.signals.values, simQ1_1.z_dot.signals.values];
    
    epsilon = zeros(length(simQ1_1.x.signals.values),1);
    for i = 1:length(simQ1_1.x.signals.values)
        epsilon(i) = norm(v(i,:))^2/2 - myu/norm(r(i,:));
    end

    if index == 6
        plot(simQ1_1.x.time,epsilon,"--", "LineWidth",1.5, "Color",colors(index)); 
    elseif index == 7
        plot(simQ1_1.x.time,epsilon,":", "LineWidth",1.5, "Color",colors(index)); 
    else
        plot(simQ1_1.x.time,epsilon, "LineWidth",1.5, "Color",colors(index));
    end
end
title ("Convergence Check for Orbital Energy of the Satellite");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("epsilon(t) [km^2/sec^2]")
xlabel("t [sec]")

legend({'Integration Step Time = 300', 'Integration Step Time = 200', 'Integration Step Time = 100', 'Integration Step Time = 50', 'Integration Step Time = 10', 'Integration Step Time = 1', 'Integration Step Time = 0.1'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig7, 'Q1.1grap7.png','Resolution',1200);
disp("Finished Q.1.1")

%% Q1.2.i

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]
J_2 = 1.082e-3; % [-]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_2_i = sim("simulink_modelQ1_2.slx");

r = [simQ1_2_i.x.signals.values, simQ1_2_i.y.signals.values, simQ1_2_i.z.signals.values];
v = [simQ1_2_i.x_dot.signals.values, simQ1_2_i.y_dot.signals.values, simQ1_2_i.z_dot.signals.values];

[x_sphere, y_sphere, z_sphere] = sphere(30);
x_sphere = x_sphere*R_E;
y_sphere = y_sphere*R_E;
z_sphere = z_sphere*R_E;

fig8 = figure ("Name","The Orbit of the Satellite - No Perfect Sphere",'Position',[400 200 900 500]);
hold all
grid on
axis equal

plot3(simQ1_2_i.x.signals.values, simQ1_2_i.y.signals.values, simQ1_2_i.z.signals.values, "LineWidth",0.5, "Color","#7E2F8E")
s = surf(x_sphere, y_sphere, z_sphere, EdgeColor="none");

title ("The Orbit of the Satellite - No Perfect Sphere");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("y [km]")
xlabel("x [km]")
zlabel("z [km]")

legend({'The Orbit - No Perfect Sphere'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig8, 'Q1.2grap1.png','Resolution',1200);
disp("Finished Q.1.2.i")

%% Q1.2.ii

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]
J_2 = 1.082e-3; % [-]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_2_ii = sim("simulink_modelQ1_2.slx");

r = [simQ1_2_ii.x.signals.values, simQ1_2_ii.y.signals.values, simQ1_2_ii.z.signals.values];
v = [simQ1_2_ii.x_dot.signals.values, simQ1_2_ii.y_dot.signals.values, simQ1_2_ii.z_dot.signals.values];

epsilon = zeros(length(simQ1_2_ii.x.signals.values),1);
for i = 1:length(simQ1_2_ii.x.signals.values)
    epsilon(i) = norm(v(i,:))^2/2 - myu/norm(r(i,:));
end

fig9 = figure ("Name","The Specific Orbital Energy of the Satellite as a Function of Time - No Perfect Sphere",'Position',[550 200 900 500]);
hold all
grid on
grid minor

plot(simQ1_2_ii.x.time,epsilon, "LineWidth",1, "Color","#7E2F8E"); 

title ("The Specific Orbital Energy of the Satellite as a Function of Time - No Perfect Sphere");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("epsilon(t) [km^2/sec^2]")
xlabel("t [sec]")

legend({'epsilon(t) - No Perfect Sphere'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig9, 'Q1.2grap2.png','Resolution',1200);
disp("Finished Q.1.2.ii")

%% Q1.2.iii
r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]
J_2 = 1.082e-3; % [-]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_2_iii = sim("simulink_modelQ1_2.slx");
r = [simQ1_2_iii.x.signals.values, simQ1_2_iii.y.signals.values, simQ1_2_iii.z.signals.values];
v = [simQ1_2_iii.x_dot.signals.values, simQ1_2_iii.y_dot.signals.values, simQ1_2_iii.z_dot.signals.values];

h = zeros(length(simQ1_2_iii.x.signals.values),3);
for i = 1:length(simQ1_2_iii.x.signals.values)
    h(i,:) = cross(r(i,:), v(i,:));
    i;
end
magintude_h = zeros(length(simQ1_2_iii.x.signals.values),1);
for i = 1:length(simQ1_2_iii.x.signals.values)
    magintude_h(i) = norm(h(i,:));
    i;
end

fig10 = figure ("Name","The Specific Angular Momentum of the Satellite as a Function of Time - No Perfect Sphere",'Position',[700 200 900 500]);
hold all
grid on
grid minor

plot(simQ1_2_iii.x.time,magintude_h, "LineWidth",1, "Color","#7E2F8E"); 

title ("The Specific Angular Momentum of the Satellite as a Function of Time - No Perfect Sphere");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("h(t) [km^2/sec]")
xlabel("t [sec]")

legend({'h(t) - No Perfect Sphere'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig10, 'Q1.2grap3.png','Resolution',1200);
disp("Finished Q.1.2.iii")

%% Q1.2.iv

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]
J_2 = 1.082e-3; % [-]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_2_iv = sim("simulink_modelQ1_2.slx");
r = [simQ1_2_iv.x.signals.values, simQ1_2_iv.y.signals.values, simQ1_2_iv.z.signals.values];
v = [simQ1_2_iv.x_dot.signals.values, simQ1_2_iv.y_dot.signals.values, simQ1_2_iv.z_dot.signals.values];

magintude_r = zeros(length(simQ1_2_iv.x.signals.values),1);
for i = 1:length(simQ1_2_iv.x.signals.values)
    magintude_r(i) = norm(r(i,:));
    i;
end

fig11 = figure ("Name","The Magnitude of r as a Function of Time - No Perfect Sphere",'Position',[100 50 900 500]);
hold all
grid on
grid minor

plot(simQ1_2_iv.x.time,magintude_r, "LineWidth",1, "Color","#7E2F8E"); 

title ("The Magnitude of r as a Function of Time - No Perfect Sphere");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("r(t) [km]")
xlabel("t [sec]")

legend({'r(t) - No Perfect Sphere'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig11, 'Q1.2grap4.png','Resolution',1200);
disp("Finished Q.1.2.iv")

%% Q1.2.v

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]
J_2 = 1.082e-3; % [-]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_2_v = sim("simulink_modelQ1_2.slx");
r = [simQ1_2_v.x.signals.values, simQ1_2_v.y.signals.values, simQ1_2_v.z.signals.values];
v = [simQ1_2_v.x_dot.signals.values, simQ1_2_v.y_dot.signals.values, simQ1_2_v.z_dot.signals.values];

magintude_v = zeros(length(simQ1_2_v.x.signals.values),1);
for i = 1:length(simQ1_2_v.x.signals.values)
    magintude_v(i) = norm(v(i,:));
    i;
end

fig12 = figure ("Name","The Magnitude of v as a Function of Time - No Perfect Sphere",'Position',[250 50 900 500]);
hold all
grid on
grid minor

plot(simQ1_2_v.x.time,magintude_v, "LineWidth",1.5, "Color","#7E2F8E"); 

title ("The Magnitude of v as a Function of Time - No Perfect Sphere");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("v(t) [km/sec]")
xlabel("t [sec]")

legend({'v(t) - No Perfect Sphere'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig12, 'Q1.2grap5.png','Resolution',1200);
disp("Finished Q.1.2.v")

%% Q1.2.vi

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]
J_2 = 1.082e-3; % [-]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_2_vi = sim("simulink_modelQ1_2.slx");
r = [simQ1_2_vi.x.signals.values, simQ1_2_vi.y.signals.values, simQ1_2_vi.z.signals.values];
v = [simQ1_2_vi.x_dot.signals.values, simQ1_2_vi.y_dot.signals.values, simQ1_2_vi.z_dot.signals.values];

h = zeros(length(simQ1_2_vi.x.signals.values),3);
% for i = 1:length(simQ1_1_vi.x.signals.values)
%     h(i,:) = cross(r(i,:), v(i,:));
%     i
% end

phi = zeros(length(simQ1_2_vi.x.signals.values),1);
for i = 1:length(simQ1_2_vi.x.signals.values)
    h(i,:) = cross(r(i,:), v(i,:));
    phi(i) = acos(norm(h(i,:)/(norm(r(i,:)*norm(v(i,:))))));
    if dot(r(i,:), v(i,:)) < 0
        phi(i) = -phi(i);
    end
    i;
end

fig13 = figure ("Name","The flight path angle φ as a Function of Time - No Perfect Sphere",'Position',[400 50 900 500]);
hold all
grid on
grid minor

plot(simQ1_2_vi.x.time,phi, "LineWidth",1.5, "Color","#7E2F8E"); 

title ("The flight path angle φ as a Function of Time - No Perfect Sphere");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("φ(t) [rad]")
xlabel("t [sec]")

legend({'φ(t) - No Perfect Sphere'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig13, 'Q1.2grap6.png','Resolution',1200);
disp("Finished Q.1.2.vi")

%% Diff.i

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]
J_2 = 1.082e-3; % [-]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_2_i = sim("simulink_modelQ1_2.slx");
simQ1_1_i = sim("simulink_modelQ1.slx");

[x_sphere, y_sphere, z_sphere] = sphere(30);
x_sphere = x_sphere*R_E;
y_sphere = y_sphere*R_E;
z_sphere = z_sphere*R_E;

fig14 = figure ("Name","The Orbit of the Satellite - Differences",'Position',[550 50 900 500]);
hold all
grid on
axis equal

plot3(simQ1_2_i.x.signals.values, simQ1_2_i.y.signals.values, simQ1_2_i.z.signals.values, "LineWidth",0.5, "Color","#7E2F8E")
s = surf(x_sphere, y_sphere, z_sphere, EdgeColor="none");
plot3(simQ1_1_i.x.signals.values, simQ1_1_i.y.signals.values, simQ1_1_i.z.signals.values, "LineWidth",2, "Color","#FF0000")

title ("The Orbit of the Satellite - Differences");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("y [km]")
xlabel("x [km]")
zlabel("z [km]")

legend({'The Orbit - No Perfect Sphere','The Earth','The Orbit - Perfect Sphere'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig14, 'Q.Diff_grap1.png','Resolution',1200);
disp("Finished Diff.i")

%% Diff.ii

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]
J_2 = 1.082e-3; % [-]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_2_ii = sim("simulink_modelQ1_2.slx");
simQ1_1_ii = sim("simulink_modelQ1.slx");

r1 = [simQ1_1_ii.x.signals.values, simQ1_1_ii.y.signals.values, simQ1_1_ii.z.signals.values];
v1 = [simQ1_1_ii.x_dot.signals.values, simQ1_1_ii.y_dot.signals.values, simQ1_1_ii.z_dot.signals.values];
r2 = [simQ1_2_ii.x.signals.values, simQ1_2_ii.y.signals.values, simQ1_2_ii.z.signals.values];
v2 = [simQ1_2_ii.x_dot.signals.values, simQ1_2_ii.y_dot.signals.values, simQ1_2_ii.z_dot.signals.values];

epsilon1 = zeros(length(simQ1_1_ii.x.signals.values),1);
for i = 1:length(simQ1_1_ii.x.signals.values)
    epsilon1(i) = norm(v1(i,:))^2/2 - myu/norm(r1(i,:));
end
epsilon2 = zeros(length(simQ1_2_ii.x.signals.values),1);
for i = 1:length(simQ1_2_ii.x.signals.values)
    epsilon2(i) = norm(v2(i,:))^2/2 - myu/norm(r2(i,:));
end

fig15 = figure ("Name","The Specific Orbital Energy of the Satellite as a Function of Time - Differences",'Position',[700 50 900 500]);
hold all
grid on
grid minor

plot(simQ1_2_ii.x.time,epsilon2, "LineWidth",1, "Color","#7E2F8E"); 
plot(simQ1_1_ii.x.time,epsilon1, "LineWidth",2, "Color","#FF0000"); 

title ("The Specific Orbital Energy of the Satellite as a Function of Time - Differences");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("epsilon(t) [km^2/sec^2]")
xlabel("t [sec]")

legend({'epsilon(t) - No Perfect Sphere','epsilon(t) - Perfect Sphere'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig15, 'Q.Diff_grap2.png','Resolution',1200);
disp("Finished Diff.ii")

%% Diff.iii

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]
J_2 = 1.082e-3; % [-]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_1_iii = sim("simulink_modelQ1.slx");
simQ1_2_iii = sim("simulink_modelQ1_2.slx");

r1 = [simQ1_1_iii.x.signals.values, simQ1_1_iii.y.signals.values, simQ1_1_iii.z.signals.values];
v1 = [simQ1_1_iii.x_dot.signals.values, simQ1_1_iii.y_dot.signals.values, simQ1_1_iii.z_dot.signals.values];
r2 = [simQ1_2_iii.x.signals.values, simQ1_2_iii.y.signals.values, simQ1_2_iii.z.signals.values];
v2 = [simQ1_2_iii.x_dot.signals.values, simQ1_2_iii.y_dot.signals.values, simQ1_2_iii.z_dot.signals.values];

h1 = zeros(length(simQ1_1_iii.x.signals.values),3);
for i = 1:length(simQ1_1_iii.x.signals.values)
    h1(i,:) = cross(r1(i,:), v1(i,:));
    i;
end
h2 = zeros(length(simQ1_2_iii.x.signals.values),3);
for i = 1:length(simQ1_2_iii.x.signals.values)
    h2(i,:) = cross(r2(i,:), v2(i,:));
    i;
end

magintude_h1 = zeros(length(simQ1_1_iii.x.signals.values),1);
for i = 1:length(simQ1_1_iii.x.signals.values)
    magintude_h1(i) = norm(h1(i,:));
    i;
end
magintude_h2 = zeros(length(simQ1_2_iii.x.signals.values),1);
for i = 1:length(simQ1_2_iii.x.signals.values)
    magintude_h2(i) = norm(h2(i,:));
    i;
end

fig16 = figure ("Name","The Specific Angular Momentum of the Satellite as a Function of Time - Differences",'Position',[100 350 900 500]);
hold all
grid on
grid minor

plot(simQ1_2_iii.x.time,magintude_h2, "LineWidth",1, "Color","#7E2F8E");
plot(simQ1_1_iii.x.time,magintude_h1, "LineWidth",2, "Color","#FF0000");

title ("The Specific Angular Momentum of the Satellite as a Function of Time - Differences");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("h(t) [km^2/sec]")
xlabel("t [sec]")

legend({'h(t) - No Perfect Sphere','h(t) - Perfect Sphere'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig16, 'Q.Diff_grap3.png','Resolution',1200);
disp("Finished Diff.iii")

%% Diff.iv

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]
J_2 = 1.082e-3; % [-]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_1_iv = sim("simulink_modelQ1.slx");
simQ1_2_iv = sim("simulink_modelQ1_2.slx");

r1 = [simQ1_1_iv.x.signals.values, simQ1_1_iv.y.signals.values, simQ1_1_iv.z.signals.values];
v1 = [simQ1_1_iv.x_dot.signals.values, simQ1_1_iv.y_dot.signals.values, simQ1_1_iv.z_dot.signals.values];
r2 = [simQ1_2_iv.x.signals.values, simQ1_2_iv.y.signals.values, simQ1_2_iv.z.signals.values];
v2 = [simQ1_2_iv.x_dot.signals.values, simQ1_2_iv.y_dot.signals.values, simQ1_2_iv.z_dot.signals.values];

magintude_r1 = zeros(length(simQ1_1_iv.x.signals.values),1);
for i = 1:length(simQ1_1_iv.x.signals.values)
    magintude_r1(i) = norm(r1(i,:));
    i;
end
magintude_r2 = zeros(length(simQ1_2_iv.x.signals.values),1);
for i = 1:length(simQ1_2_iv.x.signals.values)
    magintude_r2(i) = norm(r2(i,:));
    i;
end

fig17 = figure ("Name","The Magnitude of r as a Function of Time - Differences",'Position',[250 350 900 500]);
hold all
grid on
grid minor

plot(simQ1_2_iv.x.time,magintude_r2, "LineWidth",1.5, "Color","#7E2F8E"); 
plot(simQ1_1_iv.x.time,magintude_r1,":", "LineWidth",1, "Color","#FF0000");

title ("The Magnitude of r as a Function of Time - Differences");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("r(t) [km]")
xlabel("t [sec]")

legend({'r(t) - No Perfect Sphere', 'r(t) - Perfect Sphere'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig17, 'Q.Diff_grap4.png','Resolution',1500);
disp("Finished Diff.iv")

%% Diff.v

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]
J_2 = 1.082e-3; % [-]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_1_v = sim("simulink_modelQ1.slx");
simQ1_2_v = sim("simulink_modelQ1_2.slx");

r1 = [simQ1_1_v.x.signals.values, simQ1_1_v.y.signals.values, simQ1_1_v.z.signals.values];
v1 = [simQ1_1_v.x_dot.signals.values, simQ1_1_v.y_dot.signals.values, simQ1_1_v.z_dot.signals.values];
r2 = [simQ1_2_v.x.signals.values, simQ1_2_v.y.signals.values, simQ1_2_v.z.signals.values];
v2 = [simQ1_2_v.x_dot.signals.values, simQ1_2_v.y_dot.signals.values, simQ1_2_v.z_dot.signals.values];

magintude_v1 = zeros(length(simQ1_1_v.x.signals.values),1);
for i = 1:length(simQ1_1_v.x.signals.values)
    magintude_v1(i) = norm(v1(i,:));
    i;
end
magintude_v2 = zeros(length(simQ1_2_v.x.signals.values),1);
for i = 1:length(simQ1_2_v.x.signals.values)
    magintude_v2(i) = norm(v2(i,:));
    i;
end

fig18 = figure ("Name","The Magnitude of v as a Function of Time - Differences",'Position',[400 350 900 500]);
hold all
grid on
grid minor

plot(simQ1_2_v.x.time,magintude_v2, "LineWidth",1.5, "Color","#7E2F8E"); 
plot(simQ1_1_v.x.time,magintude_v1,":", "LineWidth",1, "Color","#FF0000"); 

title ("The Magnitude of v as a Function of Time - Differences");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("v(t) [km/sec]")
xlabel("t [sec]")

legend({'v(t) - No Perfect Sphere','v(t) - Perfect Sphere'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig18, 'Q.Diff_grap5.png','Resolution',1500);
disp("Finished Diff.v")

%% Diff.vi

r_0_vector = [-2.1 4.2 6.5]*10^3; % [km]
v_0_vector = [-6.8 -1.5 -0.43]; % [km/sec]
myu = 398603; % [km^3/sec^2]
R_E = 6378; % [km]
J_2 = 1.082e-3; % [-]

simulation_time = 864e3; % [sec]
simulation_start_time = 0; % [sec]
simulation_end_time = simulation_start_time + simulation_time; % [sec]
integration_step_time = 10; % [sec]

simQ1_1_vi = sim("simulink_modelQ1.slx");
simQ1_2_vi = sim("simulink_modelQ1_2.slx");

r1 = [simQ1_1_vi.x.signals.values, simQ1_1_vi.y.signals.values, simQ1_1_vi.z.signals.values];
v1 = [simQ1_1_vi.x_dot.signals.values, simQ1_1_vi.y_dot.signals.values, simQ1_1_vi.z_dot.signals.values];
r2 = [simQ1_2_vi.x.signals.values, simQ1_2_vi.y.signals.values, simQ1_2_vi.z.signals.values];
v2 = [simQ1_2_vi.x_dot.signals.values, simQ1_2_vi.y_dot.signals.values, simQ1_2_vi.z_dot.signals.values];

h1 = zeros(length(simQ1_1_vi.x.signals.values),3);
phi1 = zeros(length(simQ1_1_vi.x.signals.values),1);
for i = 1:length(simQ1_1_vi.x.signals.values)
    h1(i,:) = cross(r1(i,:), v1(i,:));
    phi1(i) = acos(norm(h1(i,:)/(norm(r1(i,:)*norm(v1(i,:))))));
    if dot(r1(i,:), v1(i,:)) < 0
        phi1(i) = -phi1(i);
    end
    i;
end
h2 = zeros(length(simQ1_2_vi.x.signals.values),3);
phi2 = zeros(length(simQ1_2_vi.x.signals.values),1);
for i = 1:length(simQ1_2_vi.x.signals.values)
    h2(i,:) = cross(r2(i,:), v2(i,:));
    phi2(i) = acos(norm(h2(i,:)/(norm(r2(i,:)*norm(v2(i,:))))));
    if dot(r2(i,:), v2(i,:)) < 0
        phi2(i) = -phi2(i);
    end
    i;
end

fig19 = figure ("Name","The flight path angle φ as a Function of Time - Differences",'Position',[550 350 900 500]);
hold all
grid on
grid minor

plot(simQ1_2_vi.x.time,phi2, "LineWidth",1.5, "Color","#7E2F8E"); 
plot(simQ1_1_vi.x.time,phi1,":", "LineWidth",1, "Color","#FF0000"); 

title ("The flight path angle φ as a Function of Time - Differences");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("φ(t) [rad]")
xlabel("t [sec]")

legend({'φ(t) - No Perfect Sphere','φ(t) - Perfect Sphere'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig19, 'Q.Diff_grap6.png','Resolution',1500);
disp("Finished Diff.vi")
