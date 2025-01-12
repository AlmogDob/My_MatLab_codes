%% Data

Helicopter_Parameters;

% Sea-level atmospheric conditions
T_SL = 288; % [k]
P_SL = 101325; % [pa]
Rho_SL = 1.225; % [kg/m^3]

Weight = (Max_TO_Weight + Empty_Weight)/2; % [kg]

e_eff = 0.04;
L = 7;
a = 2*pi;
E_eff = 1.5*e_eff;

K_beta_Bar = 3*Sigma*a*e_eff/(4*L);
ht = Delta_Z - Delta_Zt; % [m]
Sb_Bar = Sb/Ad;

%% Q1 - Helicopter trim in hover OGE with CG exactly below the mast

Mu = 0; % Hovering
w_bar = 0; % Hovering
Delta_X = 0; % [m] - CG exactly below mast
Delta_Y = 0; % [m] - CG exactly below mast

[Beta_1s_Q1, Beta_1c_Q1, Phi_Q1, Tao_Q1, Theta_1s_Q1, Theta_1c_Q1, Theta_75_Q1, Theta_75_t_Q1] = Trim_Equations(Weight, Mu, w_bar, Delta_X, Delta_Y, Delta_Z)

%% Q2 - CG 4 inch on the left

Mu = 0; % Hovering
w_bar = 0; % Hovering
Delta_X = 0; % [m] - CG exactly below mast
Delta_Y = -4*0.0254; % [m] - CG 4 in on the left

[Beta_1s_Q2, Beta_1c_Q2, Phi_Q2, Tao_Q2, Theta_1s_Q2, Theta_1c_Q2, Theta_75_Q2, Theta_75_t_Q2] = Trim_Equations(Weight, Mu, w_bar, Delta_X, Delta_Y, Delta_Z)

%% Q3 - Crabbing to the right

Mu = 0; % Hovering
w_bar = (40*0.514444)/Vt; % [m/sec] - Crabbing to the right
Delta_X = 0; % [m] - CG exactly below mast
Delta_Y = 0; % [m] - CG exactly below mast

[Beta_1s_Q3, Beta_1c_Q3, Phi_Q3, Tao_Q3, Theta_1s_Q3, Theta_1c_Q3, Theta_75_Q3, Theta_75_t_Q3] = Trim_Equations(Weight, Mu, w_bar, Delta_X, Delta_Y, Delta_Z)

%% Q4 - Left lateral CG limit

Mu = 0; % Hovering
w_bar = [0 10 20 30 40].*0.514444./Vt; % [m/sec] - Crabbing to the right
Delta_X = 0; % [m] - CG exactly below mast
Delta_Y = linspace(-30*0.0254, 30*0.0254, 300); % [m] 

for i = 1:length(w_bar)
    for j = 1:length(Delta_Y)
        [Beta_1s_Q4(i, j), Beta_1c_Q4(i, j), Phi_Q4(i, j), Tao_Q4(i, j), Theta_1s_Q4(i, j), Theta_1c_Q4(i, j), Theta_75_Q4(i, j), Theta_75_t_Q4(i, j)] = Trim_Equations(Weight, Mu, w_bar(i), Delta_X, Delta_Y(j), Delta_Z);
    end
end

Fig1 = figure;
subplot(2, 2, 1)
plot(Delta_Y./0.0254, Theta_75_t_Q4(1, :), Delta_Y./0.0254, Theta_75_t_Q4(2, :), Delta_Y./0.0254, Theta_75_t_Q4(3, :), Delta_Y./0.0254, Theta_75_t_Q4(4, :), Delta_Y./0.0254, Theta_75_t_Q4(5, :), 'LineWidth', 2)
legend('0 [knots]', '10 [knots]', '20 [knots]', '30 [knots]', '40 [knots]')
xlabel('\Delta_Y [inch]')
ylabel('\theta_{0.75,t} [°]', 'Rotation', 0)
title('Tail rotor pitch angle at 3/4 radius (\theta_{0.75,t}) as function of the right side wind')
grid on

