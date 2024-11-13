function [P_e_at_t] = P_e_as_a_function_of_t(t)
%returning Pe at a specific time
global  P_e_over_P_0

P_0_of_t = @P_0_as_a_function_of_t;

P_e_at_t = P_e_over_P_0*P_0_of_t(t);

end