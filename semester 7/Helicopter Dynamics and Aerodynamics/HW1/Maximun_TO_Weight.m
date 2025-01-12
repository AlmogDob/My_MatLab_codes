function [Max_TO_Weight_Oge, Max_TO_Weight_Ige] = Maximun_TO_Weight(h, T, RPM)
% Returns the maximal take-off weight in and out ground effect
% Inputs - h [kft], T [K], RPM [rpm]
% Outputs - Max_TO_Weight_Oge [N] , Max_TO_Weight_Ige [N]

Helicopter_Parameters;

% Translating inputs
h = h*0.3048*1000; % [m]
Omega_New = RPM*2*pi/60; % [rad/sec]
Vt_New = Omega_New*R; % [m/sec]

% Weight reduction factor
a = 0.45;
b = 0.55;
c = 0.8;
d = 0.5;
h_ige = 1.5*R; % [m]
w_ige = a + b*tanh(c*((h_ige/R)+d));
ki_IGE = 1/(w_ige^3);

% Maximal engine power change with altitude constants
a0 = -4.6;
a1 = 8.9;
a2 = -3.3; 
b = 1.2;

% Atmospheric conditions
T_SL_STD = 288; % [K]
T_SL = T + L*h; % [K]
T_Bar = T/T_SL_STD;
Pressure_SL_STD = 101325; % [pa]
Pressure = Pressure_SL_STD*(T/T_SL)^5.26; % [pa]
Pressure_Bar = Pressure/Pressure_SL_STD;
Rho = Pressure/(287*T); % [kg/m^3]
Rho_SL_STD = 1.225; % [kg/m^3]
Rho_Bar = Rho/Rho_SL_STD;

% Normalized engine power
Cp0 = Sigma*Cdo/8;
P0_SL = Rho_SL_STD*Ad*Vt_New^3*Cp0; % [W]

% Maximal rated power at standart sea level
P0 = Pmax*1000; % [W]

% Maximal engine power change with altitude
P = P0*Pressure_Bar*sqrt(T_Bar)*(a0 + a1/(T_Bar^b) + a2/(T_Bar^(2*b))); % [W]

% Maximal engine torque
Q_Max_Engine = P/Omega_New; % [N*m]

% Maximal transmission torque
Q_Max_Transmission = Torque1*100; % [N*m]

% Estimating the maximum weight without tail while identifying the limiting element
% % OGE
% if Q_Max_Engine < Q_Max_Transmission
%     Q_max = Q_Max_Engine;
%     Max_TO_Weight_Oge = (sqrt(2*Rho_SL_STD*Ad*ki)*((Rho_Bar^0.5)*P - (Rho_Bar^1.5)*P0_SL))^(2/3); % [N]
% else
%     Q_max = Q_Max_Transmission;
%     Max_TO_Weight_Oge = (sqrt(2*Rho_SL_STD*Ad*ki)*((Rho_Bar^0.5)*Q_Max_Transmission*Omega_New - (Rho_Bar^1.5)*P0_SL))^(2/3); % [N]
% end
% %IGE
% if Q_Max_Engine < Q_Max_Transmission
%     Max_TO_Weight_Ige = (sqrt(2*Rho_SL_STD*Ad*ki*ki_IGE)*((Rho_Bar^0.5)*P - (Rho_Bar^1.5)*P0_SL))^(2/3); % [N]
% else
%     Max_TO_Weight_Ige = (sqrt(2*Rho_SL_STD*Ad*ki*ki_IGE)*((Rho_Bar^0.5)*Q_Max_Transmission*Omega_New - (Rho_Bar^1.5)*P0_SL))^(2/3); % [N]
% end

if Q_Max_Engine < Q_Max_Transmission
    CQ_max = Q_Max_Engine/(Rho*Vt_New^2*R*Ad);
else
    CQ_max = Q_Max_Transmission/(Rho*Vt_New^2*R*Ad);
end

% numeric solution for max TO weight with tail:
% OGE
syms CW
rho = Rho_Bar*Rho_SL_STD;
CQh = Cp0 + CW^(3/2)/sqrt(2*ki);
CQ_tot = subs(CQh*(1+ (R/Rt) * (R/L_t)^(3/2)*sqrt(CQh/(2*ki_t)))) == CQ_max;
temp = solve(CQ_tot, CW, "Real",true, "ReturnConditions",true);
CW = double(temp.CW);
Max_TO_Weight_Oge = CW*rho*Vt_New^2*Ad;

% IGE
syms CW
rho = Rho_Bar*Rho_SL_STD;
CQh = Cp0 + CW^(3/2)/sqrt(2*ki*ki_IGE);
CQ_tot = subs(CQh*(1+ (R/Rt) * (R/L_t)^(3/2)*sqrt(CQh/(2*ki_t)))) == CQ_max;
temp = solve(CQ_tot, CW, "Real",true, "ReturnConditions",true);
CW = double(temp.CW);
Max_TO_Weight_Ige = CW*rho*Vt_New^2*Ad;

end

