clc;

k_p = [0.025, 0.05, 1, 10];
h_s1 = tf(10*k_p(1),[2 1 10*k_p(1)]);
h_s2 = tf(10*k_p(2),[2 1 10*k_p(2)]);
h_s3 = tf(10*k_p(3),[2 1 10*k_p(3)]);
h_s4 = tf(10*k_p(4),[2 1 10*k_p(4)]);

t = 0:0.01:30;

[yh_s1, xh_s1] = step(h_s1,t);
[yh_s2, xh_s2] = step(h_s2,t);
[yh_s3, xh_s3] = step(h_s3,t);
[yh_s4, xh_s4] = step(h_s4,t);

info_h_s1 = stepinfo(h_s1);
info_h_s2 = stepinfo(h_s2);
info_h_s3 = stepinfo(h_s3);
info_h_s4 = stepinfo(h_s4);

fig1 = figure ("Name","Step Response of Y(s)/R(s) for Different kp",'Position',[100 350 900 500]);
hold all
grid on
grid minor

plot (xh_s1, yh_s1 ,'LineWidth',2,'Color',"#0072BD")
plot (xh_s2, yh_s2 ,'LineWidth',2,'Color',"#D95319")
plot (xh_s3, yh_s3 ,'LineWidth',2,'Color',"#EDB120")
plot (xh_s4, yh_s4 ,'-.','LineWidth',2,'Color',"#7E2F8E")

title ("Step Response of Y(s)/R(s) for Different kp");
subtitle("Almog Dobrescu 214254252")
ylabel("y(t)")
xlabel("t [sec]")
grid on
grid minor
legend({'kp = 0.025', 'kp = 0.05', 'kp = 1', 'kp = 10'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig1, '1.3grap1.png','Resolution',1200);

%%
bw1 = bandwidth(h_s1);
bw2 = bandwidth(h_s2);
bw3 = bandwidth(h_s3);
bw4 = bandwidth(h_s4);

fig2 = figure ("Name","Bode of Y(s)/R(s) for Different kp",'Position',[100 350 900 500]);

hold all;
bode(h_s1);
bode(h_s2);
bode(h_s3);
bode(h_s4);

legend({'kp = 0.025', 'kp = 0.05', 'kp = 1', 'kp = 10'},'FontSize',11 ,'Location','northeast')
grid on
grid minor
title("Bode of Y(s)/R(s) for Different kp | Almog Dobrescu 214254252")
%exportgraphics(fig2, '1.3grap2.png','Resolution',1200);

%%
clc;
format default

root_s = roots([0.02 2.01 1 5.2]);
disp(root_s);

%%

k_p = 0.52;
h_s = tf(10*k_p,[0.02 2.01 1 10*k_p]);
t = 0:0.01:30;

[yh_s, xh_s] = step(h_s,t);
info_h_s = stepinfo(h_s);

fig3 = figure ("Name","Step Response of Y(s)/R(s) for kp = 0.52",'Position',[100 350 900 500]);
hold all
grid on
grid minor

plot (xh_s, yh_s ,'LineWidth',2,'Color',"#7E2F8E")

title ("Step Response of Y(s)/R(s) for kp = 0.52");
subtitle("Almog Dobrescu 214254252")
ylabel("y(t)")
xlabel("t [sec]")
grid on
grid minor
legend({'Y(s)/R(s), kp = 0.52'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig3, '1.4grap1.png','Resolution',1200);
