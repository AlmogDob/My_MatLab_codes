function [V] = CAS_To_TAS(V_Input, Rho_SL, Rho, P_SL, P, CAS_TAS)
% Converts CAS to TAS or TAS to CAS
% Inputs - V_Input [m/sec], Rho_SL [kg/m^3], Rho [kg/m^3], P_SL [Pa], P
% [Pa], CAS_TAS [bool]
% Output - V [m/sec]

if CAS_TAS==true % CAS to TAS
    DeltaP_CAS = P_SL*((0.4*Rho_SL*V_Input^2/(2.8*P_SL)+1)^(1.4/0.4)-1);
    V = sqrt((2.8*P/(0.4*Rho))*((DeltaP_CAS/P+1)^(1/3.5)-1)); % [TAS - m/sec]
    if sign(V_Input)==-1 % Adjusting the sign
        V = -V;
    end
else % TAS to CAS
    DeltaP_TAS = P*((0.4*Rho*V_Input^2/(2.8*P)+1)^(1.4/0.4)-1);
    V = sqrt((2.8*P_SL/(0.4*Rho_SL))*((DeltaP_TAS/P_SL+1)^(1/3.5)-1)); % [TAS - m/sec]
    if sign(V_Input)==-1 % Adjusting the sign
        V = -V;
    end
end

