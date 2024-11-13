clc; clear;

syms CL_delta_a CL_beta CN_delta_r CN_beta CY_delta_r CY_beta wing_load rho Vs V Cw Ycg_minus_Ye

CL_delta_a = -0.22;
CL_beta = -0.05;
CN_delta_r = -0.06;
CN_beta = 0.08;
CY_delta_r = 0.15;
CY_beta = -0.3;
wing_load = 1100;
rho = 1.225;
% Vs = 35;
% V = 1.05*Vs;
Cw = wing_load*2/(rho*V^2);
Ycg_minus_Ye = -2.7/(2*12); % [m] minus for left

syms delta_r beta delta_a phi 
eq1 = CL_delta_a*delta_a + CL_beta*beta == 0;
eq2 = CY_delta_r*delta_r + CY_beta*beta == -Cw*phi;
eq3 = CN_delta_r*delta_r + CN_beta*beta == -0.25*Cw*(Ycg_minus_Ye);

% phi = 5*pi/180;
% delta_r = -15*pi/180;
% delta_a = -6.2*pi/180;

eq1 = subs(eq1);
eq2 = subs(eq2);
eq3 = subs(eq3);

S = solve([eq1, eq2, eq3],[V phi beta]);

% double(S.V)

soultion = solve([S.phi(1,1)==5*pi/180], delta_a, "ReturnConditions",true);

delta_a = soultion.delta_a;

V = subs(S.V(2,1))
V_im = [];
del_rs = linspace(-15,-0.01,1000);
for i = 1:length(del_rs) 
    del_rs(i)
    delta_r = del_rs(i)*pi/180;
    V_im(i) = subs(V);
end

plot(del_rs, V_im./35)



