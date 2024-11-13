clc; 

K_gain1 = 13.41;
K_gain2 = 12.034;
p1 = 5.99;
p2 = -10.31;
p3 = -1.876;
z1 = -7.795;
z2 = 5.394;

G1 = tf([K_gain1 0],1) * (tf(1,[1 -p1]) * tf(1,[1 -p2]) * tf(1,[1 -p3]));
G2 = (K_gain2 * tf([1 -z1],1) * tf([1 -z2],1)) * (tf(1,[1 -p1]) * tf(1,[1 -p2]) * tf(1,[1 -p3]))*tf(1,[1 0]);

%% Q3.1.
K_gain1 = 13.41;
K_gain2 = 12.034;
p1 = 5.99;
p2 = -10.31;
p3 = -1.876;
z1 = -7.795;
z2 = 5.394;

G1 = tf([K_gain1 0],1) * (tf(1,[1 -p1]) * tf(1,[1 -p2]) * tf(1,[1 -p3]));

fig1 = figure ("Name","Q3.1 - Nyquist and Root-Locus of G1",'Position',[100 350 900 500]);

subplot(1,2,1)
grid on
grid minor
nyquist(G1)
title("Nyquist Diagram | "+"Almog Dobrescu 214254252")
legend({'G1(s)'},'FontSize',11 ,'Location','southeast')

