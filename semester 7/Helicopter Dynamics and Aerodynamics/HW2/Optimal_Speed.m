function [V_Star, V_C_Star] = Optimal_Speed(h, RPM, W)
% Estimates the optimal speed for autorotation and the sink rate
% Inputs - h [ft], RPM [rpm], W [lb]
% Output - V_Star [knots], V_C_Star [knots]

Helicopter_Parameters;

% Translating inputs
h = h*0.3048; % [m]
Omega_New = RPM*2*pi/60; % [rad/sec]
Vt_New = Omega_New*R; % [m/sec]

% Standart conditions
T_SL = 288; % [K]
P_SL = 101325;
Rho_SL = 1.225; % [kg/m^3]

% Atmospheric conditions
T = T_SL - L_Temp*h; % [K]
Rho = Rho_SL*(T/T_SL)^4.26; % [kg/m^3]
P = Rho*287*T;

% Normalized weight
W = W*9.81/2.2046; % [N]
Cw = W/(Rho*(Vt_New^2)*Ad);

Sb_Bar = Sb/Ad;

% Optimal speed for autorotation
syms Cross_Mu
eqn = 0.75*Sigma*Cd0*Cross_Mu - (Cw^2)/(2*Cross_Mu^2) + 1.5*Sb_Bar*Cross_Mu^2 == 0;
Mu_Cross = double(solve(eqn, Cross_Mu));
% V_Star = Mu_Star*Vt_New*1.94384449;
for i = 1:length(Mu_Cross)
    if Mu_Cross(i)>=0
        V_Star_TAS = Mu_Cross(i)*Vt_New; % [TAS - m/sec]
        Cross_Mu = Mu_Cross(i);
    end
end

% Sink rate
Cp0_r = Sigma*Cd0*(1+3*Cross_Mu^2)/8;
Cp0_b = 0.5*Sb_Bar*Cross_Mu^3;
% Cp_i = Cw*sqrt((-Cross_Mu^2 + sqrt(Cross_Mu^4 + (ki*Cw)^2))/(2*ki^2));
% Cp_Level = Cp0_r + Cp0_b + Cp_i;
% Lambda_C_Star = -Cp_Level/Cw; % Cp=0 - Powerless descent
Lambda_C_Star = ((-Cp0_r - Cp0_b)/Cw - sqrt((-Cross_Mu^2 + sqrt(Cross_Mu^4 + (ki*Cw)^2))/(2*ki^2)))/(1 - (-Cross_Mu^2 + sqrt(Cross_Mu^4 + ki^2*Cw^2))/(2*sqrt(Cross_Mu^4 + ki^2*Cw^2)));
V_C_Star_TAS = Lambda_C_Star*Vt_New; % [m/sec]

V_Star = CAS_To_TAS(V_Star_TAS, Rho_SL, Rho, P_SL, P, false)*1.94384449; % [KCAS]
V_C_Star = CAS_To_TAS(V_C_Star_TAS, Rho_SL, Rho, P_SL, P, false)*196.85; % [CAS - fpm]

end




