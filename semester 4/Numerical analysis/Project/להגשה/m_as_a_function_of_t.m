function [m_at_t] = m_as_a_function_of_t(t)
global m_f m_0 m_0_dot t_b

if t <= t_b
    m_at_t = m_0 - m_0_dot*t;
else
    m_at_t = m_f;
end
end