subplot(2, 2, 2)
hold on
Limitation_top = ones(length(Delta_Y), 1).*8; 
Limitation_bot = ones(length(Delta_Y), 1).*-8; 
plot(Delta_Y./0.0254, Limitation_top, '--r', 'LineWidth', 2)
plot(Delta_Y./0.0254, Limitation_bot, '--r', 'LineWidth', 2)
plot(Delta_Y./0.0254, Theta_1c_Q4(1, :), Delta_Y./0.0254, Theta_1c_Q4(2, :), Delta_Y./0.0254, Theta_1c_Q4(3, :), Delta_Y./0.0254, Theta_1c_Q4(4, :), Delta_Y./0.0254, Theta_1c_Q4(5, :), 'LineWidth', 2)
legend('Limitations', '','0 [knots]', '10 [knots]', '20 [knots]', '30 [knots]', '40 [knots]', 'Location', 'northwest')
xlabel('\Delta_Y [inch]')
ylabel('\theta_{1c} [°]', 'Rotation', 0)
title('Lateral cyclic range (\theta_{1c}) as function of the right side wind')
grid on

subplot(2, 2, 3)
plot(Delta_Y./0.0254, Theta_1s_Q4(1, :), Delta_Y./0.0254, Theta_1s_Q4(2, :), Delta_Y./0.0254, Theta_1s_Q4(3, :), Delta_Y./0.0254, Theta_1s_Q4(4, :), Delta_Y./0.0254, Theta_1s_Q4(5, :), 'LineWidth', 2)
legend('0 [knots]', '10 [knots]', '20 [knots]', '30 [knots]', '40 [knots]')
xlabel('\Delta_Y [inch]')
ylabel('\theta_{1s} [°]', 'Rotation', 0)
title('Longitudinal cyclic range (\theta_{1s}) as function of the right side wind')
grid on

subplot(2, 2, 4)
plot(Delta_Y./0.0254, Theta_75_Q4(1, :), Delta_Y./0.0254, Theta_75_Q4(2, :), Delta_Y./0.0254, Theta_75_Q4(3, :), Delta_Y./0.0254, Theta_75_Q4(4, :), Delta_Y./0.0254, Theta_75_Q4(5, :), 'LineWidth', 2)
legend('0 [knots]', '10 [knots]', '20 [knots]', '30 [knots]', '40 [knots]')
xlabel('\Delta_Y [inch]')
ylabel('\theta_{0.75} [°]', 'Rotation', 0)
title('Collective pitch as 3/4 radius (\theta_{0.75}) as function of the right side wind')
grid on

sgtitle('Dobrescu Almog & Nawy Ronnel')
% exportgraphics(Fig1, 'Q4.png','Resolution',900);

%% Q5 - CG on the right when carbbing to the left

% Repeating Q2 with CG on the right
Mu = 0; % Hovering
w_bar = 0; % Hovering   .
Delta_X = 0; % [m] - CG exactly below mast
Delta_Y = 4*0.0254; % [m] - CG 4 in on the right
[Beta_1s_Q5_2, Beta_1c_Q5_2, Phi_Q5_2, Tao_Q5_2, Theta_1s_Q5_2, Theta_1c_Q5_2, Theta_75_Q5_2, Theta_75_t_Q5_2] = Trim_Equations(Weight, Mu, w_bar, Delta_X, Delta_Y, Delta_Z)
%%
% Repeating Q3 when crabbing to the left
Mu = 0; % Hovering
w_bar = -(40*0.514444)/Vt; % [m/sec] - Crabbing to the left
Delta_X = 0; % [m] - CG exactly below mast
Delta_Y = 0; % [m] - CG exactly below mast
[Beta_1s_Q5_3, Beta_1c_Q5_3, Phi_Q5_3, Tao_Q5_3, Theta_1s_Q5_3, Theta_1c_Q5_3, Theta_75_Q5_3, Theta_75_t_Q5_3] = Trim_Equations(Weight, Mu, w_bar, Delta_X, Delta_Y, Delta_Z)
%%
% Repeating Q4 - 
Mu = 0; % Hovering
w_bar = [0 -10 -20 -30 -40].*0.514444./Vt; % [m/sec] - Crabbing to the right
Delta_X = 0; % [m] - CG exactly below mast
Delta_Y = linspace(-40*0.0254, 40*0.0254, 300); % [m] 

