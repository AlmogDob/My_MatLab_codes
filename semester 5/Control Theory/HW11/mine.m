clc;
%% Q4.

P = tf(1,[10 1 0]);
C = tf([10 1],[1 1]);

Ts = [1 0.1];

fig1 = figure ("Name","Q4 - Bode - Forward",'Position',[100 350 900 500]);
hold all

bode(C)
for i = 1:length(Ts)
    C_forward = tf([10 Ts(i)-10],[1 Ts(i)-1],Ts(i));
    bode(C_forward)
end
set(findall(gcf, 'type', 'line'), 'linewidth', 1.5)

grid on
grid minor
title("Bode Diagram - Forward | Almog Dobrescu 214254252")
legend({'continuous','Ts = 1[sec]','Ts = 0.1[sec]'},'FontSize',11 ,'Location','northeast')
% exportgraphics(fig1, 'Q4graph1.png','Resolution',1200);

fig2 = figure ("Name","Q4 - Bode - Backward",'Position',[250 350 900 500]);
hold all

bode(C)
for i = 1:length(Ts)
    C_Backward = tf([10+Ts(i) -10],[1+Ts(i) -1],Ts(i));
    bode(C_Backward)
end
set(findall(gcf, 'type', 'line'), 'linewidth', 1.5)

grid on
grid minor
title("Bode Diagram - Backward | Almog Dobrescu 214254252")
legend({'continuous','Ts = 1[sec]','Ts = 0.1[sec]'},'FontSize',11 ,'Location','northeast')
% exportgraphics(fig2, 'Q4graph2.png','Resolution',1200);

fig3 = figure ("Name","Q4 - Bode - Trapezoidal",'Position',[400 350 900 500]);
hold all

bode(C)
for i = 1:length(Ts)
    C_Trapezoidal = tf([20+Ts(i) Ts(i)-20],[2+Ts(i) Ts(i)-2],Ts(i));
    bode(C_Trapezoidal)
end
set(findall(gcf, 'type', 'line'), 'linewidth', 1.5)

grid on
grid minor
title("Bode Diagram - Trapezoidal | Almog Dobrescu 214254252")
legend({'continuous','Ts = 1[sec]','Ts = 0.1[sec]'},'FontSize',11 ,'Location','northeast')
% exportgraphics(fig3, 'Q4graph3.png','Resolution',1200);

fig4 = figure ("Name","Q4 - Bode of All Methodes Ts = 0.1[sec]",'Position',[550 350 900 500]);
hold all

bode(C)
for i = 2:length(Ts)
    C_forward = tf([10 Ts(i)-10],[1 Ts(i)-1],Ts(i));
    bode(C_forward,"b")
end
for i = 2:length(Ts)
    C_Backward = tf([10+Ts(i) -10],[1+Ts(i) -1],Ts(i));
    bode(C_Backward,"m")
end
for i = 2:length(Ts)
    C_Trapezoidal = tf([20+Ts(i) Ts(i)-20],[2+Ts(i) Ts(i)-2],Ts(i));
    bode(C_Trapezoidal,"--k")
end

set(findall(gcf, 'type', 'line'), 'linewidth', 1)

grid on
grid minor
title("Bode Diagram of All Methodes Ts = 0.1[sec] | Almog Dobrescu 214254252")
legend({'Continuous','Forward','Backward','Trapezoidal'},'FontSize',11 ,'Location','northeast')
% exportgraphics(fig4, 'Q4graph4.png','Resolution',1200);


fig5 = figure ("Name","Q4 - Bode of All Methodes Ts = 1[sec] ",'Position',[700 350 900 500]);
hold all

bode(C)
for i = 1:length(Ts)-1
    C_forward = tf([10 Ts(i)-10],[1 Ts(i)-1],Ts(i));
    bode(C_forward,"b")
end
for i = 1:length(Ts)-1
    C_Backward = tf([10+Ts(i) -10],[1+Ts(i) -1],Ts(i));
    bode(C_Backward,"m")
end
for i = 1:length(Ts)-1
    C_Trapezoidal = tf([20+Ts(i) Ts(i)-20],[2+Ts(i) Ts(i)-2],Ts(i));
    bode(C_Trapezoidal,"--k")
end

set(findall(gcf, 'type', 'line'), 'linewidth', 1)

