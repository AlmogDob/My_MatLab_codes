function [Q_oge_Percent, Q_t_oge_Percent] = Hovering_Power_Oge(W,T, h, RPM)
% Estimates the power required to hover OGE 
% Inputs - W [lb], T [K], h [kft], RPM [rpm]
% Output - Q_oge_Percent [%Q], Q_t_oge_Percent [%Q]

Helicopter_Parameters;

% Unit Conversion
W = W*0.4536; % [kg]
h = h*0.3048*1000; % [m]
Omega_New = RPM*2*pi/60; % [rad/sec]
Vt_New = Omega_New*R; % [m/sec]

% Density at a given height and temperature
T_SL = T + L_Temp*h; % [K]
Rho_SL = 1.225; % [kg/m^3]
Rho = Rho_SL*(T/T_SL)^4.26; % [kg/m^3]  

% Normalized Weight
W = W*9.81; % [N]
Cw_oge = W./(Rho*(Vt_New^2)*Ad);

% Normalized power
Cp0 = Sigma*Cd0/8;
Cph_oge = Cp0 + ((Cw_oge).^(3/2))./sqrt(2*ki);

% Normalized torque
Cqh_oge = Cph_oge;
Cq_tot_oge = Cqh_oge;
Cq_t_tot_oge = Cqh_oge.*((R/Rt)*((R/L_t)^(3/2))*sqrt(Cqh_oge./(2*ki_t))) + (1/8)*(Vt_t/Vt_New)^3*(Rt/R)^2*Sigma_t*Cd0_t;

% Computing the torque percentage
Q_tot_oge = Cq_tot_oge.*(Rho*(Vt_New^2)*R*Ad); % [N*m]
Q_t_tot_oge = Cq_t_tot_oge.*(Rho*(Vt_New^2)*R*Ad); % [N*m]
Q_oge_Percent = Q_tot_oge./Torque1; % [%Q]
Q_t_oge_Percent = Q_t_tot_oge./Torque1; % [%Q]

end

