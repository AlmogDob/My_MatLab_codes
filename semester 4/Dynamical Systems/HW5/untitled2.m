clc;

%Q1.1

%defining the systems for H1
H1 = (s+0.99) / (s+1) / (s+10);
[y1_numerical,t1] = step(H1,5);   
y1_analytical = 99/1000 + (1/900).*exp(-t1) - (901/9000).*exp(-10*t1);
y1_analytical_neglected = 99/1000 - (901/9000).*exp(-10*t1);
%ploting the solutions
fig1 = figure ("Name",'sys1','Position',[200 200 700 500]);
hold all
grid on
title ('Numerical, Analytical and Analytical-neglected solutions for H1')
plot(t1,y1_numerical, '-','LineWidth',3,'Color',CSPEC(1,:))
plot(t1,y1_analytical,'--','LineWidth',2,'Color',CSPEC(2,:))
plot(t1,y1_analytical_neglected,'--','LineWidth',2,'Color',CSPEC(5,:))
xlabel('t [s]')
ylabel('y(t) [-]')
legend('Numerical solution', 'Analytical solution', 'Analytical-neglected solution','Location','southeast')
exportgraphics(fig1, 'Q1_1-graph.png','Resolution',1000); %export the fig1 to a png file
%%
%Q1.2

%defining the systems for H2
H2 = (s^2+1.9*s+1.9) / (s+1) / (s^2+2*s+2);
[y2_numerical,t2] = step(H2,10);   
y2_analytical = 19/20 - exp(-t2) + ((2^0.5)/20).*exp(-t2).*sin(t2+atan(1));
y2_analytical_neglected = 19/20 - exp(-t2);
%ploting the solutions
fig2 = figure ("Name",'sys2','Position',[400 200 800 500]);
hold all
grid on
title ('Numerical, Analytical and Analytical-neglected solutions for H2')
plot(t2,y2_numerical, '-','LineWidth',3,'Color',CSPEC(1,:))
plot(t2,y2_analytical,'--','LineWidth',2,'Color',CSPEC(2,:))
plot(t2,y2_analytical_neglected,'--','LineWidth',2,'Color',CSPEC(5,:))
xlabel('t [s]')
ylabel('y(t) [-]')
legend('Numerical solution', 'Analytical solution', 'Analytical-neglected solution','Location','southeast')
exportgraphics(fig2, 'Q2_2-graph.png','Resolution',1000); %export the fig to a png file
%%
%Q1.3

%defining the systems for H3
H3 = (s-0.99) / (s-1) / (s+10);
[y3_numerical,t3] = step(H3,20);   
y3_analytical = 99/1000 + (1/1100)*exp(t3) -(1099/11000)*exp(-10*t3);
y3_analytical_neglected = 99/1000 -(1099/11000)*exp(-10*t3);
%ploting the solutions
fig3 = figure ("Name",'sys3','Position',[600 200 800 500]);
hold all
grid on
title ('Numerical, Analytical and Analytical-neglected solutions for H3')
plot(t3,y3_numerical, '-','LineWidth',3,'Color',CSPEC(1,:))
plot(t3,y3_analytical,'--','LineWidth',2,'Color',CSPEC(2,:))
plot(t3,y3_analytical_neglected,'--','LineWidth',2,'Color',CSPEC(5,:))
xlabel('t [s]')
ylabel('y(t) [-]')
legend('Numerical solution', 'Analytical solution', 'Analytical-neglected solution','Location','northwest')
exportgraphics(fig3, 'Q3_3-graph.png','Resolution',1000); %export the fig to a png file




