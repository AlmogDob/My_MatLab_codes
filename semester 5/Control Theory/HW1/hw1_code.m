clc;
clear;

%% Q1.3.

zeta = 0.5;
omega_n = 2; % rad/sec
z_s = [0.5, 1, 2];
Hz0 = tf([omega_n^2/(z_s(0+1)) omega_n^2], [1 2*zeta*omega_n, omega_n^2]);
Hz1 = tf([omega_n^2/(z_s(1+1)) omega_n^2], [1 2*zeta*omega_n, omega_n^2]);
Hz2 = tf([omega_n^2/(z_s(2+1)) omega_n^2], [1 2*zeta*omega_n, omega_n^2]);
Hs = tf([omega_n^2], [1 2*zeta*omega_n, omega_n^2]);

[yz0, tz0] = step(Hz0);
[yz1, tz1] = step(Hz1);
[yz2, tz2] = step(Hz2);
[ys, ts] = step(Hs);

fig1 = figure ("Name","Step Response for Different Zeros",'Position',[100 350 900 500]);
hold all
plot (tz0, yz0 ,'LineWidth',2,'Color',[0 0.4470 0.7410])
plot (tz1, yz1 ,'LineWidth',2,'Color',[0.8500 0.3250 0.0980])
plot (tz2, yz2 ,'LineWidth',2,'Color',[0.9290 0.6940 0.1250])
plot (ts, ys ,'LineWidth',2,'Color',"#7E2F8E")

title ("Step Response for Different Zeros | Almog Dobrescu 214254252");
ylabel("y(t)")
xlabel("t [sec]")
grid on
grid minor
legend({'z = 0.5', 'z = 1', 'z = 2' 'no zeros'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig1, 'q1.3-grap1.png','Resolution',1200);

%% Q2.

H1_1 = tf([13], [1 1]);
H1_2 = tf([1], [1 4 13]);
H1 = H1_1 * H1_2;
[yh1, th1] = step(H1);

H2_1 = tf([13/1.1], [1 1]);
H2_2 = tf([1 1.1], [1 4 13]);
H2 = H2_1 *H2_2;
[yh2, th2] = step(H2);

H3 = tf([1], [1 1]);
[yh3, th3] = step(H3);

H4 = tf([13], [1 4 13]);
[yh4, th4] = step(H4);

H5_1 = -H2_1;
H5_2 = tf([1 -1.1], [1 4 13]);
H5 = H5_1 * H5_2;
[yh5, th5] = step(H5);

fig2 = figure ("Name","Step Response for Different Systems",'Position',[100 350 900 500]);
hold all
plot (th1, yh1 ,'LineWidth',2,'Color',[0 0.4470 0.7410])
plot (th2, yh2 ,'LineWidth',2,'Color',[0.8500 0.3250 0.0980])
plot (th3, yh3 ,'LineWidth',2,'Color',[0.9290 0.6940 0.1250])
plot (th4, yh4 ,'LineWidth',2,'Color',"#7E2F8E")
plot (th5, yh5 ,'LineWidth',2,'Color',"#4DBEEE")

title ("Step Response for Different Systems | Almog Dobrescu 214254252");
ylabel("y(t)")
xlabel("t [sec]")
grid on
grid minor
legend({'H1', 'H2', 'H3', 'H4', 'H5'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig2, 'q2-grap1.png','Resolution',1200);\

%%
info_h1 = stepinfo(H1, 'SettlingTimeThreshold',0.05,'RiseTimeLimits',[0.1 0.9]);
info_h2 = stepinfo(H2, 'SettlingTimeThreshold',0.05,'RiseTimeLimits',[0.1 0.9]);
info_h3 = stepinfo(H3, 'SettlingTimeThreshold',0.05,'RiseTimeLimits',[0.1 0.9]);
info_h4 = stepinfo(H4, 'SettlingTimeThreshold',0.05,'RiseTimeLimits',[0.1 0.9]);
info_h5 = stepinfo(H5, 'SettlingTimeThreshold',0.05,'RiseTimeLimits',[0.1 0.9]);

