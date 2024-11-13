%% Q1
clc; clear;
syms S;
Xu = -0.01688;
Xw = -0.0045;
Zu = -0.1642;
Zw = -0.573;
Z_delta_e = -38.71;
Mw = -0.01852;
Mq = -0.898;
M_delta_e = -15.35;
U0 = 475;

A = [Zw U0;
     Mw Mq];
delta_s = poly(A);

q_delta_e_mat = [S-Zw Z_delta_e;
                 -Mw  M_delta_e];
H_q_delta_e = tf(sym2poly(det(q_delta_e_mat)), delta_s);
[z,p,k] = zpkdata(H_q_delta_e);

s = tf('s');

H_servo = -10/(s+10);
% rltool(H_servo*H_q_delta_e)
Kq = 1.6319;

% H_q_q_com = zpk(minreal(H_servo*H_q_delta_e/(1+Kq*H_q_delta_e*H_servo),1e-6));
H_q_q_com = minreal(H_servo*H_q_delta_e/(1+Kq*H_q_delta_e*H_servo),1e-6);

% rltool(H_q_q_com/s)
K_theta = 0.48552;

% H_theta_theta_com = minreal(K_theta*H_q_q_com/s/(1+K_theta*H_q_q_com/s),1e-6)
H_theta_theta_com = zpk(minreal(K_theta*H_q_q_com/s/(1+K_theta*H_q_q_com/s),1e-6));

% [y,t] = step(H_theta_theta_com, 100);
% 
% fig1 = figure ("Name","Plot Response of the Closed-Loop System",'Position',[100 300 900 500]);
% hold all
% grid on
% grid minor
% 
% plot(t, y*1*pi/180, 'LineWidth',2,'Color',"#0072BD")
% 
% title ("Plot Response of the Closed-Loop System");
% subtitle("Almog Dobrescu 214254252");
% % legend({''},'FontSize',11 ,'Location','southeast')
% %exportgraphics(fig1, '1.3grap1.png','Resolution',1200);

%% Q2
clc; clear;

s = tf('s');

U0 = 225;
Zw = -2*2^0.5;

H_gama_theta = -Zw/(s-Zw);
H_h_gama = U0/s;

%%
clc; clear;

syms Zw U0 Kh
s = tf('s');

omega_n = sqrt(-Kh*U0*Zw);
zeta = -Zw/2/sqrt(-Kh*U0*Zw);

U0 = 225;
U1 = 112.5;
Zw = -2*2^0.5;
Zw1 = U1/U0*Zw;
Kh = 9/450/2^.5;
lamda = 35;

omega = 2*pi*U0*sin(1.3*pi/180)/lamda

H_h_c = -Kh*Zw*U0/(s*(s-Zw)-Kh*Zw*U0)

bode(H_h_c)

% U0 = U1
% Zw = Zw1
% 
% Kh = 9/450/2^.5;
% 
% omega_n = double(subs(omega_n))
% zeta = double(subs(zeta))