function d_state_dt = SolverQ1_1(t, state)

    x_Feedback = state(1:2, 1);
    x_Backstepping = state(3:4, 1);
    x_Lyapunov = state(5:6, 1);
    
    d_x_Feedback_dt = [x_Feedback(1) + x_Feedback(2) / (1 + x_Feedback(1)^2); -x_Feedback(2) + Q1_1_Feedback_controller(x_Feedback(1), x_Feedback(2))];
    d_x_Backstepping_dt = [x_Backstepping(1) + x_Backstepping(2) / (1 + x_Backstepping(1)^2); -x_Backstepping(2) + Q1_1_Backstepping_controller(x_Backstepping(1), x_Backstepping(2))];
    d_x_Lyapunov_dt = [x_Lyapunov(1) + x_Lyapunov(2) / (1 + x_Lyapunov(1)^2); -x_Lyapunov(2) + Q1_1_Lyapunov_controller(x_Lyapunov(1), x_Lyapunov(2))];
    
    d_state_dt = [d_x_Feedback_dt;d_x_Backstepping_dt;d_x_Lyapunov_dt];
end
