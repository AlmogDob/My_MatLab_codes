% UH1N

mo = 101.3; % [kg]
R = 8.18; % [m]
Ad = 210.2; % [m^2]
c = 0.47; % [m]
L = 6.14;  % [-]
Nb = 4; % [-]
Sigma = 0.073; % [-]
Rotor_Speed = 258; % [RPM]
Vt = 221; % [m/s]
Delta_Z = 0; % [m]
Rt = 1.67; % [m]
Ad_t = 8.76; % [m^2]
Ct = 0.255; % [m]
Nb_t = 4; % [-]
Sigma_t = 0.1944; % [-]
TR_Speed = 1190; % [RPM]
Vt_t = 226; % [m/s]
L_t = 8.7; % [m]
Delta_Z_ht = 0; % [m]
V23 = 0.0046; % [-]
Max_TO_Weight = 22000*0.4536; % [kg]
Empty_Weight = 12500*0.4536; % [kg]
Cw_min = 0.0044; % [-]
Cw_max = 0.0078; % [-]
Pmax = 2820; % [Kw]
P1_NR100 = 20.6; % [Kw] - 1% P at 100% NR
Torque1 = 762.46; % [N*m] - 1% torque
Sb = 4; % [m^2] - Drag Area
Sht = 0; % [m^2] - ht Area
Delta_Xht = 0; % [-]
Alpha_ht = 0; % [-]
Tao = 4.3; % [s] - RPM loss const

Omega = Rotor_Speed*2*pi/60; % [rad/sec]
Omega_t = TR_Speed*2*pi/60; % [rad/sec]

% Almog Check
Cd0 = 0.014;
Cd0_t = 0.014;
ki = 0.8;
ki_t = 0.5;
L_Temp = 6.5*10^(-3); % [K/m]


