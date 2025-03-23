clc; clear; close all;

init_conditions = readtable("init_conditions.txt");
x = init_conditions.Var1;
rho = init_conditions.Var2;
u = init_conditions.Var3;
p = init_conditions.Var4;

fig1 = figure ('Name', "1",'Position',[100 250 900 600]);
hold all
colors = cool(3)*0.9;

plot(x, rho, "LineWidth",1.5, "Color", colors(1,:));
plot(x, u, "LineWidth",1.5, "Color", colors(2,:));
plot(x, p, "LineWidth",1.5, "Color", colors(3,:));

title("Initial Conditions",'FontSize',30, "Interpreter","latex");
ylabel("ratio [-]",'FontSize',30, "Interpreter","latex")
xlabel("x [-]",'FontSize',30, "Interpreter","latex")
grid on
grid minor
legend({'Density ratio', 'Velocity ratio', 'Pressure ratio'},'FontSize',20 ,'Location','northeast',"Interpreter","latex")
% exportgraphics(fig1, 'images/Initial Conditions.png','Resolution',400);

