function [P_0_at_t] = P_0_as_a_function_of_t(t)
global t_b P_a

if t <= t_b
    P_0_at_t = P_a + (10^(7))*(atan(t)-atan(t-t_b)-1.5);
else
    P_0_at_t = P_a;
end
end