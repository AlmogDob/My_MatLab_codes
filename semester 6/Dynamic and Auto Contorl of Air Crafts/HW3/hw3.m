%% Q1.b
clc;
clear;
format longE

X_u = -0.0066;
X_w = 0.03;
g = 9.81;
Z_u = -0.32;
Z_w = -0.65;
U0 = 75;
M_u = -5.3e-5;
M_w = -0.004;
M_q = -1.6;

A = [X_u X_w 0 -g;
     Z_u Z_w U0 0;
     M_u M_w M_q 0;
     0 0 1 0];
p = poly(A);
tf(p,1)
roots(p)

%% Q1.c
clc;
clear;
format longE

syms s

T = 8e5;
m = 3e5;
l_t = 10;
l_m = 50;
Iy = 3e7;
X_u = -0.0066;
X_w = 0.03;
g = 9.81;
Z_u = -0.32;
Z_w = -0.65;
U0 = 75;
M_u = -5.3e-5;
M_w = -0.004;
M_q = -1.6;
Z_epsilon = -T/m;
M_epsilon = -l_t/Iy*T;

A = [X_u X_w 0 -g;
     Z_u Z_w U0 0;
     M_u M_w M_q 0;
     0 0 1 0];
p = poly(A);

A_w_epsilon = [s-X_u 0 0 g;
               -Z_u Z_epsilon -U0 0;
               -M_u M_epsilon s-M_q 0;
               0 0 -1 s];
a_w_epsilon_poly = sym2poly(det(A_w_epsilon));
w_to_epsilon = tf(a_w_epsilon_poly,p)

A_q_epsilon = [s-X_u -X_w 0 g;
               -Z_u s-Z_w Z_epsilon 0;
               -M_u -M_w M_epsilon 0;
               0 0 0 s];
a_q_epsilon_poly = sym2poly(det(A_q_epsilon));
q_to_epsilon = tf(a_q_epsilon_poly,p)

alpha_m_to_epsilon = (1/U0)*w_to_epsilon - (l_m/U0)*q_to_epsilon;
alpha_m_to_epsilon = minreal(alpha_m_to_epsilon,1e-5)

alpha_to_epsilon = (1/U0)*w_to_epsilon;
alpha_to_epsilon = minreal(alpha_to_epsilon,1e-5)

zpk(alpha_to_epsilon)
zpk(alpha_m_to_epsilon)
%% 2.d
clc; clear;

syms X_u X_w V0 Z_w L_p L_r N_p N_r s

A = [s-X_u -X_w  0     -V0;
     0     s-Z_w V0    0;
     0     0     s-L_p -L_r;
     0     0     N_p   s-N_r];
det(A)
