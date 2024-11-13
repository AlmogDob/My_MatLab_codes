function [T] = T_as_a_function_of_t(t)
global m_0_dot t_b u_e A_e P_a A_e_0

P_e = P_e_as_a_function_of_t(t);

if A_e_0
    T = m_0_dot*u_e;
elseif t <= t_b
    T = m_0_dot*u_e + A_e.*(P_e-P_a);
else
    T = 0;
end

end