for i = 1:length(w_bar)
    for j = 1:length(Delta_Y)
        [Beta_1s_Q5_4(i, j), Beta_1c_Q5_4(i, j), Phi_Q5_4(i, j), Tao_Q5_4(i, j), Theta_1s_Q5_4(i, j), Theta_1c_Q5_4(i, j), Theta_75_Q5_4(i, j), Theta_75_t_Q5_4(i, j)] = Trim_Equations(Weight, Mu, w_bar(i), Delta_X, Delta_Y(j), Delta_Z);
    end
end

Fig2 = figure;
subplot(2, 2, 1)
hold on
Limitation = ones(length(Delta_Y), 1).*-5;
plot(Delta_Y./0.0254, Limitation, '--r', 'LineWidth', 2)
plot(Delta_Y./0.0254, Theta_75_t_Q5_4(1, :), Delta_Y./0.0254, Theta_75_t_Q5_4(2, :), Delta_Y./0.0254, Theta_75_t_Q5_4(3, :), Delta_Y./0.0254, Theta_75_t_Q5_4(4, :), Delta_Y./0.0254, Theta_75_t_Q5_4(5, :), 'LineWidth', 2)
legend('Limitations','0 [knots]', '10 [knots]', '20 [knots]', '30 [knots]', '40 [knots]')
xlabel('\Delta_Y [inch]')
ylabel('\theta_{0.75,t} [°]', 'Rotation', 0)
title('Tail rotor pitch angle at 3/4 radius (\theta_{0.75,t}) as function of the left side wind')
grid on

subplot(2, 2, 2)
hold on
Limitation_top = ones(length(Delta_Y), 1).*8;
Limitation_bot = ones(length(Delta_Y), 1).*-8;
plot(Delta_Y./0.0254, Limitation_top, '--r', 'LineWidth', 2)
plot(Delta_Y./0.0254, Limitation_bot, '--r', 'LineWidth', 2)
plot(Delta_Y./0.0254, Theta_1c_Q5_4(1, :), Delta_Y./0.0254, Theta_1c_Q5_4(2, :), Delta_Y./0.0254, Theta_1c_Q5_4(3, :), Delta_Y./0.0254, Theta_1c_Q5_4(4, :), Delta_Y./0.0254, Theta_1c_Q5_4(5, :), 'LineWidth', 2)
legend('Limitations', '','0 [knots]', '10 [knots]', '20 [knots]', '30 [knots]', '40 [knots]', 'Location', 'northwest')
xlabel('\Delta_Y [inch]')
ylabel('\theta_{1c} [°]', 'Rotation', 0)
title('Lateral cyclic range (\theta_{1c}) as function of the left side wind')
grid on

subplot(2, 2, 3)
plot(Delta_Y./0.0254, Theta_1s_Q5_4(1, :), Delta_Y./0.0254, Theta_1s_Q5_4(2, :), Delta_Y./0.0254, Theta_1s_Q5_4(3, :), Delta_Y./0.0254, Theta_1s_Q5_4(4, :), Delta_Y./0.0254, Theta_1s_Q5_4(5, :), 'LineWidth', 2)
legend('0 [knots]', '10 [knots]', '20 [knots]', '30 [knots]', '40 [knots]')
xlabel('\Delta_Y [inch]')
ylabel('\theta_{1s} [°]', 'Rotation', 0)
title('Longitudinal cyclic range (\theta_{1s}) as function of the left side wind')
grid on

subplot(2, 2, 4)
plot(Delta_Y./0.0254, Theta_75_Q5_4(1, :), Delta_Y./0.0254, Theta_75_Q5_4(2, :), Delta_Y./0.0254, Theta_75_Q5_4(3, :), Delta_Y./0.0254, Theta_75_Q5_4(4, :), Delta_Y./0.0254, Theta_75_Q5_4(5, :), 'LineWidth', 2)
legend('0 [knots]', '10 [knots]', '20 [knots]', '30 [knots]', '40 [knots]')
xlabel('\Delta_Y [inch]')
ylabel('\theta_{0.75} [°]', 'Rotation', 0)
title('Collective pitch as 3/4 radius (\theta_{0.75}) as function of the left side wind')
grid on

sgtitle('Dobrescu Almog & Nawy Ronnel')
% exportgraphics(Fig2, 'Q5.png','Resolution',900);