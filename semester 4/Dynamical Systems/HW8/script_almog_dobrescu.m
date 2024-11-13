%Almog Dobrescu
clc;

%Q1.2

%defining the constants
L_alpha = 10^5; % [N/rad]
L_delta = -10^3; % [N/rad]
M_delta = 5*10^3; % [N*M/rad]
m = 10^3; % [Kg]
K = 25*10^3; % [N/m]
I = 5*10^3; % [Kg*m^2]
c = 3*10^3; % [N*sec/m]
K_alpha = 4.8*10^5; % [N*m/rad]
C_alpha = 2*10^3; % [N*m*sec/rad]

%defining the sys
sys = tf([I*L_delta C_alpha*L_delta L_delta*K_alpha+L_alpha*M_delta], [m*I m*C_alpha+c*I m*K_alpha+c*C_alpha+K*I c*K_alpha+K*C_alpha K*K_alpha]);

%ploting the bode plots
fig = figure ("Name",'Bode plots of the  TF ','Position',[200 50 1200 820]);
bode(sys)
title("Bode Plots of The  TF | Almog Dobrescu - 214254252");
grid on 
%exportgraphics(fig, 'Q1_2-graph.png','Resolution',1200); %export the fig to a png file

%%

%Q1.2.1

%ploting the bode plots near zero to find the steady state gain
fig1 = figure ("Name",'Bode plots of the  TF near zero to find the steady state gain','Position',[200 50 1200 820]);
bode(sys,{10^-10,10^0})
title("Bode Plots of The  TF Near Zero to Find The Steady State Gain | Almog Dobrescu - 214254252");
grid on 
%exportgraphics(fig1, 'Q1_2_1-graph.png','Resolution',1200); %export the fig to a png file

%%

%Q1.2.2

%ploting the bode plots at high frequencies to find the slop of the magnitude
fig2 = figure ("Name",'Bode plots of the  TF at high frequencies to find the slop of the magnitude','Position',[200 50 1200 820]);
bode(sys,{10^0,10^5})
title("Bode Plots of The  TF at High Frequencies to Find The Slop of The Magnitude | Almog Dobrescu - 214254252");
grid on 
%exportgraphics(fig2, 'Q1_2_2-graph.png','Resolution',1200); %export the fig to a png file

%%

%Q1.2.3

%ploting the bode plots at very high frequencies to find the phase value
fig3 = figure ("Name",'Bode plots of the  TF at very high frequencies to find the phase value','Position',[200 50 1200 820]);
bode(sys,{10^10,10^25})
title("Bode Plots of The  TF at High Frequencies to Find The Phase Value | Almog Dobrescu - 214254252");
grid on 
%exportgraphics(fig3, 'Q1_2_3-graph.png','Resolution',1200); %export the fig to a png file

%%

%Q1.3

%ploting the bode plots
fig4 = figure ("Name",'Bode plots of the  TF ','Position',[200 50 1200 820]);
bode(sys)
title("Bode Plots of The  TF to Find Values at Omega 3 | Almog Dobrescu - 214254252");
grid on 
%exportgraphics(fig4, 'Q1_3-graph.png','Resolution',1200); %export the fig to a png file

%%

%Q1.4

%ploting the step respons
fig5 = figure ("Name",'plot of the step respons','Position',[200 50 1200 820]);
step(sys,0:0.001:50)
title("Plot of The Step Respons | Almog Dobrescu - 214254252");
grid on 
%exportgraphics(fig5, 'Q1_4-graph.png','Resolution',1200); %export the fig to a png file
