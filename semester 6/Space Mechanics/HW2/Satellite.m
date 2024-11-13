function d_state_dt = Satellite(t, state)

planet

r_vector = state(1:3);
v_vector = state(4:6);
r = norm(r_vector);
r_dot_vector = v_vector;
v_dot_vector = -Mu*r_vector/r^3;
d_state_dt = [r_dot_vector;v_dot_vector];
