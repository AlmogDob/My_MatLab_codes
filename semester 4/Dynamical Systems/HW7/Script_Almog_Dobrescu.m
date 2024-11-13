%Almog Dobrescu
clc;
format long

%Q2.1.

%defining the system
sys = tf([1 3],[1 3 2]);

%ploting the bode diagram
fig1 = figure ("Name",'Bode of the TF','Position',[200 50 1200 820]);
bode(sys)
title("Bode graphs of the TF | Almog Dobrescu - 214254252");
grid on 
exportgraphics(fig1, 'Q2_1-graph.png','Resolution',1200); %export the fig to a png file

%%

%Q2.3.

%extracting the vectors of the plots form the bode function
[Magnitude_3d, Phase_3d, Omega] = bode(sys);

%they came out as a matrix so I will convert them to a vector
Magnitude_1d = zeros(1,length(Magnitude_3d));
Phase_1d_in_deg = zeros(1,length(Phase_3d));
for i = 1:length(Magnitude_3d)
    Magnitude_1d(i) = Magnitude_3d(1,1,i);
    Phase_1d_in_deg(i) = Phase_3d(1,1,i);
end

Magnitude_in_dB = zeros(1,length(Magnitude_3d));
for i = 1:length(Magnitude_3d)
    Magnitude_in_dB(i) = 20*log10(Magnitude_1d(i));
end

%defining the analytical phase and magnitude
Analytical_Magnitude_in_dB = 20*log10(((9+Omega.^2).^0.5)./((2-Omega.^2).^2+9*Omega.^2).^0.5);
Analytical_Phase_in_deg = -rad2deg(atan((Omega.^3+7*Omega)/(6)));
Omega_log = log10(Omega);

%ploting
fig2 = figure("Name",'Analytical and Numerical Bode Plots of the TF','Position',[200 50 1200 820]);
tiledlayout('flow')

nexttile
hold on
semilogx(Omega_log,Magnitude_in_dB,'LineWidth',3)
semilogx(Omega_log,Analytical_Magnitude_in_dB, 'LineStyle','--', 'Color','r','LineWidth',3)
title (["Plot of the Analytical and Numerical Magnitude as a Function of Omega", "Almog Dobrescu - 214254252"])
xlabel('log10(Omega) [rad/s]')
ylabel('Magnitude [dB]')
grid on
grid minor
legend({'Numerical Magnutide','Analytical Magnitude'},'FontSize',14 ,'Location','southwest')

nexttile
hold on
semilogx(Omega_log,Phase_1d_in_deg,'LineWidth',3)
semilogx(Omega_log,Analytical_Phase_in_deg, 'LineStyle','--', 'Color','r','LineWidth',3)
title (["Plot of the Analytical and Numerical Phase as a Function of Omega", "Almog Dobrescu - 214254252"])
xlabel('log10(Omega) [rad/s]')
ylabel('Phase [deg]')
grid on
grid minor
legend({'Numerical Phase','Analytical Phase'},'FontSize',14 ,'Location','southwest')

exportgraphics(fig2, 'Q2_3-graph.png','Resolution',1200); %export the fig to a png file

%%

%Q2.4.

%ploting the bode graphs for the TF to mark points of the graph
fig3 = figure ("Name",'Bode of the TF for marking points','Position',[200 50 1200 820]);
bode(sys)
title("Bode graphs of the TF | Almog Dobrescu - 214254252");
grid on 
% exportgraphics(fig3, 'Q2_4-graph.png','Resolution',1200); %export the fig to a png file
