function d_state_dt = Satellite(t, state)
x_vec = state(1:6, :);
xr_vec = state(7:12, :);

global_variabels

Gf      = -(F-Fr)*xr_vec - G*K*x_vec;
d_x_dt  = F*x_vec + (F-Fr)*xr_vec + Gf;
d_xr_dt = Fr*xr_vec;

d_state_dt = [d_x_dt; d_xr_dt];

