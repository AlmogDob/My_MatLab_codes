clear; clc;

syms s

Xu = 5.09e-4;
Xw = 5.8e-3;
X_delta_e = 4.72;
Zu = -9.01e-2;
Zw = -0.53;
Z_w_dot = -2.4e-5;
Zq = -1.65;
Z_delta_e = -17.7;
Mu = 5.11e-4;
Mw = -3.9e-3;
M_w_dot = -3.24e-4;
Mq = -0.527;
M_delta_e = -4.5;
U0 = 634;
H = 25e3;

A = [Zw            U0;
     Mw+M_w_dot*Zw Mq+M_w_dot*U0];
delta_s_poly= poly(A);

w_over_delta_e_mat = [Z_delta_e                   -U0;
                      M_delta_e+M_w_dot*Z_delta_e s-Mq-M_w_dot*U0];
w_over_delta_e_poly = sym2poly(det(w_over_delta_e_mat));
w_over_delta_e = tf(w_over_delta_e_poly,delta_s_poly);
alpha_over_delta_e = 1/U0*w_over_delta_e;

q_over_delta_e_mat = [s-Zw           Z_delta_e;
                      -Mw-M_w_dot*Zw M_delta_e+M_w_dot*Z_delta_e];
q_over_delta_e_poly = sym2poly(det(q_over_delta_e_mat));
q_over_delta_e = tf(q_over_delta_e_poly, delta_s_poly);

w_over_wg_mat = [-Zw            -U0;
                 -Mw-M_w_dot*Zw s-Mq-M_w_dot*U0];
w_over_wg_poly = sym2poly(det(w_over_wg_mat));
w_over_wg = 1/U0*tf(w_over_wg_poly,delta_s_poly);

q_over_wg_mat = [s-Zw           -Zw;
                 -Mw-M_w_dot*Zw -Mw-M_w_dot*Zw];
q_over_wg_poly = sym2poly(det(q_over_wg_mat));
q_over_wg = tf(q_over_wg_poly,delta_s_poly);




rho2_over_rho1 = 1.4;
U02 = 860;
H2 = 15e3;

Zw2 = Zw*1.8991;
Z_delta_e2 = rho2_over_rho1*U02^2/U0^2*Z_delta_e;
Mw2 = rho2_over_rho1*U02/U0*Mw;
M_w_dot2 = rho2_over_rho1*M_w_dot;
Mq2 = rho2_over_rho1*U02/U0*Mq;
M_delta_e2 = rho2_over_rho1*U02^2/U0^2*M_delta_e;
Zq2 = rho2_over_rho1*U02/U0*Zq;

A2 = [Zw2             U02;
     Mw2+M_w_dot2*Zw2 Mq2+M_w_dot2*U02];
delta_s_poly2= poly(A2);

q_over_delta_e_mat2 = [s-Zw2            Z_delta_e2;
                      -Mw2-M_w_dot2*Zw2 M_delta_e2+M_w_dot2*Z_delta_e2];
q_over_delta_e_poly2 = sym2poly(det(q_over_delta_e_mat2));
q_over_delta_e2 = tf(q_over_delta_e_poly2, delta_s_poly2);

[z,p,k] = zpkdata(q_over_delta_e);
[z2,p2,k2] = zpkdata(q_over_delta_e2);

[wn, zeta] = damp(q_over_delta_e);
[wn2, zeta2] = damp(q_over_delta_e2);

%%
clc; clear;
Cpoly = [1, 2.1, -1.86, -3.93, .31];
roots(Cpoly);

syms s;
Yv = -.25;
N_beta_bar = -3;
Nr_bar = -.1;
Y_delta_r = 3.3;
N_delta_r_bar = -3;

A = [Yv         -1;
     N_beta_bar Nr_bar];
p = poly(A);
roots(p);

r_over_delta_r_mat = [s-Yv         Y_delta_r;
                      -N_beta_bar  N_delta_r_bar];
r_over_delta_r_poly = sym2poly(det(r_over_delta_r_mat));
r_over_delta_r = tf(r_over_delta_r_poly, p)
