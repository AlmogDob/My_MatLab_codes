function d_state_dt = Satellite(x, F, G, K)

d_state_dt = (F-G*K)*x;

