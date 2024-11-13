%Almog Dobrescu and Ronnel Nawy
%Q4.3
clc;
clear;
format long

%defining the constants and variabels
ts = [0 1 2 3 4 5 6]*24*60*60; % [sec]
Vs = [12.0022 12.0109 12.0181 12.0265 12.0354 12.0441 12.067]; % [Km/s]
V_avg = sum(Vs)/length(Vs);
a0 = 11.999375; % [Km/s]
a1 = 1.149553571*10^(-7); % [Km/s^2]

%defining the function
syms x;
f = a1*x+a0;
f = matlabFunction(f);

%finding SS_tot and SS_res
SS_tot = 0;
for i = 1:length(ts)
    SS_tot = SS_tot + (Vs(i)-V_avg)^2;
end

SS_res = 0;
for i = 1:length(ts)
    SS_res = SS_res + (Vs(i)-f(ts(i)))^2;
end

solution = 1-(SS_res/SS_tot)
