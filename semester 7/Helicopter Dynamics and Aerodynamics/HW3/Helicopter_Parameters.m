% UH1N

mo = 99.58289; % [kg]
R = 7.32; % [m]
Ad = 168.3341; % [m^2]
c = 0.59; % [m]
L = 7;  % [-]
Nb = 2; % [-]
Sigma = 0.051312; % [-]
Rotor_Speed = 324; % [RPM]
Vt = 248.3617; % [m/s]
Delta_Z = 2; % [m]
Rt = 1.3; % [m]
Ad_t = 5.309292; % [m^2]
Ct = 0.292; % [m]
Nb_t = 2; % [-]
Sigma_t = 0.142995; % [-]
TR_Speed = 1662; % [RPM]
Vt_t = 226.2575; % [m/s]
L_t = 8.7; % [m]
Delta_Zt = 2; % [m]
V23 = 0.0046; % [-]
Max_TO_Weight = 11200*0.4536; % [kg]
Empty_Weight = 6600*0.4536; % [kg]
Cw_min = 0.002311; % [-]
Cw_max = 0.003922; % [-]
Pmax = 1300; % [Kw]
P1_NR100 = 9.66; % [Kw] - 1% P at 100% NR
Torque1 = 284.7105; % [N*m] - 1% torque
Sb = 4; % [m^2] - Drag Area
Sht = 2.5; % [m^2] - ht Area
Delta_Xht = 5.5; % [-]
Alpha_ht = 3.5; % [-]
Tao_RPM = 4.3; % [s] - RPM loss const

Omega = Rotor_Speed*2*pi/60; % [rad/sec]
Omega_t = TR_Speed*2*pi/60; % [rad/sec]

Cd0 = 0.014;
Cd0_t = 0.014;
ki = 0.8;
ki_t = 0.5;
L_Temp = 6.5*10^(-3); % [K/m]

Sd = 2.3368*(12.68476+3.88747*1.5)/2;
Sd_Bar = Sd/Ad;
Sb_Bar = Sb/Ad;

