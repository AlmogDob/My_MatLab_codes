function [Specific_Range, V_Star_CAS] = Reduced_Specific_Range(h, RPM, W)
% Estimates the maximal reduced specific range and the speed for it
% Inputs - h [ft], RPM [rpm], W [lb]
% Output - Specific_Range [-], V_Star_CAS [knots - CAS]

Helicopter_Parameters;

% Translating inputs
h = h*0.3048; % [m] - Pressure height
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

% Normalized weight
W = W*9.81/2.2046; % [N]
Cw = W/(Rho*(Vt_New^2)*Ad);

% Normalizing
Sb_Bar = Sb/Ad;

U_Star = ((Cw^2)/Sb_Bar)^0.25;
w_Small = Sigma*Cd0/(4*Sb_Bar);

% Finding best Mu for maximal Specific range
syms Star_Mu 
assume(Star_Mu, "positive")
eqn = w_Small*(-Star_Mu+3*Star_Mu^3)-2*U_Star^4+2*Star_Mu^4 == 0;
Mu_Star = double(solve(eqn, Star_Mu, real=true));

% Normalized power
Cp0_r = Sigma*Cd0*(1+3*Mu_Star^2)/8;
Cp0_b = 0.5*Sb_Bar*Mu_Star^3;
Cp_i = Cw*sqrt((-Mu_Star^2 + sqrt(Mu_Star^4 + (ki*Cw)^2))/(2*ki^2));
Cp = Cp0_r + Cp0_b + Cp_i;

% Engine maximal power at different altitudes
a0 = -4.6;
a1 = 8.9;
a2 = -3.3;
b = 1.2;
P0 = Pmax*1000; % [W]
P_Eng = P0*P_Bar*sqrt(T_Bar)*(a0 + a1/(T_Bar^b) + a2/(T_Bar^(2*b))); % [W]

% Normalized limits
Cp_Engine_Limit = 0.85*P_Eng/(Rho*(Vt_New^3)*Ad); % Engine limit
Cq_Limit = 0.85*100*Torque1/(Rho*(Vt_New^2)*Ad*R); % Transmission limit
Cp_Limit = min([Cp_Engine_Limit, Cq_Limit]);

% Finding the Mu when limited
syms Limit 
assume(Limit, "real")
Cp0_r = Sigma*Cd0*(1+3*Limit^2)/8;
Cp0_b = 0.5*Sb_Bar*Limit^3;
Cp_i = Cw*sqrt((-Limit^2 + sqrt(Limit^4 + (ki*Cw)^2))/(2*ki^2));
eqn2 = Cp0_r + Cp0_b + Cp_i == Cp_Limit;
Mu_Limit = double(vpasolve(eqn2, Limit, [0 inf]));

% Returning the best specific range and speed taking in account the
% limitations
if Cp <= Cp_Limit % If limited
    Specific_Range  = Cw*Mu_Star/Cp; % [-]
    V_Star_TAS = Mu_Star*Vt_New;
    V_Star_CAS = CAS_To_TAS(V_Star_TAS, Rho_SL, Rho, P_SL, P, false)*1.94384449; % [KCAS]
else % Not limited
    V_Star_TAS = Mu_Limit*Vt_New;
    V_Star_CAS = CAS_To_TAS(V_Star_TAS, Rho_SL, Rho, P_SL, P, false)*1.94384449; % [KCAS]
    Specific_Range  = Cw*Mu_Limit/Cp_Limit; % [-]
end

end

