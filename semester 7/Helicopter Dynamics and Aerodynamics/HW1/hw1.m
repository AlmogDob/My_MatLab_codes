%% Data
Helicopter_Parameters;

%% Q1.1 - Required power to hover OGE

% Defining Parameters
W = linspace(Empty_Weight*2.2046, Max_TO_Weight*2.2046); % [lb]
T_Hovering = [243, 273, 303]; % [K]
h = [5, 10, 15, 20, 26]; % [kft]

% OGE Plots
for i = 1:length(W)
    Limitation_Oge(i) = 100; % 100% torque limitation
    for j = 1:length(T_Hovering)
        [Q_oge_Percent_Temp(i, j), Q_t_oge_Percent_Temp(i, j)] = Hovering_Power_Oge(W(i), T_Hovering(j), h(4)); % [%Q]
    end
    for k = 1:length(h)
        [Q_oge_Percent_Height(i, k), Q_t_oge_Percent_Height(i, k)] = Hovering_Power_Oge(W(i), T_Hovering(2), h(k)); % [%Q]
    end
end

% OGE - Helicopter %Q(W, h)
Figure1 = figure;
hold on
for i = 1:length(h)
    plot(W, Q_oge_Percent_Height(:, i), 'LineWidth', 2)
end
plot(W, Limitation_Oge, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 2)
legend('5 [kft]', '10 [kft]', '15 [kft]', '20 [kft]', '26 [kft]', 'Limitation','FontSize',15 ,'Location','southeast')
xlabel('Weight [lb]')
ylabel('Torque percentage [%Q]')
txt_Oge = '100% torque limitation';
text(W(1), 102, txt_Oge)
title('OGE - Torque percentage for different heights at 0 [°C] as function of weight')
grid on
% exportgraphics(Figure1, 'OGE_tot_const_temp_0C.png','Resolution',900);

% OGE - Tail %Q(W, h)
Figure2 = figure;
hold on
for i = 1:length(h)
    plot(W, Q_t_oge_Percent_Height(:, i), 'LineWidth', 2)
end
legend('5 [kft]', '10 [kft]', '15 [kft]', '20 [kft]', '26 [kft]','FontSize',15 ,'Location','southeast')
xlabel('Weight [lb]')
ylabel('Torque percentage [%Q]')
title('OGE - Tails Torque percentage for different heights at 0 [°C] as function of weight')
grid on
% exportgraphics(Figure2, 'OGE_tail_const_temp_0C.png','Resolution',900);

% OGE - Helicopter %Q(W, T)
Figure3 = figure;
hold on
for i = 1:length(T_Hovering)
    plot(W, Q_oge_Percent_Temp(:, i), 'LineWidth', 2)
end
plot(W, Limitation_Oge, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 2)
legend('-30 [°C]', '0 [°C]', '30 [°C]', 'Limitation','FontSize',15 ,'Location','southeast')
xlabel('Weight [lb]')
ylabel('Torque percentage [%Q]')
text(W(1), 102, txt_Oge)
title('OGE - Torque percentage for different temperatures at 20 [kft] as function of weight')
grid on
% exportgraphics(Figure3, 'OGE_tot_const_hight_20KFT.png','Resolution',900);

% OGE - Tail %Q(W, T)
Figure4 = figure;
hold on
for i = 1:length(T_Hovering)
    plot(W, Q_t_oge_Percent_Temp(:, i), 'LineWidth', 2)
end
legend('-30 [°C]', '0 [°C]', '30 [°C]','FontSize',15 ,'Location','southeast')
xlabel('Weight [lb]')
ylabel('Torque percentage [%Q]')
title('OGE - Tails Torque percentage for different temperatures at 20 [kft] as function of weight')
grid on
% exportgraphics(Figure4, 'OGE_tail_const_hight_20KFT.png','Resolution',900);

%% Q1.2 - Required power to hover IGE

% IGE Plots
for i = 1:length(W)
    Limitation_Ige(i) = 100; % 100% torque limitation
    for j = 1:length(T_Hovering)
        [Q_ige_Percent_Temp(i, j), Q_t_ige_Percent_Temp(i, j)] = Hovering_Power_Ige(W(i), T_Hovering(j), h(4)); % [%Q]
    end
    for k = 1:length(h)
        [Q_ige_Percent_Height(i, k), Q_t_ige_Percent_Height(i, k)] = Hovering_Power_Ige(W(i), T_Hovering(2), h(k)); % [%Q]
    end
end

% IGE - Helicopter %Q(W, h)
Figure5 = figure;
hold on
for i = 1:length(h)
    plot(W, Q_ige_Percent_Height(:, i), 'LineWidth', 2)
