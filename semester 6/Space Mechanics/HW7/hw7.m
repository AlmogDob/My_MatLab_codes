clear; clc;
syms v r e a f Y(f) mu
Y(f) = 1/e/v*(2*e+r/a*cos(f));
dy_dv = diff(Y(f), v)
dy_dr = diff(Y(f), r)

r = (a*(1-e^2))/(1+e*cos(f));
v = (2*mu*(1/r-0.5/a))^0.5;

dr_df = diff(r, f)
dv_df = diff(v, f)

dy_df = diff(subs(Y(f)),f)