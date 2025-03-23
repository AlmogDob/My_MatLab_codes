helicopter = "UH1N";
if "UH1N" == helicopter
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
    l_t = 8.7; % [m]
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
    
elseif "B206" == helicopter

    mo = 45; % [kg]
    R = 5.08; % [m]
    Ad = 81; % [m^2]
    c = 0.34; % [m]
    L = 4.3;  % [-]
    Nb = 2; % [-]
    Sigma = 0.04; % [-]
    Rotor_Speed = 394; % [RPM]
    Vt = 210; % [m/s]
    Delta_Z = 2; % [m]
    Rt = 0.79; % [m]
    Ad_t = 1.94; % [m^2]
    Ct = 0.1; % [m]
    Nb_t = 2; % [-]
    Sigma_t = 0.08; % [-]
    TR_Speed = 2550; % [RPM]
    Vt_t = 210; % [m/s]
    l_t = 5.7; % [m]
    Delta_Zt = 0; % [m]
    V23 = 0.0037; % [-]
    Max_TO_Weight = 3350*0.4536; % [kg]
    Empty_Weight = 1600*0.4536; % [kg]
    Cw_min = 0.0016; % [-]
    Cw_max = 0.0034; % [-]
    Pmax = 313; % [Kw]
    P1_NR100 = 2.36; % [Kw] - 1% P at 100% NR
    Torque1 = 57.2; % [N*m] - 1% torque
    Sb = 1.3; % [m^2] - Drag Area
    Sht = 2; % [m^2] - ht Area
    Delta_Xht = 5.3; % [-]
    Alpha_ht = 3.5; % [-]
    Tao = 5.6; % [s] - RPM loss const
    
    Omega = Rotor_Speed*2*pi/60; % [rad/sec]
    Omega_t = TR_Speed*2*pi/60; % [rad/sec]

elseif "UH60" == helicopter

    mo = 101.3; % [kg]
    R = 8.18; % [m]
    Ad = 210.2; % [m^2]
    c = 0.47; % [m]
    L = 6.14;  % [-]
    Nb = 4; % [-]
    Sigma = 0.073; % [-]
    Rotor_Speed = 258; % [RPM]
    Vt = 221; % [m/s]
    Delta_Z = 1.4; % [m]
    Rt = 1.67; % [m]
    Ad_t = 8.76; % [m^2]
    Ct = 0.255; % [m]
    Nb_t = 4; % [-]
    Sigma_t = 0.1944; % [-]
    TR_Speed = 1190; % [RPM]
    Vt_t = 208; % [m/s]
    l_t = 9.92; % [m]
    Delta_Zt = 1.4; % [m]
    V23 = 0.0075; % [-]
    Max_TO_Weight = 22000*0.4536; % [kg]
    Empty_Weight = 12500*0.4536; % [kg]
    Cw_min = 0.0044; % [-]
    Cw_max = 0.0078; % [-]
    Pmax = 2820; % [Kw]
    P1_NR100 = 20.6; % [Kw] - 1% P at 100% NR
    Torque1 = 762.46; % [N*m] - 1% torque
    Sb = 4; % [m^2] - Drag Area
    Sht = 3.8; % [m^2] - ht Area
    Delta_Xht = 9.25; % [-]
    Alpha_ht = 3.5; % [-]
    Tao = 3.6; % [s] - RPM loss const
    
    Omega = Rotor_Speed*2*pi/60; % [rad/sec]
    Omega_t = TR_Speed*2*pi/60; % [rad/sec]

elseif "AH64" == helicopter

    mo = 71; % [kg]
    R = 7.32; % [m]
    Ad = 168; % [m^2]
    c = 0.6; % [m]
    L = 9.98;  % [-]
    Nb = 4; % [-]
    Sigma = 0.1; % [-]
    Rotor_Speed = 289; % [RPM]
    Vt = 222; % [m/s]
    Delta_Z = 1.4; % [m]
    Rt = 1.4; % [m]
    Ad_t = 6.16; % [m^2]
    Ct = 0.26; % [m]
    Nb_t = 4; % [-]
    Sigma_t = 0.23; % [-]
    TR_Speed = 1403; % [RPM]
    Vt_t = 206; % [m/s]
    l_t = 9; % [m]
    Delta_Zt = 1.4; % [m]
    V23 = 0.006; % [-]
    Max_TO_Weight = 21500*0.4536; % [kg]
    Empty_Weight = 11500*0.4536; % [kg]
    Cw_min = 0.0051; % [-]
    Cw_max = 0.0095; % [-]
    Pmax = 2520; % [Kw]
    P1_NR100 = 20.8; % [Kw] - 1% P at 100% NR
    Torque1 = 687.3; % [N*m] - 1% torque
    Sb = 5; % [m^2] - Drag Area
    Sht = 3.8; % [m^2] - ht Area
    Delta_Xht = 9.25; % [-]
    Alpha_ht = 3.5; % [-]
    Tao = 2.2; % [s] - RPM loss const
    
    Omega = Rotor_Speed*2*pi/60; % [rad/sec]
    Omega_t = TR_Speed*2*pi/60; % [rad/sec]

