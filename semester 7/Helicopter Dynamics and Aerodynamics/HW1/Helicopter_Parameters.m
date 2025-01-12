% UH1N

mo = 101.3; % [kg]
R = 7.32; % [m]
Ad = 168; % [m^2]
c = 0.6; % [m]
L = 7;  % [-]
Nb = 2; % [-]
Sigma = 0.05; % [-]
Rotor_Speed = 324; % [RPM]
Vt = 248; % [m/s]
Delta_Z = 0; % [m]
Rt = 1.3; % [m]
Ad_t = 5.31; % [m^2]
Ct = 0.31; % [m]
Nb_t = 2; % [-]
Sigma_t = 0.15; % [-]
TR_Speed = 1662; % [RPM]
Vt_t = 226; % [m/s]
L_t = 8.7; % [m]
Delta_Z_ht = 0; % [m]
V23 = 0.0046; % [-]
Max_TO_Weight = 11200*0.4536; % [kg]
Empty_Weight = 6600*0.4536; % [kg]
Cw_min = 0.0023; % [-]
Cw_max = 0.0039; % [-]
Pmax = 1300; % [Kw]
P1_NR100 = 9.66; % [Kw] - 1% P at 100% NR
Torque1 = 284.7; % [N*m] - 1% torque
Sb = 4; % [m^2] - Drag Area
Sht = 0; % [m^2] - ht Area
Delta_Xht = 0; % [-]
Alpha_ht = 0; % [-]
Tao = 4.3; % [s] - RPM loss const

Omega = Rotor_Speed*2*pi/60; % [rad/sec]
Omega_t = TR_Speed*2*pi/60; % [rad/sec]

% Almog Check
Cdo = 0.014;
Cdo_t = 0.014;
ki = 0.8;
ki_t = 0.5;
L = 6.5*10^(-3); % [K/m]


