clc;

%define the constanse
K_amp = 10;
N_r = 4.5;
R_a = 2.21;
K_m = 0.0242;
K_b = 0.0242;
J = 1.15;
b = 1.15;
L_a = 0.00026;
K = 10;
Zeta = ((b*R_a+K_m*K_b*N_r*N_r)/(2*(J*R_a*K*K_amp*K_m*N_r)^0.5));
Omega_n = ((K*K_amp*K_m*N_r)/(J*R_a))^0.5;
C = 1;
Zeta_calc = 0.24259;
Omega_n_calc = 2.082524;
C_calc = 1;

%Q2.1.

%define the transfer function
G = tf(K*K_amp*K_m*N_r,[L_a*J b*L_a+R_a*J b*R_a+K_m*K_b*N_r*N_r K*K_amp*K_m*N_r]);
t = 0:0.01:14;
[yG,t_yG] = step(G,t);

%ploting the step response
fig1 = figure ("Name",'yG','Position',[200 200 900 500]);
plot(t_yG,yG,'LineWidth',3)
title (["Plot of step response of the servomechanism G(s)", "Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('\theta(t) [rad]')
set(gca,'XAxisLocation','origin')
set(gca,'YAxisLocation','origin')
grid on
grid minor
legend('G(s)','FontSize',14 ,'Location','southeast')
exportgraphics(fig1, 'Q2_1-graph.png','Resolution',1200); %export the fig to a png file
%%

%Q2.3.

%define the transfer function
G_bar = tf(C*Omega_n^2,[1 2*Zeta*Omega_n Omega_n^2]);
[yG_bar,t_yG_bar] = step(G_bar,t);

%ploting the step response for G_bar and G
fig2 = figure ("Name",'yG and yG_bar','Position',[500 200 900 500]);
hold all
plot(t_yG,yG,'LineWidth',3,'Color',[0.6350 0.0780 0.1840])
plot(t_yG_bar, yG_bar ,'--','LineWidth',3, 'Color',[0.3010 0.7450 0.9])
title (["Plot of step response of G(s) and G-bar(s)", "Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('\theta(t) [rad]')
set(gca,'XAxisLocation','origin')
set(gca,'YAxisLocation','origin')
grid on
grid minor
legend({'G(s)',"G-bar(s)"},'FontSize',14 ,'Location','southeast')
exportgraphics(fig2, 'Q2_3-graph.png','Resolution',1200); %export the fig to a png file
%%

%Q2.5.

%define the transfer function
G_bar_calc = tf(C*Omega_n_calc^2,[1 2*Zeta_calc*Omega_n_calc Omega_n_calc^2]);
[yG_bar_calc,t_yG_bar_calc] = step(G_bar_calc,t);

%ploting the step response for G_bar and G
fig3 = figure ("Name",'yG_bar and yG_bar_calculated','Position',[800 200 900 500]);
hold all
plot(t_yG_bar,yG_bar,'LineWidth',3,'Color',[0 0.4470 0.7410])
plot(t_yG_bar_calc, yG_bar_calc ,'--','LineWidth',3, 'Color',[0.9290 0.6940 0.1250])
title (["Plot of step response of G-bar(s) and G-bar-calc(s)", "Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('\theta(t) [rad]')
set(gca,'XAxisLocation','origin')
set(gca,'YAxisLocation','origin')
grid on
grid minor
legend({'G-bar(s)',"G-bar-calc(s)"},'FontSize',14 ,'Location','southeast')
exportgraphics(fig3, 'Q2_5-graph.png','Resolution',1200); %export the fig to a png file


