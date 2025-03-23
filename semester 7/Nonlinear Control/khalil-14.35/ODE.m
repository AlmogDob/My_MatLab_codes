function d_state_dt = ODE(t, state)
    theta = 2;
    a = 1;

    r      = a * sin(t);
    r_dot  = a * cos(t);
    r_ddot = -a * sin(t);

    x1 = state(1,1);
    x2 = state(2,1);    
    x3 = state(3,1);

    k1 = 40;
    k2 = 10;

    eta = x3;
    xi1 = x1;
    xi2 = x2 + theta * xi1^2;

    v = -k1 * (xi1 - r) - k2 * (xi2 - r_dot);
    
    u  = -2 * theta * x1 * x2 - 2 * theta^2 * x1^3 - x3 + v - r_ddot;

    x1_dot = x2+theta*x1^2;
    x2_dot = x3 + u;
    x3_dot = x1 - x3;

    t

    d_state_dt = [x1_dot; x2_dot; x3_dot];
end