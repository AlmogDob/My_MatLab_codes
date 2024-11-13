%Almog Dobrescu
clc;

A = [-3 0 0 0 -16;
    1/3 -4/3 -1/3 -1/3 -2/3;
    16/3 -4/3 -7/3 5/3 -32/3;
    -2/3 2/3 2/3 -10/3 4/3;
    0 0 0 0 -5];

B = [1;2;-4;3;0];

C = [-4 2 -4 -3 7];

D = [0];

X0 = [1;-9;100;0;3];

%Q2.1

poly(A)

%Q2.2

eig(A)

%Q2.3

[z, p, k] = ss2zp(A,B,C,D)

%%

%Q2.5

sys = ss(A,B,C,D);
[u,t] = gensig("sine",5,100);
fig1 = figure("Name",'Response to the Sinusoidal Input u(t) = sin(t)','Position',[200 50 1200 820]);
lsim(sys,u,t,X0);
set(findall(gcf, 'type', 'line'), "linewidth", 3)
title (["Response to the Sinusoidal Input u(t) = sin(t)", "Almog Dobrescu - 214254252"])
grid on
grid minor
legend({'Response to u(t) = sin(t)'},'FontSize',14 ,'Location','southwest')
%exportgraphics(fig1, 'Q2_5-graph.png','Resolution',1200); %export the fig to a png file



