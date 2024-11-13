global file m_f m_0 m_0_dot t_b g u_e A_e P_a K_p A_t t_90 gama_end beta rho A k_a R Temp a D T Gama_Const h A_e_0 P_e_over_P_0 epsilon

m_f = 22; % [Kg]
m_0 = 42; % [Kg]
m_0_dot = 1; % [Kg/sec]
t_b = 20; % [sec]
g = 9.81; % [N/Kg]
u_e = 1800; % [m/s]
A_e = ((20*10^(-3))^2)*pi; % [m^2]
P_a = 101325; % [Pa]
K_p = 1.28; % [-]
A_t = (((5*10^(-3))/2)^2)*pi; % [m^2]
t_90 = 2; % [sec]
gama_end = 10; % [deg]
beta = 0.6; % [Hz]
rho = 1.225; % [Kg/m^3]
A = (((132*10^(-3))/2)^2)*pi; % [m^2]
k_a = 1.4; % [-]
R = 287; % [J/Kg*K]
Temp = 300; % [K]
a = (k_a*R*Temp)^(0.5); % [m/sec]
A_e_0 = false;
h = 10^(-2);
epsilon = 10^(-20);

P_e_of_t = @P_e_as_a_function_of_t;
% P_e_as_a_function_of_t calculats the Pe(t) and accepts K_p, A_t, A_e,
% P_a, t_b, t as arguments and returns Pe(t)

P_0_of_t = @P_0_as_a_function_of_t;
% P_0_as_a_function_of_t calculats the Po(t) and accepts P_a ,t_b, t as
% arguments and returns Po(t)

T_of_t = @T_as_a_function_of_t;
% T_as_a_function_of_t calculats the T(t) and accepts P_a,P_e,A_e,u_e,
% m_0_dot,t_b,t as arguments and returns T(t)

gama_of_t = @Gama_as_a_function_of_t; % [deg]
% Gama_as_a_function_of_t calculats the gama(t) and accepts t_90, gama_end,
% beta,t as arguments and returns gama(t)

M_to_CD = @Mach_to_CD;
% Mach_to_CD converts any Mach number in range to the coresponding CD, the
% function accepts the file and the demanded Mach number 
% (We choose the second order local interpolation)

f_of_x = @function_of_Pe_over_P0_for__the_numeric_method;
% This function is used to express the relation for the changing chord
% method as a function of the ratio between Pe and P0. It accepts K_p, A_t,
%  A_e, x and retuns f(x)

m_of_t = @m_as_a_function_of_t;
% m_as_a_function_of_t calculats the m(t) and accepts m_f, m_0, m_0_dot,
% t_b, t as arguments and returns m(t)

P_e_over_P_0 = Pe_over_P0;
% Pe_over_P0 calculats the ratio between Pe and P0 using the changing chord  
% method (Meitar Mishtane) and returning Pe over P0


% Sub-Question #B
file = load("CD_vs_M.txt");

Mach = 0.82;
CD = Mach_to_CD(file,Mach)

% Sub-Question #D

% Functions that represent the ODE:
% f1 - accepts x2 and returns f1
% f2 - accepts x2, z2, t and returns f2
% f3 - accepts z2 and returns f3
% f4 - accepts x2, z2, t and returns f4

ODE_Sol = @ODE_Full_Solution;
% ODE_Full_Solution is a function that accepts Initial_Condition, t_0 and
% the booleans D and T. It returns the solution of the ODE with 3rd Order
% Runge-Kutta (ts, x1s, x2s, z1s, z2s);

%% Sub-Question D.1
Initial_Condition = [0,0,50*cos(deg2rad(45)),0,50*sin(deg2rad(45))];
D = false;
T = false;
h = 10^(-2);
Final_Height = 0;
Gama_Const = false;

