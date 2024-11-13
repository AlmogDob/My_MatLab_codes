%% Q3.1.

clc;

temp = tf(1,[1 4 20]);

P1 = 20 * temp;
P2 = tf(1600, [1 80]) * temp;
P3 = tf([400 400*4], [1 80]) * temp;
P4 = tf([400 -400*4], [1 80]) * temp;

P_s = [P1, P2, P3, P4];

fig1 = figure ("Name","Root Locus of P_1",'Position',[100 350 900 500]);
hold all
grid on
grid minor
rlocus(P_s(1));
title ("Root Locus of P_1 | " + "Almog Dobrescu 214254252");
%exportgraphics(fig1, '3.1grap1.png','Resolution',1200);

fig2 = figure ("Name","Root Locus of P_2",'Position',[250 350 900 500]);
hold all
grid on
grid minor
rlocus(P_s(2));
title ("Root Locus of P_2 | " + "Almog Dobrescu 214254252");
%exportgraphics(fig2, '3.1grap2.png','Resolution',1200);

fig3 = figure ("Name","Root Locus of P_3",'Position',[400 350 900 500]);
hold all
grid on
grid minor
rlocus(P_s(3));
title ("Root Locus of P_3 | " + "Almog Dobrescu 214254252");
%exportgraphics(fig3, '3.1grap3.png','Resolution',1200);

fig4 = figure ("Name","Root Locus of P_4",'Position',[550 350 900 500]);
hold all
grid on
grid minor
rlocus(P_s(4));
title ("Root Locus of P_4 | " + "Almog Dobrescu 214254252");
%exportgraphics(fig4, '3.1grap4.png','Resolution',1200);

%% Q3.2.
k = 1;
t = 0:0.01:3.5;

PP1 = k*P_s(1) / (1+k*P_s(1));
PP2 = k*P_s(2) / (1+k*P_s(2));
PP3 = k*P_s(3) / (1+k*P_s(3));
PP4 = k*P_s(4) / (1+k*P_s(4));

PP_s = [PP1, PP2, PP3, PP4];

vectors = {{[],[]},{[],[]},{[],[]},{[],[]}};
for i = 1:4
    [vectors{1,i}{1,1}, vectors{1,i}{1,2}] = step(PP_s(i), t);
end

colors = {"#0072BD", "#D95319", "#7E2F8E"};

fig5 = figure ("Name","Plot Response for P_1, P_2, P_3, P_4 for k = 1",'Position',[100 100 900 700]);
tiledlayout(2,1);
nexttile
hold all
grid on
grid minor

for i = 1:3
    plot(transpose(vectors{1,i}{1,2}), transpose(vectors{1,i}{1,1}), 'LineWidth',1.5,'Color',colors{i})
end

title ("Plot Response for P_1, P_2, P_3 for k = 1 | " + "Almog Dobrescu 214254252");
legend({'P_1','P_2','P_3'},'FontSize',11 ,'Location','southeast')

nexttile
hold all
grid on
grid minor
plot(transpose(vectors{1,4}{1,2}), transpose(vectors{1,4}{1,1}), 'LineWidth',1.5,'Color',colors{1})
title ("Plot Response for P_4 for k = 1 | " + "Almog Dobrescu 214254252");
legend({'P_4'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig5, '3.2grap1.png','Resolution',1200);

%% Q3.3.
k = 0.5;
t = 0:0.01:5;

P4 = tf([400 -400*4], [1 80]) * temp;

P_s = [P1, P2, P3, P4];
PP4 = k*P_s(4) / (1+k*P_s(4));
[vectors{1,4}{1,1}, vectors{1,4}{1,2}] = step(PP4, t);

fig6 = figure ("Name","Plot Response for P_4 for k = 0.5",'Position',[250 300 900 500]);
hold all
grid on
grid minor
plot(transpose(vectors{1,4}{1,2}), transpose(vectors{1,4}{1,1}), 'LineWidth',1.5,'Color',colors{1})
title ("Plot Response for P_4 for k = 0.5 | " + "Almog Dobrescu 214254252");
legend({'P_4'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig6, '3.3grap1.png','Resolution',1200);