elseif "SA315" == helicopter

    mo = 31.4; % [kg]
    R = 5.50; % [m]
    Ad = 95; % [m^2]
    c = 0.33; % [m]
    L = 7;  % [-]
    Nb = 3; % [-]
    Sigma = 0.06; % [-]
    Rotor_Speed = 353; % [RPM]
    Vt = 203; % [m/s]
    Delta_Z = 2; % [m]
    Rt = 0.95; % [m]
    Ad_t = 2.85; % [m^2]
    Ct = 0.1; % [m]
    Nb_t = 3; % [-]
    Sigma_t = 0.1; % [-]
    TR_Speed = 2001; % [RPM]
    Vt_t = 199; % [m/s]
    l_t = 7.1; % [m]
    Delta_Zt = 2; % [m]
    V23 = 0.0049; % [-]
    Max_TO_Weight = 4300*0.4536; % [kg]
    Empty_Weight = 1100*0.4536; % [kg]
    Cw_min = 0.0010; % [-]
    Cw_max = 0.0040; % [-]
    Pmax = 640; % [Kw]
    P1_NR100 = 4; % [Kw] - 1% P at 100% NR
    Torque1 = 108.2; % [N*m] - 1% torque
    Sb = 2; % [m^2] - Drag Area
    Sht = 2; % [m^2] - ht Area
    Delta_Xht = 5.2; % [-]
    Alpha_ht = 3.5; % [-]
    Tao = 3.2; % [s] - RPM loss const
    
    Omega = Rotor_Speed*2*pi/60; % [rad/sec]
    Omega_t = TR_Speed*2*pi/60; % [rad/sec]

elseif "Puma" == helicopter

    mo = 68; % [kg]
    R = 7.50; % [m]
    Ad = 177; % [m^2]
    c = 0.54; % [m]
    L = 9.85;  % [-]
    Nb = 4; % [-]
    Sigma = 0.09; % [-]
    Rotor_Speed = 265; % [RPM]
    Vt = 208; % [m/s]
    Delta_Z = 2.1; % [m]
    Rt = 1.56; % [m]
    Ad_t = 7.65; % [m^2]
    Ct = 0.15; % [m]
    Nb_t = 5; % [-]
    Sigma_t = 0.15; % [-]
    TR_Speed = 1279; % [RPM]
    Vt_t = 209; % [m/s]
    l_t = 9; % [m]
    Delta_Zt = 1.6; % [m]
    V23 = 0.0009; % [-]
    Max_TO_Weight = 15430*0.4536; % [kg]
    Empty_Weight = 7800*0.4536; % [kg]
    Cw_min = 0.0037; % [-]
    Cw_max = 0.0073; % [-]
    Pmax = 2350; % [Kw]
    P1_NR100 = 15.3; % [Kw] - 1% P at 100% NR
    Torque1 = 551.3; % [N*m] - 1% torque
    Sb = 4; % [m^2] - Drag Area
    Sht = 1.3; % [m^2] - ht Area
    Delta_Xht = 9; % [-]
    Alpha_ht = 3; % [-]
    Tao = 2.6; % [s] - RPM loss const
    
    Omega = Rotor_Speed*2*pi/60; % [rad/sec]
    Omega_t = TR_Speed*2*pi/60; % [rad/sec]

elseif "Lynx" == helicopter

    mo = 50; % [kg]
    R = 6.4; % [m]
    Ad = 129; % [m^2]
    c = 0.39; % [m]
    L = 7.06;  % [-]
    Nb = 4; % [-]
    Sigma = 0.08; % [-]
    Rotor_Speed = 340; % [RPM]
    Vt = 229; % [m/s]
    Delta_Z = 1.3; % [m]
    Rt = 1.11; % [m]
    Ad_t = 3.84; % [m^2]
    Ct = 0.18; % [m]
    Nb_t = 4; % [-]
    Sigma_t = 0.21; % [-]
    TR_Speed = 1844; % [RPM]
    Vt_t = 214; % [m/s]
    l_t = 7.66; % [m]
    Delta_Zt = 1.1; % [m]
    V23 = 0.0045; % [-]
    Max_TO_Weight = 11750*0.4536; % [kg]
    Empty_Weight = 7225*0.4536; % [kg]
    Cw_min = 0.0039; % [-]
    Cw_max = 0.0064; % [-]
    Pmax = 1500; % [Kw]
    P1_NR100 = 13.2; % [Kw] - 1% P at 100% NR
    Torque1 = 369.7; % [N*m] - 1% torque
    Sb = 3; % [m^2] - Drag Area
    Sht = 1.2; % [m^2] - ht Area
    Delta_Xht = 7.66; % [-]
    Alpha_ht = 3; % [-]
    Tao = 2.6; % [s] - RPM loss const
    
    Omega = Rotor_Speed*2*pi/60; % [rad/sec]
    Omega_t = TR_Speed*2*pi/60; % [rad/sec]
end

Cd0 = 0.014;
Cd0_t = 0.014;
ki = 0.8;
ki_t = 0.5;
L_Temp = 6.5*10^(-3); % [K/m]

Sd = 2.3368*(12.68476+3.88747*1.5)/2;
Sd_Bar = Sd/Ad;
Sb_Bar = Sb/Ad;

% Sea-level atmospheric conditions
T_SL = 288; % [k]
P_SL = 101325; % [pa]
Rho_SL = 1.225; % [kg/m^3]

Weight = (Max_TO_Weight + Empty_Weight)/2; % [kg]
Cw = (Weight*9.81)/(Rho_SL*(Vt^2)*Ad);

F = Vt/sqrt(9.81*R);
m_bar = Cw*F^2;

gx_bar = 0.17;
gy_bar = 0.3;
gz_bar = 0.3;
gxz_bar = 0.08;

Ix_bar = m_bar*gx_bar^2;
Iy_bar = m_bar*gy_bar^2;
Iz_bar = m_bar*gz_bar^2;
Ixz_bar = m_bar*gxz_bar^2;