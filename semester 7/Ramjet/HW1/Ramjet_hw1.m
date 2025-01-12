%% Q2
clc; clear; close all;

% Ma = [1, 2, 3, 4];
Ma = linspace(1, 4, 100);
Pa = 12e3;
Pe = Pa;
P6 = Pe;
Ta = 220;
qR = 42e6;
T04 = 2200;
gamma_a_2 = 1.4;
gamma_3_6 = 1.3;
Cp_a_2 = 1000;
Cp_3_6 = 1200;
eta_b = 0.98;
eta_n = 0.95;
R_a_2 = Cp_a_2*(gamma_a_2 - 1)/gamma_a_2;
R_3_6 = Cp_3_6*(gamma_3_6 - 1)/gamma_3_6;

P0a = Pa*((1 + (gamma_a_2-1)/2 * Ma.^2).^(gamma_a_2/(gamma_a_2 - 1)));
P01 = P0a;
P02 = P01.*(1 - 0.1*(Ma-1).^(3/2));
P03 = P02*0.97;
P04 = P03*0.9;

T0a = Ta*(1 + (gamma_a_2 - 1)/2 * Ma.^2);
T01 = T0a;
% T02 = T01*(P02/P01)^((gamma_a_2-1)/gamma_a_2);
T02 = T01;
T03 = T02*(P03/P02)^((gamma_a_2 - 1)/gamma_a_2);

f = (Cp_a_2*T03 - Cp_3_6*T04)./(Cp_3_6*T04 - eta_b*qR); % [-]

Ua = Ma.*sqrt(gamma_a_2*R_a_2*Ta);

T6s = T04*(P6./P04).^((gamma_3_6 - 1)/gamma_3_6);
T6 = T04 - eta_n*(T04 - T6s);

P06 = P04;

Me = sqrt(2/(gamma_3_6-1)*((P06./Pa).^((gamma_3_6-1)/gamma_3_6)-1));
Ue = Me.*sqrt(gamma_3_6*R_3_6.*T6);

F = ((1+f).*Ue - Ua)/9.81;

TSFC = f./F.*60*60;

fig1 = figure ("Name","f as a function of Mach",'Position',[100 300 900 500]);

plot(Ma, f, "LineWidth", 2)

title("f as a function of Mach", "FontSize", 18, "Interpreter","latex");
ylabel("f [-]", "FontSize", 18, "Interpreter","latex")
xlabel("Mach [-]", "FontSize", 18, "Interpreter","latex")
subtitle("Almog Dobrescu 214254252", "FontSize", 14, "Interpreter","latex")
grid on
% legend({''},'FontSize',13 ,'Location','northeast',"Interpreter","latex")
% exportgraphics(fig1, 'grap1.png','Resolution',1200);

fig2 = figure ("Name","$\fraq{F}{\dot{m}}$ as a function of Mach",'Position',[300 300 900 500]);

plot(Ma, F, "LineWidth", 2)

title("$\frac{F}{\dot{m}}$ as a function of Mach", "FontSize", 18, "Interpreter","latex");
ylabel("$\frac{F}{\dot{m}}$ [$\frac{kgf}{kg/s}$]", "FontSize", 18, "Interpreter","latex")
xlabel("Mach [-]", "FontSize", 18, "Interpreter","latex")
subtitle("Almog Dobrescu 214254252", "FontSize", 14, "Interpreter","latex")
grid on
% legend({''},'FontSize',13 ,'Location','northeast',"Interpreter","latex")
% exportgraphics(fig2, 'grap2.png','Resolution',1200);

fig3 = figure ("Name","TSFC as a function of Mach",'Position',[500 300 900 500]);

plot(Ma, TSFC, "LineWidth", 2)

title("TSFC as a function of Mach", "FontSize", 18, "Interpreter","latex");
ylabel("TSFC [$\frac{kg}{hr\cdot kgf}$]", "FontSize", 18, "Interpreter","latex")
xlabel("Mach [-]", "FontSize", 18, "Interpreter","latex")
subtitle("Almog Dobrescu 214254252", "FontSize", 14, "Interpreter","latex")
grid on
% legend({''},'FontSize',13 ,'Location','northeast',"Interpreter","latex")
% exportgraphics(fig3, 'grap3.png','Resolution',1200);

%% Q3

Ma = linspace(0.54, 10, 10000);
Pa = 12e3;
Pe = Pa;
P6 = Pe;
Ta = 220;
qR = 42e6;
T04 = 2200;
gamma_a_2 = 1.4;
gamma_3_6 = 1.3;
Cp_a_2 = 1000;
Cp_3_6 = 1200;
eta_b = 0.98;
eta_n = 0.95;
R_a_2 = Cp_a_2*(gamma_a_2 - 1)/gamma_a_2;
R_3_6 = Cp_3_6*(gamma_3_6 - 1)/gamma_3_6;
rn = 0.96;
rc = 0.95;
rd = 0.9;

P0a = Pa*((1 + (gamma_a_2-1)/2 * Ma.^2).^(gamma_a_2/(gamma_a_2 - 1)));
P01 = P0a;
P02 = P01*rd;
P03 = P02;
P04 = P03*rc;

T0a = Ta*(1 + (gamma_a_2 - 1)/2 * Ma.^2);
T01 = T0a;
% T02 = T01*(P02/P01)^((gamma_a_2-1)/gamma_a_2);
T02 = T01;
T03 = T02*(P03/P02)^((gamma_a_2 - 1)/gamma_a_2);

f = (Cp_a_2*T03 - Cp_3_6*T04)./(Cp_3_6*T04 - eta_b*qR); % [-]

Ua = Ma.*sqrt(gamma_a_2*R_a_2*Ta);

T6s = T04*(P6./P04).^((gamma_3_6 - 1)/gamma_3_6);
T6 = T04 - eta_n*(T04 - T6s);

P06 = P04*rn;

Me = sqrt(2/(gamma_3_6-1)*((P06./Pa).^((gamma_3_6-1)/gamma_3_6)-1));
Ue = Me.*sqrt(gamma_3_6*R_3_6.*T6);

F = ((1).*Ue - Ua)/9.81;

fig4 = figure ("Name","F as a function of Mach",'Position',[700 300 900 500]);

plot(Ma, F, "LineWidth", 2)
hold on
plot(linspace(0, Ma(end), length(Ma)), zeros(length(Ma), 1), LineStyle="--", LineWidth=2)

title("$\frac{F}{\dot{m}}$ as a function of Mach", "FontSize", 18, "Interpreter","latex");
ylabel("$\frac{F}{\dot{m}}$ [$\frac{kgf}{kg/s}$]", "FontSize", 18, "Interpreter","latex")
xlabel("Mach [-]", "FontSize", 18, "Interpreter","latex")
subtitle("Almog Dobrescu 214254252", "FontSize", 14, "Interpreter","latex")
grid on
legend({'F', '0'},'FontSize',13 ,'Location','northeast',"Interpreter","latex")
% exportgraphics(fig4, 'grap4.png','Resolution',1200);