subplot(1,2,2)
grid on
grid minor
rlocus(G1,-G1)
title("Root Locus | "+"Almog Dobrescu 214254252")
legend({'RL','ZARL'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig1, '3.1grap1.png','Resolution',1200);

%% Q3.2.

K_gain1 = 13.41;
K_gain2 = 12.034;
p1 = 5.99;
p2 = -10.31;
p3 = -1.876;
z1 = -7.795;
z2 = 5.394;

G1 = tf([K_gain1 0],1) * (tf(1,[1 -p1]) * tf(1,[1 -p2]) * tf(1,[1 -p3]));

a = 4;
Cp_PI_no_Kp = tf([1 a],[1 0]);

fig2 = figure ("Name","Q3.2 - Nyquist and Root-Locus of G1*Cp_PI",'Position',[250 350 900 500]);

subplot(1,2,1)
grid on
grid minor
nyquist(G1*Cp_PI_no_Kp)
title("Nyquist Diagram | "+"Almog Dobrescu 214254252")
legend({'G1*Cp_PI(s)'},'FontSize',11 ,'Location','southwest')

subplot(1,2,2)
grid on
grid minor
rlocus(G1*Cp_PI_no_Kp,-G1*Cp_PI_no_Kp)
title("Root Locus | "+"Almog Dobrescu 214254252")
legend({'RL','ZARL'},'FontSize',11 ,'Location','southwest')
%exportgraphics(fig2, '3.2grap1.png','Resolution',1200);

%% Q3.3.

K_gain1 = 13.41;
K_gain2 = 12.034;
p1 = 5.99;
p2 = -10.31;
p3 = -1.876;
z1 = -7.795;
z2 = 5.394;

G1 = tf([K_gain1 0],1) * (tf(1,[1 -p1]) * tf(1,[1 -p2]) * tf(1,[1 -p3]));

a = -p3;
Cp_PI_no_Kp = tf([1 a],[1 0]);
% rltool(G1*Cp_PI_no_Kp)
Kp = 5.5;
Cp_PI = Cp_PI_no_Kp*Kp;
Q33_H = G1*Cp_PI/(1+G1*Cp_PI);
Q33_H = minreal(Q33_H,1e-6);
minreal(G1*Cp_PI,1e-6);

t = 0:0.01:7;
[Q33y, Q33time] = step(Q33_H,t);

fig3 = figure ("Name","Q3.3 - Step Response of Transfer Function From ϕ_ref to ϕ",'Position',[400 350 900 500]);

plot(Q33time, Q33y,'LineWidth',2,'Color',"#0072BD")

grid on
grid minor
ylabel("ϕ(t) [rad]")
xlabel("t [sec]")
title("Q3.3 - Step Response of Transfer Function From ϕ_ref to ϕ")
subtitle("Almog Dobrescu 214254252")
legend({'ϕ/ϕ_ref'},'FontSize',11 ,'Location','southwest')
%exportgraphics(fig3, '3.3grap1.png','Resolution',1200);

fig4 = figure ("Name","Q3.3 - Nyquist of G1*Cp(s)",'Position',[550 350 900 500]);

nyquist(minreal(G1*Cp_PI,1e-6))

grid on
grid minor
title("Nyquist Diagram | Almog Dobrescu 214254252")
legend({'G1*Cp(s)'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig4, '3.3grap2.png','Resolution',1200);

Q33_H2 = Cp_PI/(1+G1*Cp_PI);
Q33_H2 = minreal(Q33_H2,1e-6);
zpk(Q33_H2);
pole(Q33_H2);

%% Q3.4.

K_gain1 = 13.41;
K_gain2 = 12.034;
p1 = 5.99;
p2 = -10.31;
p3 = -1.876;
z1 = -7.795;
z2 = 5.394;

G1 = tf([K_gain1 0],1) * (tf(1,[1 -p1]) * tf(1,[1 -p2]) * tf(1,[1 -p3]));

a = -p3;
Cp_PI_no_Kp = tf([1 a],[1 0]);
Kp = 5.5;
Cp_PI = Cp_PI_no_Kp*Kp;
Q34_H = G1*Cp_PI/(1+G1*Cp_PI);
Q34_H = minreal(Q34_H,1e-6);
pole(Q34_H);

%% Q3.5.

K_gain1 = 13.41;
K_gain2 = 12.034;
p1 = 5.99;
p2 = -10.31;
p3 = -1.876;
z1 = -7.795;
z2 = 5.394;

G1 = tf([K_gain1 0],1) * (tf(1,[1 -p1]) * tf(1,[1 -p2]) * tf(1,[1 -p3]));

a = -p3;
Cp_PI_no_Kp = tf([1 a],[1 0]);
Kp = 5.5;
Cp_PI = Cp_PI_no_Kp*Kp;
G3 = G1*Cp_PI/(1+G1*Cp_PI);
G3 = minreal(G3,1e-6);

fig5 = figure ("Name","Q3.5 - Bode of G3(s)",'Position',[700 350 900 500]);

bode(G3)

grid on
grid minor
title("Bode Diagram  | Almog Dobrescu 214254252")
legend({'G3'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig5, '3.5grap1.png','Resolution',1200);

tao_ld = 0.108959;
alpha_ld = 0.21058;
w = 20;
s = i*w;

syms k

eqn = k*abs((tao_ld*s+1)*(73.75)/((alpha_ld*tao_ld*s+1)*(s^2+4.32*s+12))) == 1;
k_ld = double(solve(eqn));

Cp_ld = k_ld*tf([tao_ld 1],[alpha_ld*tao_ld 1]);
Q35_H = Cp_ld*G3/(1+Cp_ld*G3);
Q35_H = minreal(Q35_H,1e-6);

fig6 = figure ("Name","Q3.5 - Bode of G3*Cp_ld(s)",'Position',[100 200 900 500]);

bode(Cp_ld*G3)

grid on
grid minor
title("Bode Diagram  | Almog Dobrescu 214254252")
legend({'G3*Cp_ld(s)'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig6, '3.5grap2.png','Resolution',1200);

t = 0:0.001:4;
[G3y, G3time] = step(G3,t);
[Q35_H_y, Q35_H_time] = step(Q35_H,t);

fig7 = figure ("Name","Q3.5 - Step Response of the System With and Without the Lead Compensation",'Position',[250 200 900 500]);
hold all

step(G3,Q35_H,t)

grid on
grid minor
title("Step Response of the System With and Without the Lead Compensation | Almog Dobrescu 214254252")
legend({'ϕ/ϕ_ref No Lead Compenstion', 'ϕ/ϕ_ref with Lead Compensation'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig7, '3.5grap3.png','Resolution',1200);

Q35finle_H = (Cp_PI*Cp_ld) / (1+Cp_PI*G1*(1+Cp_ld));
Q35finle_H = minreal(Q35finle_H,1e-6);
zpk(Q35finle_H);
pole(Q35finle_H);
pole(Q35_H);

%% Q4.1.

K_gain1 = 13.41;
K_gain2 = 12.034;
p1 = 5.99;
p2 = -10.31;
p3 = -1.876;
z1 = -7.795;
z2 = 5.394;

G1 = tf([K_gain1 0],1) * (tf(1,[1 -p1]) * tf(1,[1 -p2]) * tf(1,[1 -p3]));
G2 = (K_gain2 * tf([1 -z1],1) * tf([1 -z2],1)) * (tf(1,[1 -p1]) * tf(1,[1 -p2]) * tf(1,[1 -p3]))*tf(1,[1 0]);
a = -p3;
Cp_PI_no_Kp = tf([1 a],[1 0]);
Kp = 5.5;
Cp_PI = Cp_PI_no_Kp*Kp;

tao_ld = 0.108959;
alpha_ld = 0.21058;
w = 20;
s = i*w;
syms k
eqn = k*abs((tao_ld*s+1)*(73.75)/((alpha_ld*tao_ld*s+1)*(s^2+4.32*s+12))) == 1;
k_ld = double(solve(eqn));
Cp_ld = k_ld*tf([tao_ld 1],[alpha_ld*tao_ld 1]);

G4 = (Cp_PI*Cp_ld*G2) / (1+Cp_PI*G1*(1+Cp_ld));
G4 = minreal(G4,1e-6);
zpk(G4);

%% Q4.2.

K_gain1 = 13.41;
K_gain2 = 12.034;
p1 = 5.99;
p2 = -10.31;
p3 = -1.876;
z1 = -7.795;
z2 = 5.394;

G1 = tf([K_gain1 0],1) * (tf(1,[1 -p1]) * tf(1,[1 -p2]) * tf(1,[1 -p3]));
G2 = (K_gain2 * tf([1 -z1],1) * tf([1 -z2],1)) * (tf(1,[1 -p1]) * tf(1,[1 -p2]) * tf(1,[1 -p3]))*tf(1,[1 0]);
a = -p3;
Cp_PI_no_Kp = tf([1 a],[1 0]);
Kp = 5.5;
Cp_PI = Cp_PI_no_Kp*Kp;

tao_ld = 0.108959;
alpha_ld = 0.21058;
w = 20;
s = i*w;
syms k
eqn = k*abs((tao_ld*s+1)*(73.75)/((alpha_ld*tao_ld*s+1)*(s^2+4.32*s+12))) == 1;
k_ld = double(solve(eqn));
Cp_ld = k_ld*tf([tao_ld 1],[alpha_ld*tao_ld 1]);

G4 = (Cp_PI*Cp_ld*G2) / (1+Cp_PI*G1*(1+Cp_ld));
G4 = minreal(G4,1e-6);

fig8 = figure ("Name","Q4.2 - Bode of G4(s)",'Position',[400 200 900 500]);

bode(G4)

grid on
grid minor
title("Bode Diagram  | Almog Dobrescu 214254252")
legend({'G4'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig8, '4.2grap1.png','Resolution',1200);

alpha_a_ld = 0.21744;
tao_a_ld = 0.536127;
w = 4*1.1;
s = i*w;

syms k

eqn = k*abs(((tao_a_ld*s+1) / ((alpha_a_ld*tao_a_ld*s+1))*((777.4*(s-5.934)*(s+7.795)*(s+9.178))/(s^2*(s+14.6)*(s^2+33.3*s+580.3))))) == 1;
k_a_ld = double(solve(eqn));

Ca_ld = -k_a_ld*tf([tao_a_ld 1],[alpha_a_ld*tao_a_ld 1]);

fig9 = figure ("Name","Q4.2 - Bode of G4*Ca_ld(s)",'Position',[550 200 900 500]);

bode(minreal(G4*Ca_ld,1e-6))

grid on
grid minor
title("Bode Diagram  | Almog Dobrescu 214254252")
legend({'G4*Ca_ld(s)'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig9, '4.2grap2.png','Resolution',1200);

Q42_H = G4*Ca_ld/(1+G4*Ca_ld);
Q42_H = minreal(Q42_H,1e-6);

fig10 = figure ("Name","Q4.2 - Bode of Θ/Θ_ref",'Position',[700 200 900 500]);

bode(Q42_H)

grid on
grid minor
title("Bode Diagram  | Almog Dobrescu 214254252")
legend({'Θ/Θ_ref'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig10, '4.2grap3.png','Resolution',1200);

%% Q4.4.

K_gain1 = 13.41;
K_gain2 = 12.034;
p1 = 5.99;
p2 = -10.31;
p3 = -1.876;
z1 = -7.795;
z2 = 5.394;

G1 = tf([K_gain1 0],1) * (tf(1,[1 -p1]) * tf(1,[1 -p2]) * tf(1,[1 -p3]));
G2 = (K_gain2 * tf([1 -z1],1) * tf([1 -z2],1)) * (tf(1,[1 -p1]) * tf(1,[1 -p2]) * tf(1,[1 -p3]))*tf(1,[1 0]);
a = -p3;
Cp_PI_no_Kp = tf([1 a],[1 0]);
Kp = 5.5;
Cp_PI = Cp_PI_no_Kp*Kp;

tao_ld = 0.108959;
alpha_ld = 0.21058;
w = 20;
s = i*w;
syms k
eqn = k*abs((tao_ld*s+1)*(73.75)/((alpha_ld*tao_ld*s+1)*(s^2+4.32*s+12))) == 1;
k_ld = double(solve(eqn));
Cp_ld = k_ld*tf([tao_ld 1],[alpha_ld*tao_ld 1]);

G4 = (Cp_PI*Cp_ld*G2) / (1+Cp_PI*G1*(1+Cp_ld));
G4 = minreal(G4,1e-6);

alpha_a_ld = 0.21744;
tao_a_ld = 0.536127;
w = 4*1.1;
s = i*w;

syms k

eqn = k*abs(((tao_a_ld*s+1) / ((alpha_a_ld*tao_a_ld*s+1))*((777.4*(s-5.934)*(s+7.795)*(s+9.178))/(s^2*(s+14.6)*(s^2+33.3*s+580.3))))) == 1;
k_a_ld = double(solve(eqn));

Ca_ld = -k_a_ld*tf([tao_a_ld 1],[alpha_a_ld*tao_a_ld 1]);

Q44_sim = sim("Q43_sim.slx");

fig11 = figure ("Name","Q4.4 - Plots of the Response of the System to Θ_r_e_f(t)",'Position',[100 50 900 500]);

subplot(1,2,1)
hold all

plot(Q44_sim.Theta.time, Q44_sim.Theta.signals.values,'LineWidth',1.5,'Color',"#0072BD")
plot(Q44_sim.Phi.time, Q44_sim.Phi.signals.values,'LineWidth',1.5,'Color',"#A2142F")
plot(Q44_sim.Phi_ref.time, Q44_sim.Phi_ref.signals.values,':','LineWidth',2,'Color',"#77AC30")

grid on
grid minor
ylabel("Amplitude [rad]")
xlabel("t [sec]")
title("Q4.4 - Plots of the Response of the System to Θ_r_e_f(t)")
subtitle("Almog Dobrescu 214254252")
legend({'Θ(t)', 'ϕ(t)', 'ϕ_r_e_f(t)'},'FontSize',11 ,'Location','northeast')

subplot(1,2,2)
hold all

plot(Q44_sim.u.time, Q44_sim.u.signals.values,'LineWidth',1.5,'Color',"#0072BD")

grid on
grid minor
ylabel("u(t) [rad]")
xlabel("t [sec]")
title("Q4.4 - Plot of the Response of u(t) to Θ_r_e_f(t)")
subtitle("Almog Dobrescu 214254252")
legend({'u(t)'},'FontSize',11 ,'Location','northeast')

%exportgraphics(fig11, '4.4grap1.png','Resolution',1200);