% Numerical solution
[Numerical_ts, Numerical_x1s, Numerical_x2s, Numerical_z1s, Numericall_z2s] = ODE_Sol(Initial_Condition, Final_Height);
% Calculated solution
Analytical_ts = Numerical_ts;
Analytical_xs = (sqrt(2)/2)*50.*Analytical_ts;
Analytical_zs = (sqrt(2)/2)*50.*Analytical_ts - 0.5*g.*(Analytical_ts).^2;

% Plots
fig1 = figure ("Name",'D1 - Comparison Between Analytical and Numerical Solution','Position',[800 200 900 500]);
tiledlayout(2,1);

nexttile
hold all
plot(Analytical_ts, Analytical_xs,'LineWidth',3,'Color',[0 0.4470 0.7410])
plot(Numerical_ts, Numerical_x1s, '--', 'LineWidth',2.5,'Color',[0.8500 0.3250 0.0980])
title (["D1 - Comparison Between Analytical and Numerical Solution", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('x(t) [m]')
grid on
grid minor
legend({'Analytical','Numerical'},'FontSize',14 ,'Location','southeast')

nexttile
hold all
plot(Analytical_ts, Analytical_zs,'LineWidth',3,'Color',[0 0.4470 0.7410])
plot(Numerical_ts, Numerical_z1s, '--', 'LineWidth',2.5,'Color',[0.8500 0.3250 0.0980])
title (["D1 - Comparison Between Analytical and Numerical Solution", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('z(t) [m]')
grid on
grid minor
legend({'Analytical','Numerical'},'FontSize',14 ,'Location','northeast')
% exportgraphics(fig1, 'QD1-graph.png','Resolution',1200); %export the fig to a png file
disp("Finished D1")

%% Sub-Question D.2
Initial_Condition = [0,0,0,0,0];
D = false;
T = true;
A_e_0 = true;
h = 10^(-2);
Gama_Const = true;
Final_Height = 0;

% Numerical solution
[Numerical_ts, Numerical_x1s, Numerical_x2s, Numerical_z1s, Numericall_z2s] = ODE_Sol(Initial_Condition, Final_Height);
Numerical_V_end = (Numerical_x2s(t_b/h)^2 + Numericall_z2s(t_b/h)^2)^0.5

% Analytical solution
Analytical_V_end = u_e*log(m_0/m_f) - g*t_b
disp("Finished D2")

%% Sub-Question D.3_1 Checking the convesion of D1

h_to_Check = [10^(0) 10^(-1) 10^(-2) 10^(-3)];

Initial_Condition = [0,0,50*cos(deg2rad(45)),0,50*sin(deg2rad(45))];
D = false;
T = false;
Gama_Const = false;
Final_Height = 0;
numerical_results = {}; % cell array with diffrent matrix of solution in every index
% every matrix is [Numerical_ts; Numerical_x1s; Numerical_x2s;
% Numerical_z1s; Numericall_z2s]
for i = 1:length(h_to_Check)
    h = h_to_Check(i);
    [Numerical_ts, Numerical_x1s, Numerical_x2s, Numerical_z1s, Numericall_z2s] = ODE_Sol(Initial_Condition, Final_Height);
    numerical_results(i,:) = {[Numerical_ts; Numerical_x1s; Numerical_x2s; Numerical_z1s; Numericall_z2s]};
end

% Calculating the analytical solution for every numerical solution

analytical_results = {}; % cell array with diffrent matrix of solution in every index
% every matrix is [Analytical_ts; Analytical_xs; Analytical_zs]
for i = 1:length(h_to_Check)
    h = h_to_Check(i);
    Analytical_ts = numerical_results{i}(1,:);
    Analytical_xs = (sqrt(2)/2)*50.*Analytical_ts;
    Analytical_zs = (sqrt(2)/2)*50.*Analytical_ts - 0.5*g.*(Analytical_ts).^2;
    analytical_results(i,:) = {[Analytical_ts; Analytical_xs; Analytical_zs]};
end

Lin = {'-', '-.', ':', '--'};
fig2 = figure ("Name",'D3 - Plot of the Different Numerical as a Function of (h) and the Analytical Solutionthe','Position',[800 200 900 500]);
tiledlayout(2,1);

nexttile
hold all
plot(analytical_results{end}(1,:), analytical_results{end}(2,:),'LineWidth',3.5,'Color',[0.3010 0.7450 0.9330])
for j = 1:length(h_to_Check)
    semilogx(numerical_results{j}(1,:), numerical_results{j}(2,:), Lin{j},'LineWidth',2)
end
title (["D3 - Plot of the Analytical and Different Numerical Solution for x(t)", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('x(t) [m]')
grid on
grid minor
legend({'Analytical x(t)','x(t) for h = 10^(^0^)','x(t) for h = 10^(^-^1^)','x(t) for h = 10^(^-^2^)','x(t) for h = 10^(^-^3^)'},'FontSize',10 ,'Location','northwest')

nexttile
hold all
plot(analytical_results{end}(1,:), analytical_results{end}(3,:),'LineWidth',3.5,'Color',[0.3010 0.7450 0.9330])
for j = 1:length(h_to_Check)
    semilogx(numerical_results{j}(1,:), numerical_results{j}(4,:), Lin{j},'LineWidth',2)
end
title (["D3 - Plot of the Analytical and Different Numerical Solution for x(t)", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('z(t) [m]')
grid on
grid minor
legend({'Analytical z(t)','z(t) for h = 10^(^0^)','z(t) for h = 10^(^-^1^)','z(t) for h = 10^(^-^2^)','z(t) for h = 10^(^-^3^)'},'FontSize',10 ,'Location','northwest')
% exportgraphics(fig2, 'QD3_1-graph.png','Resolution',1200); %export the fig to a png file
disp("Finished D3.1")

%% D.3_2 Checking the convesion of D2

Initial_Condition = [0,0,0,0,0];
D = false;
T = true;
A_e_0 = true;
h_to_Check = logspace(-4,0,6);
Gama_Const = true;
Final_Height = 0;
Numerical_V_ends = [];

% Numerical solution
for i = 1:length(h_to_Check)
    h = h_to_Check(i);
    [Numerical_ts, Numerical_x1s, Numerical_x2s, Numerical_z1s, Numericall_z2s] = ODE_Sol(Initial_Condition, Final_Height);
    Numerical_V_end = (Numerical_x2s(floor(t_b/h))^2 + Numericall_z2s(floor(t_b/h))^2)^0.5;
    Numerical_V_ends(end+1) = Numerical_V_end;
end

% Analytical solution
Analytical_V_end = u_e*log(m_0/m_f) - g*t_b;

fig3 = figure ("Name",'D3 - The Numerical V_end as a Function of h','Position',[800 200 900 500]);
semilogx(h_to_Check,Numerical_V_ends,'LineWidth',1,'Color',[0 0.4470 0.7410])
hold on
semilogx(h_to_Check,ones(length(h_to_Check))*Analytical_V_end,'LineWidth',1,'Color',[0.3010 0.7450 0.9330])
title (["D3 - The Numerical V_e_n_d as a Function of h", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('h [s]')
ylabel('V_e_n_d [m/sec]')
grid on
legend({'Numerical V_e_n_d', 'Analytical V_e_n_d'},'FontSize',14 ,'Location','southwest')
% exportgraphics(fig3, 'QD3_2-graph.png','Resolution',1200); %export the fig to a png file
disp("Finished D3.2")

%% Question E
Initial_Condition = [0,0,0,0,0];
h_to_Check = [10 ^(-3) 10^(-2) 10^(-1) 10^(0)];
D = true;
T = true;
A_e_0 = false;
Gama_Const = false;
Final_Height = -240;

numerical_results = {}; % cell array with diffrent matrix of solution in every index
% every matrix is [Numerical_ts; Numerical_x1s; Numerical_x2s;
% Numerical_z1s; Numericall_z2s]

for i = 1:length(h_to_Check)
    h = h_to_Check(i);
    [Numerical_ts, Numerical_x1s, Numerical_x2s, Numerical_z1s, Numericall_z2s] = ODE_Sol(Initial_Condition, Final_Height);
    numerical_results(i,:) = {[Numerical_ts; Numerical_x1s; Numerical_x2s; Numerical_z1s; Numericall_z2s]};
end
disp("Finished E")

%% Sub-Question E.1

ts = numerical_results{1}(1,:);
x1s = numerical_results{1}(2,:);
x2s = numerical_results{1}(3,:);
z1s = numerical_results{1}(4,:);
z2s = numerical_results{1}(5,:);
fig4 = figure ("Name",'E.1 - Plot of x(t) and z(t)','Position',[800 200 900 500]);
tiledlayout(2,1);

nexttile
plot(ts, x1s,'LineWidth',2,'Color',[0 0.4470 0.7410])
title (["E.1 - Plot of x(t)", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('x(t) [m]')
grid on
grid minor
legend({'x(t)'},'FontSize',14 ,'Location','northwest')

nexttile
plot(ts, z1s,'LineWidth',2,'Color',[0 0.4470 0.7410])
title (["E.1 - Plot of z(t)", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('z(t) [m]')
grid on
grid minor
legend({'z(t)'},'FontSize',14 ,'Location','northwest')
% exportgraphics(fig4, 'QE_1-graph.png','Resolution',1200); %export the fig to a png file
disp("Finished E.1")

%% E.1 - convesion check 

Lin = {'-', '-.', ':', '--'};
fig5 = figure ("Name",'E.1 - convesion check for different h','Position',[800 200 900 500]);
tiledlayout(2,1);

nexttile
hold all
for j = 1:length(h_to_Check)
    plot(numerical_results{j}(1,:), numerical_results{j}(2,:), Lin{j},'LineWidth',2)
end
title (["E.1 - convesion check", "Plot of x(t) For Different h", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('x(t) [m]')
grid on
grid minor
legend({'x(t) for h = 10^(^-^3^)','x(t) for h = 10^(^-^2^)','x(t) for h = 10^(^-^1^)','x(t) for h = 10^(^0^)'},'FontSize',10 ,'Location','northwest')

nexttile
hold all
for j = 1:length(h_to_Check)
    plot(numerical_results{j}(1,:), numerical_results{j}(4,:), Lin{j},'LineWidth',2)
end
title (["E.1 - convesion check", "Plot of z(t) For Different h", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('z(t) [m]')
grid on
grid minor
legend({'z(t) for h = 10^(^-^3^)','z(t) for h = 10^(^-^2^)','z(t) for h = 10^(^-^1^)','z(t) for h = 10^(^0^)'},'FontSize',10 ,'Location','northwest')
% exportgraphics(fig5, 'QE1_1-graph.png','Resolution',1200); %export the fig to a png file
disp("Finished E.1.1")

%% Sub-Question E.2

ts = numerical_results{1}(1,:);
x1s = numerical_results{1}(2,:);
x2s = numerical_results{1}(3,:);
z1s = numerical_results{1}(4,:);
z2s = numerical_results{1}(5,:);

fig6 = figure ("Name",'E.2 - Plot of V_x(t) and V_z(t)','Position',[800 200 900 500]);
tiledlayout(2,1);

nexttile
plot(ts, x2s,'LineWidth',2,'Color',[0 0.4470 0.7410])
title (["E.2 - Plot of V_x(t)", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('V_x(t) [m/sec]')
grid on
grid minor
legend({'V_x(t)'},'FontSize',14 ,'Location','northeast')

nexttile
plot(ts, z2s,'LineWidth',2,'Color',[0 0.4470 0.7410])
title (["E.2 - Plot of V_z(t)", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('V_z(t) [m/sec]')
grid on
grid minor
legend({'V_z(t)'},'FontSize',14 ,'Location','northeast')
% exportgraphics(fig6, 'QE_2-graph.png','Resolution',1200); %export the fig to a png file
disp("Finished E.2")

%% E.2 - convesion check 

Lin = {'-', '-.', ':', '--'};
fig7 = figure ("Name",'E.2 - convesion check for different h','Position',[800 200 900 500]);
tiledlayout(2,1);

nexttile
hold all
for j = 1:length(h_to_Check)
    plot(numerical_results{j}(1,:), numerical_results{j}(3,:), Lin{j},'LineWidth',2)
end
title (["E.2 - convesion check", "Plot of V_x(t) For Different h", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('V_x(t) [m/sec]')
grid on
grid minor
legend({'V_x(t) for h = 10^(^-^3^)','V_x(t) for h = 10^(^-^2^)','V_x(t) for h = 10^(^-^1^)','V_x(t) for h = 10^(^0^)'},'FontSize',10 ,'Location','northeast')

nexttile
hold all
for j = 1:length(h_to_Check)
    plot(numerical_results{j}(1,:), numerical_results{j}(5,:), Lin{j},'LineWidth',2)
end
title (["E.2 - convesion check", "Plot of V_z(t) For Different h", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('V_z(t) [m/sec]')
grid on
grid minor
legend({'V_z(t) for h = 10^(^-^3^)','V_z(t) for h = 10^(^-^2^)','V_z(t) for h = 10^(^-^1^)','V_z(t) for h = 10^(^0^)'},'FontSize',10 ,'Location','northeast')
% exportgraphics(fig7, 'QE2_1-graph.png','Resolution',1200); %export the fig to a png file
disp("Finished E.2.1")

%% Sub-Question E.3
fig8 = figure ("Name",'E.3 - Plot of z as a function of x','Position',[800 200 900 500]);
plot(numerical_results{1}(2,:), numerical_results{1}(4,:),'LineWidth',2,'Color',[0 0.4470 0.7410])
title (["E.3 - Plot of z as a function of x", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('x [m]')
ylabel('z [m]')
grid on
grid minor
legend({'z as a function of x'},'FontSize',14 ,'Location','northeast')
% exportgraphics(fig8, 'QE3-graph.png','Resolution',1200); %export the fig to a png file
disp("Finished E.3")

%% E.3 - convesion check 
fig9 = figure ("Name",'E.3 - convesion check for different h','Position',[800 200 900 500]);
hold all
for j = 1:length(h_to_Check)
    plot(numerical_results{j}(2,:), numerical_results{j}(4,:), Lin{j},'LineWidth',2)
end
title (["E.3 - convesion check", "Plot of z as a Function of x For Different h", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('x [m]')
ylabel('z [m]')
grid on
grid minor
legend({'z as a Function of x for h = 10^(^-^3^)','z as a Function of x for h = 10^(^-^2^)','z as a Function of x for h = 10^(^-^1^)','z as a Function of x for h = 10^(^0^)'},'FontSize',14 ,'Location','southwest')
% exportgraphics(fig9, 'QE3_1-graph.png','Resolution',1200); %export the fig to a png file
disp("Finished E.3.1")

%% Sub-Question E.4
ts = numerical_results{1}(1,:);
x1s = numerical_results{1}(2,:);
x2s = numerical_results{1}(3,:);
z1s = numerical_results{1}(4,:);
z2s = numerical_results{1}(5,:);
h = 10^(-3);

Max_Acceleration = 0;
Max_Acceleration_Time = 0;
for i = 1:(length(x2s) - 3)
    XAcceleration = (x2s(i + 1) - x2s(i))/h;
    ZAcceleration = (z2s(i + 1) - z2s(i))/h;
    Acceleration = sqrt(XAcceleration^2 + ZAcceleration);
    if (Acceleration > Max_Acceleration)
        Max_Acceleration = Acceleration;
        Max_Acceleration_Time = i*h;
    end
end
Max_Acceleration
Max_Acceleration_Time
disp("Finished E.4")

%% Sub-Question E.5
ts = numerical_results{1}(1,:);
x1s = numerical_results{1}(2,:);
x2s = numerical_results{1}(3,:);
z1s = numerical_results{1}(4,:);
z2s = numerical_results{1}(5,:);
h=10^(-3);

max_z = 0;
for i = 1:length(z1s)
    if z1s(i) > max_z
        max_z = z1s(i);
    end
end
max_z
disp("Finished E.5")

%% Sub-Question E.6
Flying_time = length(z1s)*h
disp("Finished E.6")

%% Sub-Question E.7
Delta_x = x1s(end) - x1s(1)
disp("Finished E.7")

%% E.4,5,6,7 - convesion check 

h_to_Check = logspace(-4,0,5);
Numerical_Max_Accelerations = [];
Numerical_Max_Accelerations_Times = [];
z_maxs = [];
Flying_times = [];
Delta_xs = [];

% Numerical solution
for j = 1:length(h_to_Check)
    h = h_to_Check(j);
    [Numerical_ts, Numerical_x1s, Numerical_x2s, Numerical_z1s, Numericall_z2s] = ODE_Sol(Initial_Condition, Final_Height);
    Max_Acceleration = 0;
    Max_Acceleration_Time = 0;
    for i = 1:(length(Numerical_x2s) - 1)
        XAcceleration = (Numerical_x2s(i + 1) - Numerical_x2s(i))/h;
        ZAcceleration = (Numerical_z1s(i + 1) - Numerical_z1s(i))/h;
        Acceleration = sqrt(XAcceleration^2 + ZAcceleration);
        if (Acceleration > Max_Acceleration)
            Max_Acceleration = Acceleration;
            Max_Acceleration_Time = i*h;
        end
    end
    Numerical_Max_Accelerations(j) =  Max_Acceleration;
    Numerical_Max_Accelerations_Times(j) = Max_Acceleration_Time;
    max_z = 0;
    for i = 1:length(Numerical_z1s)
        if Numerical_z1s(i) > max_z
            max_z = Numerical_z1s(i);
        end
    end
    z_maxs(j) = max_z;
    Flying_times(j) = length(Numerical_z1s)*h;
    Delta_xs(j) = Numerical_x1s(end) - Numerical_x1s(1);
end



fig10 = figure ("Name",'E.4 - convesion check for different h','Position',[800 200 900 500]);
tiledlayout(2,1);

nexttile
semilogx(h_to_Check,Numerical_Max_Accelerations,'LineWidth',1,'Color',[0 0.4470 0.7410])
hold on
semilogx(h_to_Check,ones(length(h_to_Check))*Numerical_Max_Accelerations(1),'LineWidth',1,'Color',[0.3010 0.7450 0.9330])
title (["E.4 - convesion check", "Plot of Max Accelerations as a Function of h", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('h [s]')
ylabel('Max Accelerations [m/sec^2]')
grid on
legend({'Numerical Max Accelerations as a Function of h', 'Numerical Max Accelerations at h = 10^(^-^4^)'},'FontSize',14 ,'Location','southwest')

nexttile
semilogx(h_to_Check,Numerical_Max_Accelerations_Times,'LineWidth',1,'Color',[0 0.4470 0.7410])
hold on
semilogx(h_to_Check,ones(length(h_to_Check))*Numerical_Max_Accelerations_Times(1),'LineWidth',1,'Color',[0.3010 0.7450 0.9330])
title (["E.4 - convesion check", "Plot of Max Accelerations Times as a Function of h", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('h [s]')
ylabel('Max Accelerations Times [sec]')
grid on
legend({'Numerical Max Accelerations Times as a Function of h', 'Numerical Max Accelerations Times at h = 10^(^-^4^)'},'FontSize',14 ,'Location','northwest')
% exportgraphics(fig10, 'QE4_1-graph.png','Resolution',1200); %export the fig to a png file

fig11 = figure ("Name",'E.5 - convesion check for different h','Position',[800 200 900 500]);
semilogx(h_to_Check,z_maxs,'LineWidth',1,'Color',[0 0.4470 0.7410])
hold on
semilogx(h_to_Check,ones(length(h_to_Check))*z_maxs(1),'LineWidth',1,'Color',[0.3010 0.7450 0.9330])
title (["E.5 - convesion check", "Plot of Max Hight as a Function of h", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('h [s]')
ylabel('Max Hight [m]')
grid on
legend({'Numerical Max Hight as a Function of h', 'Numerical Max Hight at h = 10^(^-^4^)'},'FontSize',14 ,'Location','northwest')
% exportgraphics(fig11, 'QE5_1-graph.png','Resolution',1200); %export the fig to a png file

fig12 = figure ("Name",'E.6 - convesion check for different h','Position',[800 200 900 500]);
semilogx(h_to_Check,Flying_times,'LineWidth',1,'Color',[0 0.4470 0.7410])
hold on
semilogx(h_to_Check,ones(length(h_to_Check))*Flying_times(1),'LineWidth',1,'Color',[0.3010 0.7450 0.9330])
title (["E.6 - convesion check", "Plot of Flying Time as a Function of h", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('h [s]')
ylabel('Flying Time [s]')
grid on
legend({'Numerical Flying Time as a Function of h', 'Numerical Flying Time at h = 10^(^-^4^)'},'FontSize',14 ,'Location','northwest')
% exportgraphics(fig12, 'QE6_1-graph.png','Resolution',1200); %export the fig to a png file

fig13 = figure ("Name",'E.7 - convesion check for different h','Position',[800 200 900 500]);
semilogx(h_to_Check,Delta_xs,'LineWidth',1,'Color',[0 0.4470 0.7410])
hold on
semilogx(h_to_Check,ones(length(h_to_Check))*Delta_xs(1),'LineWidth',1,'Color',[0.3010 0.7450 0.9330])
title (["E.7 - convesion check", "Plot of Delta x as a Function of h", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('h [s]')
ylabel('Delta x [m]')
grid on
legend({'Numerical Delta x as a Function of h', 'Numerical Delta x at h = 10^(^-^4^)'},'FontSize',14 ,'Location','northwest')
% exportgraphics(fig13, 'QE7_1-graph.png','Resolution',1200); %export the fig to a png file
disp("Finished E.4,5,6,7 - convesion check")

%% convesion check for Pe over P0

epsilon_to_check = logspace(-10,-3);
results = zeros(1, length(epsilon_to_check));
for j = 1:length(epsilon_to_check) 
    epsilon = epsilon_to_check(j);
    P_e_over_P_0 = Pe_over_P0;
    results(j) = P_e_over_P_0;
end

fig14 = figure ("Name",'convesion check of Pe over P0 for different epsilon','Position',[800 200 900 500]);
semilogx(epsilon_to_check,results,'LineWidth',1,'Color',[0 0.4470 0.7410])
hold on
semilogx(epsilon_to_check,ones(length(epsilon_to_check))*results(1),'LineWidth',1,'Color',[0.3010 0.7450 0.9330])
title (["convesion check of Pe over P0 for different epsilon", "Ronnel Nawy 325021152 & Almog Dobrescu 214254252"])
xlabel('epsilon [s]')
ylabel('Pe over P0 [-]')
grid on
legend({'Pe over P0 as a Function of epsilon', 'Pe over P0 at epsilon = 10^(^-^1^0^)'},'FontSize',14 ,'Location','southwest')
% exportgraphics(fig14, 'QE8-graph.png','Resolution',1200); %export the fig to a png file
disp("Finished Pe over P0 convesion check")
