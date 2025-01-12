%% Data
Helicopter_Parameters;

%% Q1.1 - Power required for unaccelerated level flight

AirSpeed = linspace(0, 150); % [knots]
Average_Weight = ((Max_TO_Weight+Empty_Weight)/2)*2.2046; % [lb]

RPM = [1, 0.95]*Rotor_Speed; % [RPM]
Height = [0, 3500]; % [ft]

T_Hover = 288 - Height*L_Temp; % [K]
for i = 1:length(AirSpeed)
    for j = 1:length(RPM)
        Q_Percent_RPM(i, j) = Unaccelerated_Level_Required_Power(Height(2), RPM(j), AirSpeed(i), Average_Weight); % [%Q]
        Q_Percent_Height(i, j) = Unaccelerated_Level_Required_Power(Height(j), Rotor_Speed, AirSpeed(i), Average_Weight); % [%Q]
        [Q_Percent_Hover_RPM(i, j), ~] = Hovering_Power_Oge(Average_Weight, T_Hover(2), Height(2)/1000, RPM(j)); % [%Q]
        [Q_Percent_Hover_Height(i, j), ~] = Hovering_Power_Oge(Average_Weight, T_Hover(j), Height(j)/1000, RPM(1)); % [%Q]
    end
    Limitation(i) = 85;
end

% Power required - Q(RPM, Airspeed)
Figure1 = figure;
hold on
Colors_AvgW = ["#D95319", "#77AC30"];
Types = ['.', 'o'];
for i = 1:length(RPM)
    plot(AirSpeed, Q_Percent_RPM(:, i), 'LineWidth', 2, 'Color', Colors_AvgW(i))
    plot(AirSpeed(1), Q_Percent_Hover_RPM(1, i), Types(i), 'MarkerSize', 15, 'Color', Colors_AvgW(i), 'LineWidth', 2)
end
plot(AirSpeed, Limitation, '--r', 'LineWidth', 2)
xlabel('Airspeed [knots]')
ylabel('Torque percentage [%Q]')
legend('Flight at 100% rotor speed', 'Hover at 100% rotor speed', 'Flight at 95% rotor speed', 'Hover at 95% rotor speed','', 'Location', 'northwest')
title('Required power for an unaccelerated flight at 3500 [ft]', 'Almog Dobrescu - Ronnel Nawy')
txt = 'Transmission limitation';
text(AirSpeed(35), 87, txt)


% Power required - Q(h, Airspeed)
Figure2 = figure;
hold on
for i = 1:length(Height)
    plot(AirSpeed, Q_Percent_Height(:, i), 'LineWidth', 2, 'Color', Colors_AvgW(i))
    plot(AirSpeed(1), Q_Percent_Hover_Height(1, i), Types(i), 'MarkerSize', 15, 'Color', Colors_AvgW(i), 'LineWidth', 2)
end
plot(AirSpeed, Limitation, '--r', 'LineWidth', 2)
xlabel('Airspeed [knots]')
ylabel('Torque percentage [%Q]')
legend('Flight at 0 [ft]', 'Hover at 0 [ft]', 'Flight at 3500 [ft]', 'Hover at 3500 [ft]','', 'Location', 'northwest')
title('Required power for an unaccelerated flight at 100% rotor speed', 'Almog Dobrescu - Ronnel Nawy')
text(AirSpeed(35), 87, txt)

%% Q2 - Optimal speed for autorotation and sink rate

% For average weight, h = 3500 [ft] and 100% rotor speed
[Optimal_Speed_avgW, Sink_Speed_avgW] = Optimal_Speed(3500, Rotor_Speed, Average_Weight) % CAS [knots], [fpm]
% For maximal weight, h = 3500 [ft] and 100% rotor speed
[Optimal_Speed_MaxW, Sink_Speed_MaxW] = Optimal_Speed(3500, Rotor_Speed, Max_TO_Weight*2.2046) % CAS [knots], [fpm]

%% Q3 - Operational ceiling

Average_Weight = ((Max_TO_Weight+Empty_Weight)/2)*2.2046; % [lb]
Ceiling_AvgW100 = Operational_Ceiling(Average_Weight, Rotor_Speed, 100) % [ft]
Ceiling_MaxW100 = Operational_Ceiling(Max_TO_Weight*2.2046, Rotor_Speed, 100) % [ft]

Ceiling_AvgW95 = Operational_Ceiling(Average_Weight, Rotor_Speed*0.95, 100) % [ft]
Ceiling_MaxW95 = Operational_Ceiling(Max_TO_Weight*2.2046, Rotor_Speed*0.95, 100) % [ft]

Ceiling_AvgW105 = Operational_Ceiling(Average_Weight, Rotor_Speed*1.05, 100) % [ft]
Ceiling_MaxW105 = Operational_Ceiling(Max_TO_Weight*2.2046, Rotor_Speed*1.05, 100) % [ft]

Ceiling_AvgW = Ceiling_AvgW100;
Ceiling_MaxW = Ceiling_MaxW100;
%% Q4 - Maximal reduced specific range and best speed

Height_AvgW = linspace(0, Ceiling_AvgW, 100); % [ft]
Height_MaxW = linspace(0, Ceiling_MaxW, 100); % [ft]

Best_Specific_Range_AvgW = [];
V_Star_AvgW = [];
Best_Specific_Range_MaxW = [];
V_Star_MaxW = [];

for i = 1:length(Height_AvgW)
    [Best_Specific_Range_AvgW(i), V_Star_AvgW(i)] = Reduced_Specific_Range(Height_AvgW(i), Rotor_Speed, Average_Weight); % [-], [KCAS]
    [Best_Specific_Range_MaxW(i), V_Star_MaxW(i)] = Reduced_Specific_Range(Height_MaxW(i), Rotor_Speed, Max_TO_Weight*2.2046); % [-], [KCAS]
end
%%
figure;
plot(Best_Specific_Range_AvgW, Height_AvgW, Best_Specific_Range_MaxW, Height_MaxW, 'linewidth', 2)
xlabel('Maximal reduced specific range [-]')
ylabel('Height [ft]')
legend('Average weight - 8900 [lb]', 'Maximal weight - 11200 [lb]', 'Location', 'northwest')
title('Maximal reduced specific range at 100% rotor speed', 'Almog Dobrescu - Ronnel Nawy')

figure;
plot(V_Star_AvgW, Height_AvgW, V_Star_MaxW, Height_MaxW, 'linewidth', 2)
xlabel('Best speed for maximal reduced specific range [KCAS]')
ylabel('Height [ft]')
legend('Average weight - 8900 [lb]', 'Maximal weight - 11200 [lb]', 'Location', 'northeast')
title('Best speed for maximal reduced specific range at 100% rotor speed', 'Almog Dobrescu - Ronnel Nawy')

figure;
hold on
colormap turbo
Colors_AvgW = linspace(1, Height_AvgW(end), length(Height_AvgW));
Color_MaxW = linspace(1, Height_MaxW(end), length(Height_AvgW));
scatter(V_Star_AvgW, Best_Specific_Range_AvgW, [], Colors_AvgW, 'filled')
scatter(V_Star_MaxW, Best_Specific_Range_MaxW, [], Color_MaxW)
colorbar

%% Q5 


hs = linspace(0, Height_AvgW(end), 100);
num_of_steps = 5;
range = [];
for i = 1:length(hs)
    range(i) = true_range(hs(i), Average_Weight, num_of_steps)*0.00054
end

plot(range, hs)

