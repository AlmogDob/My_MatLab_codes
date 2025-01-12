clc; clear; close all;

fig1 = figure ("Name","Max Diameter as a Function of Surface Tension",'Position',[100 300 900 500]);

gamma = linspace(0, 10, 1000);
plot(gamma, (6.*gamma).^(1/3), "LineWidth", 2)

title("Max Diameter as a Function of Surface Tension", "FontSize", 18, "Interpreter","latex");
ylabel("$D_{max}$ [-]", "FontSize", 18, "Interpreter","latex")
xlabel("$\gamma$ [-]", "FontSize", 18, "Interpreter","latex")
subtitle("Almog Dobrescu 214254252", "FontSize", 14, "Interpreter","latex")
grid on
% legend({''},'FontSize',13 ,'Location','northeast',"Interpreter","latex")
% 