end
plot(W, Limitation_Ige, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 2)
legend('5 [kft]', '10 [kft]', '15 [kft]', '20 [kft]', '26 [kft]', 'Limitation','FontSize',15 ,'Location','southeast')
xlabel('Weight [lb]')
ylabel('Torque percentage [%Q]')
txt_Ige = '100% torque limitation';
text(W(1), 102, txt_Ige)
title('IGE - Torque percentage for different heights at 0 [°C] as function of weight')
grid on
% exportgraphics(Figure5, 'IGE_tot_const_temp_0C.png','Resolution',900);

% IGE - Tail %Q(W, h)
Figure6 = figure;
hold on
for i = 1:length(h)
    plot(W, Q_t_ige_Percent_Height(:, i), 'LineWidth', 2)
end
legend('5 [kft]', '10 [kft]', '15 [kft]', '20 [kft]', '26 [kft]','FontSize',15 ,'Location','southeast')
xlabel('Weight [lb]')
ylabel('Torque percentage [%Q]')
title('IGE - Tails Torque percentage for different heights at 0 [°C] as function of weight')
grid on
% exportgraphics(Figure6, 'IGE_tail_const_temp_0C.png','Resolution',900);

% IGE - Helicopter %Q(W, T)
Figure7 = figure;
hold on
for i = 1:length(T_Hovering)
    plot(W, Q_ige_Percent_Temp(:, i), 'LineWidth', 2)
end
plot(W, Limitation_Ige, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 2)
legend('-30 [°C]', '0 [°C]', '30 [°C]', 'Limitation','FontSize',15 ,'Location','southeast')
xlabel('Weight [lb]')
ylabel('Torque percentage [%Q]')
text(W(1), 102, txt_Ige)
title('IGE - Torque percentage for different temperatures at 20 [kft] as function of weight')
grid on
% exportgraphics(Figure7, 'IGE_tot_const_hight_20KFT.png','Resolution',900);

% IGE - Tail %Q(W, T)
Figure8 = figure;
hold on
for i = 1:length(T_Hovering)
    plot(W, Q_t_ige_Percent_Temp(:, i), 'LineWidth', 2)
end
legend('-30 [°C]', '0 [°C]', '30 [°C]','FontSize',15 ,'Location','southeast')
xlabel('Weight [lb]')
ylabel('Torque percentage [%Q]')
title('IGE - Tails Torque percentage for different temperatures at 20 [kft] as function of weight')
grid on
% exportgraphics(Figure8, 'IGE_tail_const_hight_20KFT.png','Resolution',900);

%% Q1.3 - Maximal take-off weight OGE and IGE
Helicopter_Parameters

% Defining parameters
H = linspace(0, 26, 40); % [kft]
T_Max_TO = [273-30, 273-15, 273, 273+15, 273+30]; % [K]
% Plots
for i = 1:length(H)
    Max_TO_Weight_Limit(i) = Max_TO_Weight*2.2046; % Maximal take-off weight limitation
    Min_TO_Weight_Limit(i) = Empty_Weight*2.2046; % Maximal take-off weight limitation
    for j = 1:length(T_Max_TO)
        [Max_Oge_TO_Weight(i, j), Max_Ige_TO_Weight(i, j)] = Maximun_TO_Weight(H(i), T_Max_TO(j), Rotor_Speed); % [N]
        Max_Oge_TO_Weight(i, j) = Max_Oge_TO_Weight(i, j)/9.81*2.2046; % [lb]
        Max_Ige_TO_Weight(i, j) = Max_Ige_TO_Weight(i, j)/9.81*2.2046; % [lb]
    end
end

% OGE
Figure9 = figure;
hold on
for i = 1:length(T_Max_TO)
    plot(Max_Oge_TO_Weight(:, i), H, 'LineWidth', 2)
end
plot(Max_TO_Weight_Limit, H, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 2)
plot(Min_TO_Weight_Limit, H, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 2)
xlabel('Maximal take-off weight [lb]')
ylabel('Height [kft]')
legend('-30 [°C]', '-15 [°C]', '0 [°C]', '15 [°C]', '30 [°C]', 'Limitation','FontSize',13 ,'Location','northeast')
txt_Max_TO_Weight = 'Max take-off weight limitation';
txt_Min_TO_Weight = 'Empty weight';
text(Max_TO_Weight*2.2046-450, 27, txt_Max_TO_Weight)
text(Empty_Weight*2.2046-200, 27, txt_Min_TO_Weight)
title('OGE - Maximal take-off weight as a function of altitude and temperature')
grid on
% exportgraphics(Figure9, 'OGE_MTOW.png','Resolution',900);