grid on
grid minor
title("Bode Diagram of All Methodes Ts = 1[sec] | Almog Dobrescu 214254252")
legend({'Continuous','Forward','Backward','Trapezoidal'},'FontSize',11 ,'Location','northeast')
% exportgraphics(fig5, 'Q4graph5.png','Resolution',1200);

%% Q5.

P = tf(1,[10 1 0]);
C = tf([10 1],[1 1]);

Ts = [1 0.1];

fig6 = figure ("Name","Q5 - Step Responses - Forward ",'Position',[100 200 900 500]);
subplot(2,2,1)
hold all

step(C*P/(1+C*P));

for i = 1:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_forward = tf([10 Ts(i)-10],[1 Ts(i)-1],Ts(i));
    step(C_forward*Pd/(1+C_forward*Pd))
end

set(findall(gcf, 'type', 'line'), 'linewidth', 1.5)

grid on
grid minor
title("Step Response of Output - Forward | Almog Dobrescu 214254252")
legend({'Continuous','Ts = 1[sec]','Ts = 0.1[sec]'},'FontSize',11 ,'Location','northeast')

subplot(2,2,2)
hold all

step(C/(1+C*P));

for i = 1:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_forward = tf([10 Ts(i)-10],[1 Ts(i)-1],Ts(i));
    step(C_forward/(1+C_forward*Pd))
end

set(findall(gcf, 'type', 'line'), 'linewidth', 1.5)

grid on
grid minor
title("Step Response of Control Signal - Forward | Almog Dobrescu 214254252")
legend({'Continuous','Ts = 1[sec]','Ts = 0.1[sec]'},'FontSize',11 ,'Location','northeast')

subplot(2,2,[3,4]);
hold all
bode(feedback(C*P,1))
for i = 1:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_forward = tf([10 Ts(i)-10],[1 Ts(i)-1],Ts(i));
    bode(feedback(C_forward*Pd,1))
end
set(findall(gcf, 'type', 'line'), 'linewidth', 1)

grid on
grid minor
title("Bode Diagram - Forward | Almog Dobrescu 214254252")
legend({'continuous','Ts = 1[sec]','Ts = 0.1[sec]'},'FontSize',11 ,'Location','northeast')
% exportgraphics(fig6, 'Q5graph1.png','Resolution',1200);

fig7 = figure ("Name","Q5 - Step Responses - Backward ",'Position',[250 200 900 500]);
subplot(2,2,1)
hold all

step(C*P/(1+C*P));

for i = 1:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_Backward = tf([10+Ts(i) -10],[1+Ts(i) -1],Ts(i));
    step(feedback(C_Backward*Pd,1))
end

set(findall(gcf, 'type', 'line'), 'linewidth', 1.5)

grid on
grid minor
title("Step Response of Output - Backward | Almog Dobrescu 214254252")
legend({'Continuous','Ts = 1[sec]','Ts = 0.1[sec]'},'FontSize',11 ,'Location','northeast')

subplot(2,2,2)
hold all

step(C/(1+C*P));

for i = 1:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_Backward = tf([10+Ts(i) -10],[1+Ts(i) -1],Ts(i));
    step(C_Backward/(1+C_Backward*Pd))
end

set(findall(gcf, 'type', 'line'), 'linewidth', 1.5)

grid on
grid minor
title("Step Response of Control Signal - Backward | Almog Dobrescu 214254252")
legend({'Continuous','Ts = 1[sec]','Ts = 0.1[sec]'},'FontSize',11 ,'Location','northeast')

subplot(2,2,[3,4]);
hold all
bode(feedback(C*P,1))
for i = 1:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_Backward = tf([10+Ts(i) -10],[1+Ts(i) -1],Ts(i));
    bode(feedback(C_Backward*Pd,1))
end
set(findall(gcf, 'type', 'line'), 'linewidth', 1)

grid on
grid minor
title("Bode Diagram - Backward | Almog Dobrescu 214254252")
legend({'continuous','Ts = 1[sec]','Ts = 0.1[sec]'},'FontSize',11 ,'Location','northeast')
% exportgraphics(fig7, 'Q5graph2.png','Resolution',1200);

fig8 = figure ("Name","Q5 - Step Responses - Trapezoidal ",'Position',[400 200 900 500]);
subplot(2,2,1)
hold all

step(C*P/(1+C*P));

for i = 1:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_Trapezoidal = tf([20+Ts(i) Ts(i)-20],[2+Ts(i) Ts(i)-2],Ts(i));
    step(feedback(C_Trapezoidal*Pd,1))
