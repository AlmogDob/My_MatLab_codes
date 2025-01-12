function [Q_ige_Percent, Q_t_ige_Percent] = Hovering_Power_Ige(W, T, h)
% Estimates the power required to hover IGE
% Inputs - W [lb], T [K], h [kft]
% Output - Q_ige_Percent [%Q] 

Helicopter_Parameters;

% Unit Conversion
W = W*0.4536; % [kg]
h = h*0.3048*1000; % [m]

% Density at a given height and temperature
T_SL = T + L*h; % [K]
Rho_SL = 1.225; % [kg/m^3]
Rho = Rho_SL*(T/T_SL)^4.26; % [kg/m^3]

% Weight reduction factor
a = 0.45;
b = 0.55;
c = 0.8;
d = 0.5;
h_ige = 1.5*R; % [m]
w_ige = a + b*tanh(c*((h_ige/R)+d));

% Normalized Weight
W = W*9.81*w_ige; % [N]
Cw_ige = W./(Rho*(Vt^2)*Ad);

% Normalized power
Cp0 = Sigma*Cdo/8;
Cph_ige = Cp0 + ((Cw_ige).^(3/2))./sqrt(2*ki);

% Normalized torque
Cqh_ige = Cph_ige;
Cq_tot_ige = Cqh_ige.*(1+(R/Rt)*((R/L_t)^(3/2))*sqrt(Cqh_ige./(2*ki_t)));
Cq_t_tot_ige = Cqh_ige.*((R/Rt)*((R/L_t)^(3/2))*sqrt(Cqh_ige./(2*ki_t))) + (1/8)*(Vt_t/Vt)^3*(Rt/R)^2*Sigma_t*Cdo_t;

% Computing the percentage torque
Q_tot_ige = Cq_tot_ige.*(Rho*(Vt^2)*R*Ad); % [N*m]
Q_t_tot_ige = Cq_t_tot_ige.*(Rho*(Vt^2)*R*Ad); % [N*m]
Q_ige_Percent = Q_tot_ige./Torque1; % [%Q]
Q_t_ige_Percent = Q_t_tot_ige./Torque1; % [%Q]

end

