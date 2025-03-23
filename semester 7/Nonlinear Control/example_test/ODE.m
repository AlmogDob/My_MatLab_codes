function d_state_dt = ODE(t, state)
    x1 = state(1,1);
    x2 = state(2,1);    
    x3 = state(3,1);
    x4 = state(4,1);
    
    z1 = x2+x1;
    u1 = -3*x1^3 -(z1-x1)^2-2*x1^2*(z1-x1); 
    u2 = 2*x3 - 3;
    
    x1_dot = 0;
    x2_dot = 0;
    x3_dot = -x3 + 2*x4;
    x4_dot = x4 + u2;
    % x1_dot = x1^2*(x1 + 2*x2);
    % x2_dot = x2^2+u1;
    % x3_dot = 0;
    % x4_dot = 0;

    d_state_dt = [x1_dot; x2_dot; x3_dot; x4_dot];
end