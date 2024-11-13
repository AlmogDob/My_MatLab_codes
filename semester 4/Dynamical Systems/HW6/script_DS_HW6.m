clc;

%Q3.2.

%ploting the experimental result
fig1 = figure ("Name",'Experimental Result','Position',[200 100 1200 700]);
plot(Data.Time, Data.y,'LineWidth',1.5)
title (["Plot of experimental result", "Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('y [-]')
set(gca,'XAxisLocation','origin')
set(gca,'YAxisLocation','origin')
grid on
grid minor
legend('Experimental Result','FontSize',14 ,'Location','southeast')

%Q3.3.

%defining the constants
K = 0.2;
Zeta = 0.06724;
Omega_n = 1.2943;

%define the transfer function
H = tf(5*K*Omega_n^2,[1 2*Zeta*Omega_n Omega_n^2]);
[y_calc,t_calc] = step(H,Data.Time);

%ploting the result for the calculated constants and the experiment
fig2 = figure ("Name",'Experimental And Calculated Result','Position',[500 100 1200 700]);
hold all
plot(Data.Time(1:50000), Data.y(1:50000),'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
plot(t_calc(1:50000), y_calc(1:50000),'--','LineWidth',2, 'Color',[0 0 1])
title (["Plot of experimental and calculated result", "Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('y [-]')
set(gca,'XAxisLocation','origin')
set(gca,'YAxisLocation','origin')
grid on
grid minor
legend({'Experimental Result', 'Calculated Result'}, 'FontSize',14 ,'Location','southeast')
exportgraphics(fig2, 'Q3_3-graph.png','Resolution',1200); %export the fig to a png file


