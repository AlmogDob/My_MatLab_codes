function d_state_dt = SolverQ2(t, state)

    global_variable
    d_state_dt = [state(2) ; 1 - 4*state(3)^2 / (1+state(1))^2 ; 1/(2*(3/2 + 1/(1+state(1)))) * (-state(3) + 2 * state(2) * state(3) / (1+state(1))^2 + Q2_controller(t, omega, state(1), state(2), state(3)))];

end
