clc;
clear;
close;


% Question 3.1:
p = [1 4 5 2]; %defining the polynomial
r = roots(p) %finding the roots of polynomial 'p'


% Qustion 3.3:
t = [0:0.01:15];
AS = 3/2-3/2.*exp(-2.*t)-3.*t.*exp(-t); %analytical solution
sys = tf([3],[1 4 5 2]); %creats the transfer function
fig1 = figure('name', 'HW4'); % sets a figure
step(sys,15); %ploting the system response to a step function input
set(findall (gcf,'type', 'line'), 'linewidth', 3); %changing the graph's look
hold on
plot(t,AS, '--', 'color', 'green', 'linewidth', 2); %plots on the same graph the analytica solution
grid on
ylabel('y(t)');
legend("Numerical Solution", "Analytical Solution");
title("Analytical and Numerical Solution For the Step Response");
exportgraphics(fig1, 'HW4_gragh.pdf','ContentType','image'); %export the fig1 to a PDF in vector format

