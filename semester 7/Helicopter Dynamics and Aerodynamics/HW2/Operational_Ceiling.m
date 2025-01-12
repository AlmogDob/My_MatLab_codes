function [Ceiling] = Operational_Ceiling(W, RPM, Max_Climb_Rate)
% Estimates 
% Inputs - 
% Output - 

Helicopter_Parameters;

% Translating inputs
Omega_New = RPM*2*pi/60; % [rad/sec]
Vt_New = Omega_New*R; % [m/sec]
Max_Climb_Rate = Max_Climb_Rate*0.00508; % [m/sec]
W = W*9.81/2.2046; % [N]

% Standart conditions
T_SL = 288; % [K]
P_SL = 101325; % [pa]
Rho_SL = 1.225; % [kg/m^3]

% syms h
hs = 1000:50:20000;

for i = 1:length(hs)
    h = hs(i);

    % Atmosphere conditions
    T = T_SL - L_Temp*h; % [K]
    Rho = Rho_SL*(T/T_SL)^4.26; % [kg/m^3]
    P = Rho*287*T; % [pa]
    
    % Normalized
    P_Bar = P/P_SL;
    T_Bar = T/T_SL;
    Cw = W/(Rho*(Vt_New^2)*Ad);
    Sb_Bar = Sb/Ad;
    
    % Maximal engine power with change of altitude
    a0 = -4.6;
    a1 = 8.9;
    a2 = -3.3; 
    b = 1.2;
    
    P0 = Pmax*1000; % [W]
    P_eng = P0*P_Bar*sqrt(T_Bar)*(a0 + a1/(T_Bar^b) + a2/(T_Bar^(2*b))); % [W]
    Cp_Engine_Limit = 0.85*P_eng/(Rho*(Vt_New^3)*Ad);

    Cq_Limit = 0.85*100*Torque1/(Rho*(Vt_New^2)*Ad*R);
    
    U_Star = ((Cw^2)/Sb_Bar)^0.25;
    w_Small = Sigma*Cd0/(4*Sb_Bar);
    
    syms Cross_Mu 
    assume(Cross_Mu, "positive")
    eqn = 0.75*Sigma*Cd0*Cross_Mu - (Cw^2)/(2*Cross_Mu^2) + 1.5*Sb_Bar*Cross_Mu^2 == 0;
    Mu_Cross = double(solve(eqn, Cross_Mu, Real=true));

    Cp0_r = Sigma*Cd0*(1+3*Mu_Cross^2)/8;
    Cp0_b = 0.5*Sb_Bar*Mu_Cross^3;

    Cp_Limit = min([Cp_Engine_Limit, Cq_Limit]);

    Ps = (Cp_Limit - (Cp0_r + Cp0_b));
    Ps_Needed = Cw*Max_Climb_Rate/Vt_New + Cw^2/(2*Mu_Cross);

    if Ps < Ps_Needed
        break
    end

end

Ceiling = hs(i-1)*3.280839895; % [ft]

end
