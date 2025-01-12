function [Q_Percent] = Unaccelerated_Level_Required_Power(h, RPM, AirSpeed_CAS, W)
% Estimates the power required for an unaccelerated level flight
% Inputs - h [ft], W [lb], AirSpeed [knots]
% Output - Q_Percent [%Q]

Helicopter_Parameters;

% Translating inputs
h = h*0.3048; % [m] - Pressure height
Omega_New = RPM*2*pi/60; % [rad/sec]
Vt_New = Omega_New*R; % [m/sec]
AirSpeed_CAS = AirSpeed_CAS*0.5144; % [m/s]

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

DeltaP_CAS = P_SL*((0.4*Rho_SL*AirSpeed_CAS^2/(2.8*P_SL)+1)^(1.4/0.4)-1);
AirSpeed = sqrt((2.8*P/(0.4*Rho))*((DeltaP_CAS/P+1)^(1/3.5)-1)); % [True - m/sec]

% Normalized weight
W = W*9.81/2.2046; % [N]
Cw = W/(Rho*(Vt_New^2)*Ad);

% Normalized power
Sb_Bar = Sb/Ad;
Mu = AirSpeed/Vt_New;
Cp0_r = Sigma*Cd0*(1+3*Mu^2)/8;
Cp0_b = 0.5*Sb_Bar*Mu^3;
Cp_i = Cw*sqrt((-Mu^2 + sqrt(Mu^4 + (ki*Cw)^2))/(2*ki^2));
Cp = Cp0_r + Cp0_b + Cp_i;

% Normalized torque
Cq = Cp;
Q = Cq*(Rho*(Vt_New^2)*R*Ad); % [N*m]
Q_Percent = Q/Torque1; % [%Q]   

end

