function matrix = calc_stability_and_control_deriv_hover(Q)

    Helicopter_Parameters;
    
    e_eff = 0.04;    
    if (4.1 == Q)
        e_eff = 0;
    elseif (4.2 == Q)
        e_eff = 2*e_eff;
    elseif (5 == Q)
        Delta_Zt = 0;
    end
    
    a = 2*pi;
    E_eff = 1.5*e_eff;
    K_beta_Bar = 3*Sigma*a*e_eff/(4*L);
    Sb_Bar = Sb/Ad;
    V12 = calc_Vnm(1,2);
    V11 = calc_Vnm(1,1);

    Delta_X_Bar = 0;
    Delta_Y_Bar = 0;
    ht = Delta_Z - Delta_Zt; % [m]
    ht_Bar = ht/R;
    Delta_Z_Bar = Delta_Z/R;
    l_t_Bar = l_t/R;
    
    Lambda_i = sqrt(Cw/(2*ki));
    Theta_075 = 6*Cw/(Sigma*a)+3/2*Lambda_i;
    C_Q = Sigma*Cd0/8 + Cw*Lambda_i;
    C_Tt = C_Q/l_t_Bar;
    A = 8/3*(Theta_075-3/4*Lambda_i);
    B = L/6*(Theta_075-4/3*Lambda_i);
    C = Sigma*Cd0/(4*Cw);
    Delta_X_t_Bar = l_t_Bar - Delta_X_Bar;
    Delta_Z_t_Bar = Delta_Z_Bar - ht_Bar;
    Kappa_Beta = 1+K_beta_Bar/(Cw*Delta_Z_Bar);
    Big_Lambda = (Lambda_i+8/(Sigma*a)*Cw)^(-1);
    Big_Theta = V12/Cw*1/(V11/sqrt(2*ki_t*C_Tt)+8/(Sigma_t*a));
    
    matrix = [-(A+C), B                            , 0          , Kappa_Beta*Delta_Z_Bar*B                              , (Kappa_Beta*A+C)*Delta_Z_Bar  , -(A+C)*Delta_Y_Bar+B*Delta_X_Bar                        ;
              -B    , -(A+C)-Big_Theta             , 0          , -(Kappa_Beta*A+C)*Delta_Z_Bar                         , Kappa_Beta*Delta_Z_Bar*B      , -B*Delta_Y_Bar-(A+C)*Delta_X_Bar+Big_Theta*Delta_X_t_Bar;
              0     , 0                            , -Big_Lambda, Big_Lambda*Delta_Y_Bar                                , Big_Lambda*Delta_X_Bar        , (3*Lambda_i*Big_Lambda-1)/2                             ;
              -1    , -16/L-Big_Theta*Delta_Z_t_Bar, 0          , -16/L*Kappa_Beta*Delta_Z_Bar-Delta_Z_t_Bar^2*Big_Theta, Kappa_Beta*Delta_Z_Bar        , -16/L*Delta_X_Bar+Big_Theta*Delta_Z_t_Bar*Delta_X_t_Bar ;
              16/L  , -1                           , 0          , -Kappa_Beta*Delta_Z_Bar                               , -16/L*Kappa_Beta*Delta_Z_Bar  , 16/L*Delta_Y_Bar-Delta_X_Bar                            ;
              0     , Big_Theta*Delta_X_t_Bar      , 2          , -2*Delta_Y_Bar+Big_Theta*Delta_X_t_Bar*Delta_Z_t_Bar  , -2*Delta_X_Bar                , -2*C_Q/Cw-Big_Theta*Delta_X_t_Bar^2                     ];

end

function Vnm = calc_Vnm(n, m)
    Helicopter_Parameters;
    Vnm = (Vt_t/Vt)^n * (Rt/R)^m;
end