% IGE
Figure10 = figure;
hold on
for i = 1:length(T_Max_TO)
    plot(Max_Ige_TO_Weight(:, i), H, 'LineWidth', 2)
end
plot(Max_TO_Weight_Limit, H, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 2)
plot(Min_TO_Weight_Limit, H, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 2)
xlabel('Maximal take-off weight [lb]')
ylabel('Height [kft]')
legend('-30 [°C]', '-15 [°C]', '0 [°C]', '15 [°C]', '30 [°C]', 'Limitation','FontSize',13 ,'Location','northeast')
text(Max_TO_Weight*2.2046-450, 27, txt_Max_TO_Weight)
text(Empty_Weight*2.2046-450, 27, txt_Min_TO_Weight)
title('IGE - Maximal take-off weight as a function of altitude and temperature')
grid on
% exportgraphics(Figure10, 'IGE_MTOW.png','Resolution',900);

%% Q1.4 - Maximal take-off weight depending on the rotor speed

% Defining parameters
RPMS = [0.95, 1, 1.05].*Rotor_Speed; % [rpm]
H = linspace(0, 26, 40); % [kft]

% Plots
for i = 1:length(H)
    Max_TO_Weight_Rotor_Limit(i) = Max_TO_Weight*2.2046; % Maximal take-off weight limitation
    for j = 1:length(RPMS)    
        [Max_TO_Weight_Oge(i, j), Max_TO_Weight_Ige(i, j)] = Maximun_TO_Weight(H(i), 273, RPMS(j)); % [N]
        Max_TO_Weight_Oge(i, j) = Max_TO_Weight_Oge(i, j)*2.2046/9.81; % [lb]
        Max_TO_Weight_Ige(i, j) = Max_TO_Weight_Ige(i, j)*2.2046/9.81; % [lb]
    end
end

% OGE
Figure11 = figure;
hold on
for i = 1:length(RPMS)
    plot(Max_TO_Weight_Oge(:, i), H, 'LineWidth', 2)
end
plot(Max_TO_Weight_Rotor_Limit, H, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 2)
xlabel('Maximal take-off weight [lb]')
ylabel('Height [kft]')
legend('95% rotor speed', 'Regular rotor speed', '105% rotor speed', 'Limitation','FontSize',13 ,'Location','southwest')
txt_Max_TO_Weight_Rotor = 'Max take-off weight limitation';
text(Max_TO_Weight*2.2046-450, 27, txt_Max_TO_Weight_Rotor)
title('OGE - Maximal take-off weight as a function of altitude and rotor speed')
grid on
% exportgraphics(Figure11, 'OGE_MTOW_diff_RPM.png','Resolution',900);

% IGE
Figure12 = figure;
hold on
for i = 1:length(RPMS)
    plot(Max_TO_Weight_Ige(:, i), H, 'LineWidth', 2)
end
plot(Max_TO_Weight_Rotor_Limit, H, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 2)
xlabel('Maximal take-off weight [lb]')
ylabel('Height [kft]')
legend('95% rotor speed', 'Regular rotor speed', '105% rotor speed', 'Limitation','FontSize',13 ,'Location','southwest')
text(Max_TO_Weight*2.2046-450, 27, txt_Max_TO_Weight_Rotor)
title('IGE - Maximal take-off weight as a function of altitude and rotor speed')
grid on
% exportgraphics(Figure12, 'IGE_MTOW_diff_RPM.png','Resolution',900);

%% Q2.5 - Maximal take-off weight from Camp IV Everest

% Defining parameters
Everest_h = 26; % [kft]
Everest_T = 243; % [K]
Lukla_Distance = 40*1000; % [m]

[Maximal_TO_Weight, ~] = Maximun_TO_Weight(Everest_h, Everest_T, Rotor_Speed); % [N]
Maximal_TO_Weight_Without_Spare = Maximal_TO_Weight*(2.2046/9.81) % [lb]
Maximal_TO_Weight_With_Spare = 0.9*Maximal_TO_Weight_Without_Spare % [lb]

%% Q2.6 - Minimal operational take-off weight

% Attack helicopter - one pilot

Pilot_Weight = 200*2; % [lb]
Climber_Weight = 200; % [lb]
Human_Weight = Pilot_Weight + Climber_Weight; % [lb]

Fuel_Weight = P1_NR100*30; % [lb]

Total_Minimal_TO_Weight = Empty_Weight*2.2046 + Fuel_Weight + Human_Weight % [lb]




