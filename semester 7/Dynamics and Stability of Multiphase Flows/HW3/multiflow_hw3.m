clc; clear;

rm = 997; % [kg/m^3]
rp = 1.225; % [kg/m^3]
sigma = 72e-3; % [N/m]
g = 9.81; % [m/sec^2]

k = logspace(0, 5, 10000);

u_cr = (((rm - rp)*g./k+sigma*k)./(rp*rm)*(rp+rm)).^0.5;

colors = cool(2);

for i = 2:length(u_cr)
    if u_cr(i-1)<u_cr(i)
        break
    end
end
i = i-1;

fig1 = figure(1);

semilogx(k, u_cr, "LineWidth",1.5, "Color",colors(2,:))
hold all
semilogx(k(i), u_cr(i),"hexagram", "LineWidth",4, "Color",colors(1,:))
grid on 
grid minor
ylabel("$U\left[\frac{\mathrm{m}}{\mathrm{sec}}\right]$", FontSize=20,Interpreter="latex")
xlabel("$k\left[\frac{1}{\mathrm{m}}\right]$", FontSize=20,Interpreter="latex")
title("$U$ as a Function of Wave Number $\left(k\right)$", "FontSize",20, Interpreter="latex")
% exportgraphics(fig1, 'graph1.png','Resolution',300);