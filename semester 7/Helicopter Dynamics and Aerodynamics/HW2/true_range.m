function [range] = true_range(h, W, num_of_steps)
% 
% Inputs - h [ft], W [lb]
% Output - 

Helicopter_Parameters;

Pilot_Weight = 200*2; % [lb]
Fuel_Minimal_Weight = P1_NR100*20; % [lb]
Total_Minimal_TO_Weight = Empty_Weight*2.2046 + Fuel_Minimal_Weight + Pilot_Weight; % [lb]

Fuel_Weight = Max_TO_Weight*2.2046 - Total_Minimal_TO_Weight; % [lb]

C_sp_freedomU = 0.5; % [lb/hr/hp]
C_sp_SI = C_sp_freedomU*1.6897e-7; % [s^2/m^2]
Ws = [];
% Ws = linspace(Total_Minimal_TO_Weight, W, 2);
Ws = linspace(Total_Minimal_TO_Weight, Max_TO_Weight*2.2046, num_of_steps);

% Best_Specific_Range_AvgW = [];
% for i = 1:length(Ws)
%    [Best_Specific_Range_AvgW(i), ~] = Reduced_Specific_Range(h, Rotor_Speed, W);
% end
% range = trapz(Ws./2.2046, 1/C_sp_SI.*Best_Specific_Range_AvgW./(Ws.*9.81./2.2046));



[Best_Specific_Range_AvgW, ~] = Reduced_Specific_Range(h, Rotor_Speed, W);
range = Best_Specific_Range_AvgW/9.81/C_sp_SI*log(Max_TO_Weight*2.2046/Total_Minimal_TO_Weight);



end