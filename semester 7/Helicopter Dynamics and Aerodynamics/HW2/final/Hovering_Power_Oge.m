function [Q_oge_Percent] = Hovering_Power_Oge(W, h, RPM)
% Estimates the power required to hover OGE 
% Inputs - W [lb], h [kft], RPM [rpm]
% Output - Q_oge_Percent [%Q]

Helicopter_Parameters;

% Unit Conversion
W = W*0.4536; % [kg]
h = h*0.3048*1000; % [m] - Pressure height
Omega_New = RPM*2*pi/60; % [rad/sec]
Vt_New = Omega_New*R; % [m/sec]

% Standart conditions
T_SL = 288; % [K]
P_SL = 101325;
Rho_SL = 1.225; % [kg/m^3]

% Atmospheric conditions
P = P_SL*(1-L_Temp*h/T_SL)^5.26; % [pa]
P_Bar = P/P_SL; % [-]
T_Bar = P_Bar^(0.4/1.4); % [-]
T = T_Bar*T_SL; % [K]
Rho = P/(287*T); % [kg/m^3]

% Normalized Weight
W = W*9.81; % [N]
Cw_oge = W./(Rho*(Vt_New^2)*Ad);

% Normalized power
Cp0 = Sigma*Cd0/8;
Cph_oge = Cp0 + ((Cw_oge).^(3/2))./sqrt(2*ki);

% Normalized torque
Cq_oge = Cph_oge;

% Computing the torque percentage
Q_tot_oge = Cq_oge.*(Rho*(Vt_New^2)*R*Ad); % [N*m]
Q_oge_Percent = Q_tot_oge./Torque1; % [%Q]

end

