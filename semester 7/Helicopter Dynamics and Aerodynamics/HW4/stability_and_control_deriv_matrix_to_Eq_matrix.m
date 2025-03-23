function Eq_matrix = stability_and_control_deriv_matrix_to_Eq_matrix(stability_and_control_deriv_matrix, Ic)
    
    Helicopter_Parameters

    stability_and_control_deriv_matrix(4:6,:) = Ic*stability_and_control_deriv_matrix(4:6,:);
    d_CX_over_CW_d_vX = stability_and_control_deriv_matrix(1,1);
    d_CX_over_CW_d_vY = stability_and_control_deriv_matrix(2,1);
    d_CX_over_CW_d_vZ = stability_and_control_deriv_matrix(3,1);
    d_CX_over_CW_d_p  = stability_and_control_deriv_matrix(4,1);
    d_CX_over_CW_d_q  = stability_and_control_deriv_matrix(5,1);
    d_CX_over_CW_d_r  = stability_and_control_deriv_matrix(6,1);
    
    d_CY_over_CW_d_vX = stability_and_control_deriv_matrix(1,2);
    d_CY_over_CW_d_vY = stability_and_control_deriv_matrix(2,2);
    d_CY_over_CW_d_vZ = stability_and_control_deriv_matrix(3,2);
    d_CY_over_CW_d_p  = stability_and_control_deriv_matrix(4,2);
    d_CY_over_CW_d_q  = stability_and_control_deriv_matrix(5,2);
    d_CY_over_CW_d_r  = stability_and_control_deriv_matrix(6,2);
    
    d_CZ_over_CW_d_vX = stability_and_control_deriv_matrix(1,3);
    d_CZ_over_CW_d_vY = stability_and_control_deriv_matrix(2,3);
    d_CZ_over_CW_d_vZ = stability_and_control_deriv_matrix(3,3);
    d_CZ_over_CW_d_p  = stability_and_control_deriv_matrix(4,3);
    d_CZ_over_CW_d_q  = stability_and_control_deriv_matrix(5,3);
    d_CZ_over_CW_d_r  = stability_and_control_deriv_matrix(6,3);
    
    d_CL_over_CW_d_vX = stability_and_control_deriv_matrix(1,4);
    d_CL_over_CW_d_vY = stability_and_control_deriv_matrix(2,4);
    d_CL_over_CW_d_vZ = stability_and_control_deriv_matrix(3,4);
    d_CL_over_CW_d_p  = stability_and_control_deriv_matrix(4,4);
    d_CL_over_CW_d_q  = stability_and_control_deriv_matrix(5,4);
    d_CL_over_CW_d_r  = stability_and_control_deriv_matrix(6,4);
    
    d_CM_over_CW_d_vX = stability_and_control_deriv_matrix(1,5);
    d_CM_over_CW_d_vY = stability_and_control_deriv_matrix(2,5);
    d_CM_over_CW_d_vZ = stability_and_control_deriv_matrix(3,5);
    d_CM_over_CW_d_p  = stability_and_control_deriv_matrix(4,5);
    d_CM_over_CW_d_q  = stability_and_control_deriv_matrix(5,5);
    d_CM_over_CW_d_r  = stability_and_control_deriv_matrix(6,5);
    
    d_CN_over_CW_d_vX = stability_and_control_deriv_matrix(1,6);
    d_CN_over_CW_d_vY = stability_and_control_deriv_matrix(2,6);
    d_CN_over_CW_d_vZ = stability_and_control_deriv_matrix(3,6);
    d_CN_over_CW_d_p  = stability_and_control_deriv_matrix(4,6);
    d_CN_over_CW_d_q  = stability_and_control_deriv_matrix(5,6);
    d_CN_over_CW_d_r  = stability_and_control_deriv_matrix(6,6);

    Eq_matrix = [d_CX_over_CW_d_vX/F^2                    , d_CX_over_CW_d_vY/F^2                    , d_CX_over_CW_d_vZ/F^2                    , d_CX_over_CW_d_p*Vt/(F^2*Omega), d_CX_over_CW_d_q*Vt/(F^2*Omega), d_CX_over_CW_d_r*Vt/(F^2*Omega), 0     , -Vt/(F^2);
                 d_CY_over_CW_d_vX/F^2                    , d_CY_over_CW_d_vY/F^2                    , d_CY_over_CW_d_vZ/F^2                    , d_CY_over_CW_d_p*Vt/(F^2*Omega), d_CY_over_CW_d_q*Vt/(F^2*Omega), d_CY_over_CW_d_r*Vt/(F^2*Omega), Vt/F^2, 0        ;
                 d_CZ_over_CW_d_vX/F^2                    , d_CZ_over_CW_d_vY/F^2                    , d_CZ_over_CW_d_vZ/F^2                    , d_CZ_over_CW_d_p*Vt/(F^2*Omega), d_CZ_over_CW_d_q*Vt/(F^2*Omega), d_CZ_over_CW_d_r*Vt/(F^2*Omega), 0     , 0        ;
                 d_CL_over_CW_d_vX*Omega/(gx_bar^2*F^2*Vt), d_CL_over_CW_d_vY*Omega/(gx_bar^2*F^2*Vt), d_CL_over_CW_d_vZ*Omega/(gx_bar^2*F^2*Vt), d_CL_over_CW_d_p/(gx_bar^2*F^2), d_CL_over_CW_d_q/(gx_bar^2*F^2), d_CL_over_CW_d_r/(gx_bar^2*F^2), 0     , 0        ;
                 d_CM_over_CW_d_vX*Omega/(gy_bar^2*F^2*Vt), d_CM_over_CW_d_vY*Omega/(gy_bar^2*F^2*Vt), d_CM_over_CW_d_vZ*Omega/(gy_bar^2*F^2*Vt), d_CM_over_CW_d_p/(gy_bar^2*F^2), d_CM_over_CW_d_q/(gy_bar^2*F^2), d_CM_over_CW_d_r/(gy_bar^2*F^2), 0     , 0        ;
                 d_CN_over_CW_d_vX*Omega/(gz_bar^2*F^2*Vt), d_CN_over_CW_d_vY*Omega/(gz_bar^2*F^2*Vt), d_CN_over_CW_d_vZ*Omega/(gz_bar^2*F^2*Vt), d_CN_over_CW_d_p/(gz_bar^2*F^2), d_CN_over_CW_d_q/(gz_bar^2*F^2), d_CN_over_CW_d_r/(gz_bar^2*F^2), 0     , 0        ;
                 0                                        , 0                                        , 0                                        , 1                              , 0                              , 0                              , 0     , 0        ;
                 0                                        , 0                                        , 0                                        , 0                              , 1                              , 0                              , 0     , 0        ];
    

    Eq_matrix(1:6,:) = Eq_matrix(1:6,:).*Omega;

end