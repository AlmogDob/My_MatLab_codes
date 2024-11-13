clc;

% phases = -(atan2(16, -8.15+8) - atan2(16, -8.15+3) - atan2(16, -8.15+6) - atan2(16, -8.15+10) - atan2(16, -8.15))-pi;
% 
% a = 16/(tan(phases/2))+8.15;

%% Q1.3

p = (tf([1 8],1))/ (tf([1 3],1)*tf([1 6],1)*tf([1 10],1));
c = (16.28134)*tf([1 14.8758],1)^2/tf([1 0],1);

g = p*c;

sys = g/(1+g);

time = 0:0.01:2;
[y,t] = step(sys,time);
info = stepinfo(sys)

fig1 = figure ("Name","Plot Response of the Closed-Loop System with the PID Controller",'Position',[100 300 900 500]);
hold all
grid on
grid minor

plot(t, y, 'LineWidth',2,'Color',"#0072BD")

title ("Plot Response of the Closed-Loop System with the PID Controller");
subtitle("Almog Dobrescu 214254252");
% legend({''},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig1, '1.3grap1.png','Resolution',1200);

M_p = info.Overshoot/100;
ts_1p = info.SettlingTime;

zeta = (abs(log(M_p))) / sqrt(pi^2 + (abs(log(M_p))^2));
omega_n = (log(1/0.02)) / (zeta * ts_1p);

dominant_poles = [complex(-zeta*omega_n,omega_n * sqrt(1-zeta^2)),complex(-zeta*omega_n,-omega_n * sqrt(1-zeta^2))]

%%
fig2 = figure ("Name","R-L System with the PID Controller",'Position',[100 300 900 500]);
hold all
grid on
grid minor

rlocus(g);

title ("R-L System with the PID Controller | Almog Dobrescu 214254252");

% legend({''},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig2, '1.3grap2.png','Resolution',1200);

%%

