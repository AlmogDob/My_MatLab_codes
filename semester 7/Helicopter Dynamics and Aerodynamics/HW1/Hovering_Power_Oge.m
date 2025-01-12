function [Q_oge_Percent, Q_t_oge_Percent] = Hovering_Power_Oge(W,T, h)
% Estimates the power required to hover OGE 
% Inputs - W [lb], T [K], h [kft]
% Output - Q_oge_Percent [%Q] 

Helicopter_Parameters;

% Unit Conversion
W = W*0.4536; % [kg]
h = h*0.3048*1000; % [m]

% Density at a given height and temperature
T_SL = T + L*h; % [K]
Rho_SL = 1.225; % [kg/m^3]
Rho = Rho_SL*(T/T_SL)^4.26; % [kg/m^3]  

% Normalized Weight
W = W*9.81; % [N]
Cw_oge = W./(Rho*(Vt^2)*Ad);

% Normalized power
Cp0 = Sigma*Cdo/8;
Cph_oge = Cp0 + ((Cw_oge).^(3/2))./sqrt(2*ki);

% Normalized torque
Cqh_oge = Cph_oge;
Cq_tot_oge = Cqh_oge.*(1+(R/Rt)*((R/L_t)^(3/2))*sqrt(Cqh_oge./(2*ki_t)));
Cq_t_tot_oge = Cqh_oge.*((R/Rt)*((R/L_t)^(3/2))*sqrt(Cqh_oge./(2*ki_t))) + (1/8)*(Vt_t/Vt)^3*(Rt/R)^2*Sigma_t*Cdo_t;

% Computing the torque percentage
Q_tot_oge = Cq_tot_oge.*(Rho*(Vt^2)*R*Ad); % [N*m]
Q_t_tot_oge = Cq_t_tot_oge.*(Rho*(Vt^2)*R*Ad); % [N*m]
Q_oge_Percent = Q_tot_oge./Torque1; % [%Q]
Q_t_oge_Percent = Q_t_tot_oge./Torque1; % [%Q]

end

