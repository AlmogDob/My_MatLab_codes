function [Beta_1s, Beta_1c, Phi, Tao, Theta_1s, Theta_1c, Theta_75, Theta_75_t] = Trim_Equations(Weight, Mu, w_bar, Delta_X, Delta_Y, Delta_Z)
% Solving the trim equations and computing the angles
% Inputs: Weight [kg], Mu [-], w_bar[-], Delta_X [m], Delta_Y [m], Delta_Z [m]
% Outputs: All the angles are in [deg]

% Note: Lambda_C = 0 in all the question, therefore we did not implement it

% Data
Helicopter_Parameters;
e_eff = 0.04;
L = 7;
a = 2*pi;
at = a;
E_eff = 1.5*e_eff;

K_beta_Bar = 3*Sigma*a*e_eff/(4*L);
ht = Delta_Z - Delta_Zt; % [m]
Sb_Bar = Sb/Ad;

% Atmosperic conditions
Rho_SL = 1.225; % [kg/m^3]

% Normalized weight
Weight = Weight*9.81; % [N]
Cw = Weight/(Rho_SL*(Vt^2)*Ad);

Ct = Cw;
Ch = Sigma*Cd0*Mu/4;
Cy = Sigma*Cd0*w_bar/4;

Lambda_i = sqrt((-(Mu^2+w_bar^2)+sqrt((Mu^2+w_bar^2)^2+(ki*Ct)^2))/(2*ki^2));
Cq = Sigma*Cd0*(1+3*(Mu^2+w_bar^2))/8 + Cw*Lambda_i + 0.5*Sb_Bar*Mu^3 + 0.5*Sd_Bar*w_bar^3;

Beta_1c = (Ct*Delta_X/R + Ch*Delta_Z/R)/(Ct*Delta_Z/R + K_beta_Bar); % [rad]
Tao = Beta_1c - (0.5*Sb_Bar*Mu^2 + Ch)/Cw; % [rad]

% Cremer for Beta_1s and Ct_t
Base_Matrix = [Cw*Delta_X/R (L_t-Delta_X)/R; Cw*Delta_Z/R+K_beta_Bar -(Delta_Z-ht)/R];
Beta_1s = det([Cw*Delta_Y/R*Beta_1c+Cq, (L_t-Delta_X)/R; Cw*Delta_Y/R-Cy*Delta_Z/R, -(Delta_Z-ht)/R])/det(Base_Matrix); % [rad]
Ct_t = det([Cw*Delta_X/R Cw*Delta_Y/R*Beta_1c+Cq; Cw*Delta_Z/R+K_beta_Bar Cw*Delta_Y/R-Cy*Delta_Z/R])/det(Base_Matrix);

Phi = Beta_1s - (Ct_t -Cy - sign(w_bar)*0.5*Sd_Bar*w_bar^2)/Cw; % [rad]

% Cremer for flapping angles
Base_Matrix = [2/3, Mu, w_bar; 8*(w_bar-Mu*L/16)/3, 0, 1; -8*(Mu+w_bar*L/16)/3, -1, 0];
RHS_Matrix = [4*Ct/(Sigma*a)+Lambda_i; Beta_1s+2*(w_bar-Mu*L/9)*Lambda_i; Beta_1c-2*(Mu+w_bar*L/9)*Lambda_i];
Cremer_Matirx_theta_75 = Base_Matrix;
Cremer_Matirx_theta_75(:, 1) = RHS_Matrix;
Theta_75 = det(Cremer_Matirx_theta_75)/det(Base_Matrix); % [rad]
Cremer_Matirx_theta_1s = Base_Matrix;
Cremer_Matirx_theta_1s(:, 2) = RHS_Matrix;
Theta_1s = det(Cremer_Matirx_theta_1s)/det(Base_Matrix); % [rad]
Cremer_Matirx_theta_1c = Base_Matrix;
Cremer_Matirx_theta_1c(:, 3) = RHS_Matrix;
Theta_1c = det(Cremer_Matirx_theta_1c)/det(Base_Matrix); % [rad]

Lambda_ht = sqrt(Ct_t/2);
if w_bar<0 % Crabbing to the left
    if abs(w_bar) < Lambda_ht
        Lambda_dt = w_bar/2 + sqrt((w_bar/2)^2 + Lambda_ht^2);
    elseif abs(w_bar) > 2*Lambda_ht
        Lambda_dt = w_bar;
    else
        fprintf('Undefined range for Lambda_dt')
    end

    Ct_t_tag = Ct_t*(Vt*R/(Vt_t*Rt))^2;
    Lambda_dt_tag = Lambda_dt*Vt/Vt_t;

    Theta_75_t = 3*(2*Ct_t_tag/(Sigma_t*at) + 0.5*Lambda_dt_tag); % [rad]

else % Crabbing to the right
    Ct_t_tag = Ct_t*(Vt*R/(Vt_t*Rt))^2;
    w_bar_tag = w_bar*Vt/Vt_t;
    Mu_tag = Mu*Vt/Vt_t;
    Lambda_it_tag = sqrt((-Mu_tag^2 + sqrt(Mu_tag^4 + (ki_t*Ct_t_tag)^2))/(2*ki_t^2)) - (w_bar_tag-Mu_tag*(Beta_1s-Phi))*(-Mu_tag^2 + sqrt(Mu_tag^4 + (ki_t*Ct_t_tag)^2))/(2*sqrt(Mu_tag^4 + (ki_t*Ct_t_tag)^2));
    Theta_75_t = 3*(2*Ct_t_tag/(Sigma_t*at) + 0.5*(Lambda_it_tag+w_bar_tag)); % [rad]
end

Beta_1s = rad2deg(Beta_1s); % [deg]
Beta_1c = rad2deg(Beta_1c); % [deg]
Phi = rad2deg(Phi); % [deg]
Tao = rad2deg(Tao); % [deg]
Theta_1s = rad2deg(Theta_1s); % [deg]
Theta_1c = rad2deg(Theta_1c); % [deg]
Theta_75 = rad2deg(Theta_75); % [deg]
Theta_75_t = rad2deg(Theta_75_t); % [deg]

end