end

set(findall(gcf, 'type', 'line'), 'linewidth', 1.5)

grid on
grid minor
title("Step Response of Output - Trapezoidal | Almog Dobrescu 214254252")
legend({'Continuous','Ts = 1[sec]','Ts = 0.1[sec]'},'FontSize',11 ,'Location','northeast')

subplot(2,2,2)
hold all

step(C/(1+C*P));

for i = 1:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_Trapezoidal = tf([20+Ts(i) Ts(i)-20],[2+Ts(i) Ts(i)-2],Ts(i));
    step(C_Trapezoidal/(1+C_Trapezoidal*Pd))
end

set(findall(gcf, 'type', 'line'), 'linewidth', 1.5)

grid on
grid minor
title("Step Response of Control Signal - Trapezoidal | Almog Dobrescu 214254252")
legend({'Continuous','Ts = 1[sec]','Ts = 0.1[sec]'},'FontSize',11 ,'Location','northeast')

subplot(2,2,[3,4]);
hold all
bode(feedback(C*P,1))
for i = 1:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_Trapezoidal = tf([20+Ts(i) Ts(i)-20],[2+Ts(i) Ts(i)-2],Ts(i));
    bode(feedback(C_Trapezoidal*Pd,1))
end
set(findall(gcf, 'type', 'line'), 'linewidth', 1)

grid on
grid minor
title("Bode Diagram - Trapezoidal | Almog Dobrescu 214254252")
legend({'continuous','Ts = 1[sec]','Ts = 0.1[sec]'},'FontSize',11 ,'Location','northeast')
% exportgraphics(fig8, 'Q5graph3.png','Resolution',1200);

fig9 = figure ("Name","Q5 - Step Responses of All Methodes Ts = 1[sec] ",'Position',[550 200 900 500]);
subplot(2,2,1)
hold all

step(C*P/(1+C*P));
for i = 1:length(Ts)-1
    Pd = c2d(P,Ts(i),'zoh');
    C_forward = tf([10 Ts(i)-10],[1 Ts(i)-1],Ts(i));
    step(C_forward*Pd/(1+C_forward*Pd))
end
for i = 1:length(Ts)-1
    Pd = c2d(P,Ts(i),'zoh');
    C_Backward = tf([10+Ts(i) -10],[1+Ts(i) -1],Ts(i));
    step(feedback(C_Backward*Pd,1))
end
for i = 1:length(Ts)-1
    Pd = c2d(P,Ts(i),'zoh');
    C_Trapezoidal = tf([20+Ts(i) Ts(i)-20],[2+Ts(i) Ts(i)-2],Ts(i));
    step(feedback(C_Trapezoidal*Pd,1))
end

set(findall(gcf, 'type', 'line'), 'linewidth', 1.5)

grid on
grid minor
title("Step Response of Output of All Methodes Ts = 1[sec] | Almog Dobrescu 214254252")
legend({'Continuous','Forward','Backward','Trapezoidal'},'FontSize',11 ,'Location','northeast')

subplot(2,2,2)
hold all

step(C/(1+C*P));
for i = 1:length(Ts)-1
    Pd = c2d(P,Ts(i),'zoh');
    C_forward = tf([10 Ts(i)-10],[1 Ts(i)-1],Ts(i));
    step(C_forward/(1+C_forward*Pd))
end
for i = 1:length(Ts)-1
    Pd = c2d(P,Ts(i),'zoh');
    C_Backward = tf([10+Ts(i) -10],[1+Ts(i) -1],Ts(i));
    step(C_Backward/(1+C_Backward*Pd))
end

for i = 1:length(Ts)-1
    Pd = c2d(P,Ts(i),'zoh');
    C_Trapezoidal = tf([20+Ts(i) Ts(i)-20],[2+Ts(i) Ts(i)-2],Ts(i));
    step(C_Trapezoidal/(1+C_Trapezoidal*Pd))
end

set(findall(gcf, 'type', 'line'), 'linewidth', 1.5)

grid on
grid minor
title("Step Response of Control Signal of All Methodes Ts = 1[sec] | Almog Dobrescu 214254252")
legend({'Continuous','Forward','Backward','Trapezoidal'},'FontSize',11 ,'Location','northeast')

