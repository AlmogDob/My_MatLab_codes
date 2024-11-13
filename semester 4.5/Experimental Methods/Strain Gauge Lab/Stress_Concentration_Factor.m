%% Stress Concentration Factor From Strain Gauge

clc
format long
% defenitions
W = 48*10^(-3); % [m]
d = 14*10^(-3); % [m]
SG1_mV = [-0.027978 0.006413 0.039170 0.075632 0.106261 0.140919 0.174940 0.208985 0.242408];
SG3_mV = [-0.031861 -0.016631 0.000269 0.018971 0.035308 0.053895 0.072284 0.090990 0.108793];
loads = [-0.412460 1010.118585 2009.896962 3045.352885 4001.054587 5028.132844 6040.004406 7031.531806 8029.624247];

%soultion
SG1_V = (SG1_mV - SG1_mV(1))*10^(-3);
SG3_V = (SG3_mV - SG3_mV(1))*10^(-3);

SG1_V = SG1_V(2:end);
SG3_V = SG3_V(2:end);

Kts_SG = [];

for i=1:length(SG1_V)
    Kts_SG(i) = (1-d/W)*(SG1_V(i)/SG3_V(i));
end

Kt_avg_SG = sum(Kts_SG)/length(Kts_SG)

plot(loads(2:end), Kts_SG)
hold all

%% Stress Concentration Factor From Photoelasticity

Kts_PE = [];
Fringe_order_N_max = [0.45 0.8 1 1.22 1.39 1.63 2.35 2.5 3];
Fringe_order_N_inf = [0.28 0.28 0.8 0.8 0.9 1 1.08 1.08 1.22];
Kts_PE = Fringe_order_N_max./Fringe_order_N_inf;
Kt_avg_PE = sum(Kts_PE)/length(Kts_PE)

plot(loads(2:end), Kts_PE(2:end))
legend('Kts_S_G','Kts_P_E')

%% Analytical Solution

Kt_Analytical = 3.0039-3.753*(d/W)+7.9735*(d/W)^2-9.2659*(d/W)^3+1.8145*(d/W)^4+2.9684*(d/W)^5
