clc; clear; close all;

U0 = 1; % [m/sec]
a = 0.05; % [m]
rho = 998; % [kg/m^3]
sigma = 0.0728; % [N/m]
g = 9.81; % [m/sec^2]
z_max = 5; % [m]

We = rho * U0^2 * a / sigma;
Fr = U0^2 / g / a;

h = 1e-5; % [m]

zs_temp = 0:h:z_max;
for i = 1:length(zs_temp)
    zs(i,1) = zs_temp(i);
end
xs = zeros(length(zs), 1);
ys = zeros(length(zs), 1);

xs(1) = a;
ys(1) = 0;

for i = 1:length(zs)-1
    m1 = h * calc_g(zs(i), xs(i), ys(i));
    k1 = h * calc_f(zs(i), xs(i), ys(i), We, Fr, a);
    m2 = h * calc_g(zs(i) + 1/3*h, xs(i) + 1/3*m1, ys(i) + 1/3*k1);
    k2 = h * calc_f(zs(i) + 1/3*h, xs(i) + 1/3*m1, ys(i) + 1/3*k1, We, Fr, a);
    m3 = h * calc_g(zs(i) + 1/3*h, xs(i) + 1/6*(m1+m2), ys(i) + 1/6*(k1+k2));
    k3 = h * calc_f(zs(i) + 1/3*h, xs(i) + 1/6*(m1+m2), ys(i) + 1/6*(k1+k2), We, Fr, a);
    m4 = h * calc_g(zs(i) + 1/2*h, xs(i) + 1/8*(m1+3*m3), ys(i) + 1/8*(k1+3*k3));
    k4 = h * calc_f(zs(i) + 1/2*h, xs(i) + 1/8*(m1+3*m3), ys(i) + 1/8*(k1+3*k3), We, Fr, a);
    m5 = h * calc_g(zs(i) + h, xs(i) + 1/2*(m1-3*m3+4*m4), ys(i) + 1/2*(k1-3*k3+4*k4));
    k5 = h * calc_f(zs(i) + h, xs(i) + 1/2*(m1-3*m3+4*m4), ys(i) + 1/2*(k1-3*k3+4*k4), We, Fr, a);

    xs(i+1) = xs(i) + 1/6*(m1 + 4*m4 + m5);
    ys(i+1) = ys(i) + 1/6*(k1 + 4*k4 + k5);
end

R1s = xs;

%% Q4
fig1 = figure ("Name","Jet Shape",'Position',[100 300 900 500]);
colors = cool(4)*0.9;
hold all

plot(R1s, z_max-zs, -R1s, z_max-zs, "-", "LineWidth", 1.5, "Color", colors(1,:))

xlabel('R_1 [m]')
ylabel('z [m]')
grid on
grid minor
title("Jet Shape")
subtitle("Almog Dobrescu 214254252")
% legend({},'FontSize',11 ,'Location','northwest')
% exportgraphics(fig1, 'graph1.png','Resolution',300);

fig2 = figure ("Name","R1 as a Function of z",'Position',[250 300 900 500]);
colors = cool(4)*0.9;
hold all

plot(zs, R1s, "-", "LineWidth", 1.5, "Color", colors(1,:))

xlabel('z [m]')
ylabel('R_1 [m]')
grid on
grid minor
title("R1 as a Function of z")
subtitle("Almog Dobrescu 214254252")
% legend({},'FontSize',11 ,'Location','northwest')
% exportgraphics(fig2, 'graph2.png','Resolution',300);

%% Q5

R1s_when_R2_is_inf = zeros(length(zs), 1);
for i = 1:length(zs)
    radiuses = roots([1+2*zs(i)/Fr^2/a+2/We, -2*a/We, 0, 0, -a^4]);
    for index = 1:length(radiuses) 
        if (isreal(radiuses(index)) && 0<radiuses(index))
            R1s_when_R2_is_inf(i,1) = radiuses(index);
        end
    end
end

fig3 = figure ("Name","R1 numerical vs R1 when R2 is inf",'Position',[400 300 900 500]);
colors = cool(4)*0.9;
hold all

plot(zs, R1s, "-", "LineWidth", 3, "Color", colors(1,:))
plot(zs, R1s_when_R2_is_inf, "-", "LineWidth", 1.5, "Color", colors(4,:))

xlabel('z [m]')
ylabel('R_1 [m]')
grid on
grid minor
title("R1 numerical vs R1 when R2 is inf")
subtitle("Almog Dobrescu 214254252")
legend({'Numerical solution','Apprximate analytical solution'},'FontSize',11 ,'Location','northeast')
% exportgraphics(fig3, 'graph3.png','Resolution',300);

fig4 = figure ("Name","R1 numerical vs R1 when We is inf",'Position',[550 300 900 500]);
colors = cool(4)*0.9;
hold all

plot(zs, R1s, "-", "LineWidth", 3, "Color", colors(1,:))
plot(zs, a.*(1+2*zs./Fr^2./a).^(-1/4), "-", "LineWidth", 1.5, "Color", colors(4,:))

xlabel('z [m]')
ylabel('R_1 [m]')
grid on
grid minor
title("R1 numerical vs R1 when We is inf")
subtitle("Almog Dobrescu 214254252")
legend({'Numerical solution','Apprximate analytical solution'},'FontSize',11 ,'Location','northeast')
% exportgraphics(fig4, 'graph4.png','Resolution',300);

%% functions
function g = calc_g(z, x, y)
    g = y;
end

function f = calc_f(z, x, y, We, Fr, a)
    f = We*a^3/2/x^4 - We/2/a - We*z/Fr^2/a^2 - 1/a + 1/x;
end