subplot(2,2,[3,4]);
hold all
bode(feedback(C*P,1))
for i = 1:length(Ts)-1
    Pd = c2d(P,Ts(i),'zoh');
    C_forward = tf([10 Ts(i)-10],[1 Ts(i)-1],Ts(i));
    bode(feedback(C_forward*Pd,1))
end
for i = 1:length(Ts)-1
    Pd = c2d(P,Ts(i),'zoh');
    C_Backward = tf([10+Ts(i) -10],[1+Ts(i) -1],Ts(i));
    bode(feedback(C_Backward*Pd,1))
end

for i = 1:length(Ts)-1
    Pd = c2d(P,Ts(i),'zoh');
    C_Trapezoidal = tf([20+Ts(i) Ts(i)-20],[2+Ts(i) Ts(i)-2],Ts(i));
    bode(feedback(C_Trapezoidal*Pd,1))
end

set(findall(gcf, 'type', 'line'), 'linewidth', 1)

grid on
grid minor
title("Bode Diagram of All Methodes Ts = 1[sec] | Almog Dobrescu 214254252")
legend({'Continuous','Forward','Backward','Trapezoidal'},'FontSize',11 ,'Location','northeast')
% exportgraphics(fig9, 'Q5graph4.png','Resolution',1200);

fig10 = figure ("Name","Q5 - Step Responses of All Methodes Ts = 0.1[sec] ",'Position',[700 200 900 500]);
subplot(2,2,1)
hold all

step(C*P/(1+C*P));
for i = 2:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_forward = tf([10 Ts(i)-10],[1 Ts(i)-1],Ts(i));
    step(C_forward*Pd/(1+C_forward*Pd))
end
for i = 2:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_Backward = tf([10+Ts(i) -10],[1+Ts(i) -1],Ts(i));
    step(feedback(C_Backward*Pd,1))
end
for i = 2:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_Trapezoidal = tf([20+Ts(i) Ts(i)-20],[2+Ts(i) Ts(i)-2],Ts(i));
    step(feedback(C_Trapezoidal*Pd,1))
end

set(findall(gcf, 'type', 'line'), 'linewidth', 1.5)

grid on
grid minor
title("Step Response of Output of All Methodes Ts = 0.1[sec] | Almog Dobrescu 214254252")
legend({'Continuous','Forward','Backward','Trapezoidal'},'FontSize',11 ,'Location','southeast')

subplot(2,2,2)
hold all

step(C/(1+C*P));
for i = 2:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_forward = tf([10 Ts(i)-10],[1 Ts(i)-1],Ts(i));
    step(C_forward/(1+C_forward*Pd))
end
for i = 2:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_Backward = tf([10+Ts(i) -10],[1+Ts(i) -1],Ts(i));
    step(C_Backward/(1+C_Backward*Pd))
end

for i = 2:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_Trapezoidal = tf([20+Ts(i) Ts(i)-20],[2+Ts(i) Ts(i)-2],Ts(i));
    step(C_Trapezoidal/(1+C_Trapezoidal*Pd))
end

set(findall(gcf, 'type', 'line'), 'linewidth', 1.5)

grid on
grid minor
title("Step Response of Control Signal of All Methodes Ts = 0.1[sec] | Almog Dobrescu 214254252")
legend({'Continuous','Forward','Backward','Trapezoidal'},'FontSize',11 ,'Location','northeast')

subplot(2,2,[3,4]);
hold all
bode(feedback(C*P,1))
for i = 2:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_forward = tf([10 Ts(i)-10],[1 Ts(i)-1],Ts(i));
    bode(feedback(C_forward*Pd,1))
end
for i = 2:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_Backward = tf([10+Ts(i) -10],[1+Ts(i) -1],Ts(i));
    bode(feedback(C_Backward*Pd,1))
end

for i = 2:length(Ts)
    Pd = c2d(P,Ts(i),'zoh');
    C_Trapezoidal = tf([20+Ts(i) Ts(i)-20],[2+Ts(i) Ts(i)-2],Ts(i));
    bode(feedback(C_Trapezoidal*Pd,1))
end

set(findall(gcf, 'type', 'line'), 'linewidth', 1)

grid on
grid minor
title("Bode Diagram of All Methodes Ts = 0.1[sec] | Almog Dobrescu 214254252")
legend({'Continuous','Forward','Backward','Trapezoidal'},'FontSize',11 ,'Location','northeast')
% exportgraphics(fig10, 'Q5graph5.png','Resolution',1200);
