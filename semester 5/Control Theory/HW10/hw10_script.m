clc;

%% Q1.1.

p = tf(1,[0.1 1 0])*tf(1,[1 1]);

fig1 = figure ("Name","Q1.1 - Bode",'Position',[100 350 900 500]);

bode(p)

grid on
grid minor
title("Bode Diagram  | Almog Dobrescu 214254252")
% legend({'p_gal*C_ld'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig1, 'Q1.1graph1.png','Resolution',1200);

%% Q1.3.
format long
numerator = 16*tf([233.0874 1],1);
denumenator = tf([1 0],1)*tf([6057.92 1],1)*tf([0.01 1],1)*tf([1 1],1);
final = numerator - denumenator;
zero(final);
atan2(15.2672,1)*180/pi
atan2(77.95,1)*180/pi

w = 3.16;
s = i*w;

magnitude = 4*abs((15.2672*s+1)/(77.9482*s+1))

%% Q1.4.
p = tf(1,[0.1 1 0])*tf(1,[1 1]);
c_lg = 4*tf([15.2672 1],[77.9482 1])
fig2 = figure ("Name","Q1.4 - Bode",'Position',[250 350 900 500]);

bode(minreal(p*c_lg,1e-6))

grid on
grid minor
title("Bode Diagram  | Almog Dobrescu 214254252")
% legend({'p_gal*C_ld'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig2, 'Q1.4graph1.png','Resolution',1200);

G_with_c = minreal(c_lg*p/(1+c_lg*p),1e-6);
G_without_c = minreal(4*p/(1+4*p),1e-6);

time = 0:0.01:40;
ramp = 1*time;
y_ramp_with = lsim(G_with_c,ramp,time);
y_ramp_without = lsim(G_without_c,ramp,time);

[y_with, x_with] = step(G_with_c,time);
[y_without, x_without] = step(G_without_c,time);

fig3 = figure ("Name","Q1.4 - Response of System With and Without Lag Compenstaor",'Position',[400 350 900 500]);

subplot(1,2,1)

hold all
plot(x_with, y_with,'LineWidth',2,'Color',"#0072BD")
plot(x_without, y_without,'LineWidth',2,'Color',"#D95319")

grid on
grid minor
ylabel("Amplitude")
xlabel("t [sec]")
title("Q1.4 - Step Response of System With and Without Lag Compenstaor")
subtitle("Almog Dobrescu 214254252")
legend({'with','without'},'FontSize',11 ,'Location','southeast')

subplot(1,2,2)

hold all
plot(time, y_ramp_with,'LineWidth',2,'Color',"#0072BD")
plot(time, y_ramp_without,'LineWidth',2,'Color',"#D95319")

grid on
grid minor
ylabel("Amplitude")
xlabel("t [sec]")
title("Q1.4 - Ramp Response of System With and Without Lag Compenstaor")
subtitle("Almog Dobrescu 214254252")
legend({'with','without'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig3, '1.4grap2.png','Resolution',1200);



fig4 = figure ("Name","Q1.4 - Pole-Zero Map of System With and Without Lag Compenstaor",'Position',[550 350 900 500]);

hold all
pzmap(G_with_c,'b')
pzmap(G_without_c,'r')

grid on
grid minor
% ylabel("Im")
% xlabel("Re")
title("Q1.4 - Pole-Zero Map of System With and Without Lag Compenstaor | Almog Dobrescu 214254252")
% subtitle("Almog Dobrescu 214254252")
legend({'with','without'},'FontSize',11 ,'Location','southwest')
%exportgraphics(fig4, '1.4grap3.png','Resolution',1200);

bandwidth(G_without_c)
bandwidth(G_with_c)

%% Q2.

p = 20*tf(1,[1 5])*tf(1,[1 2]);
p_gal = minreal(25*tf(1,[1 0])*p,1e-6);

w_gco = 2.1;
s = j*w_gco;
[GM, PM] = margin(p_gal);
wanted_PM = 75;
curren_PM = 180 + atan2(imag(freqresp(p_gal,s)), real(freqresp(p_gal,s)))*180/pi;
delta_PM = 1.156157*(wanted_PM-curren_PM);
alpha_ld = double((1-sin(deg2rad(delta_PM)))/(1+sin(deg2rad(delta_PM))));

w_bar = 0.5*w_gco;

tao_ld = 1/(w_bar*sqrt(alpha_ld));

C_ld = tf([tao_ld 1],[tao_ld*alpha_ld 1])

alpha_lg = abs(freqresp(p_gal,s))*abs(freqresp(C_ld,s));

tao_lg = 10/w_bar;

C_lg = tf([tao_lg 1],[tao_lg*alpha_lg 1])

[new_GM, new_PM] = margin(minreal(C_ld*p_gal*C_lg,1e-6))

C = minreal(C_ld*C_lg*25*tf(1,[1 0]),1e-6);

fig5 = figure ("Name","Q2 - Bode",'Position',[700 350 900 500]);

bode(minreal(C_ld*p_gal*C_lg,1e-6))

grid on
grid minor
title("Bode Diagram  | Almog Dobrescu 214254252")
% legend({'p_gal*C_ld'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig5, 'Q2graph1.png','Resolution',1200);

time = 0:0.01:100;
ramp = 1*time;
y_ramp = lsim(minreal(C_ld*p_gal*C_lg/(1+C_ld*p_gal*C_lg),1e-6),ramp,time);
for i = 1:length(time)
    error_y(i) = y_ramp(i) - ramp(i);
    i;
end

fig6 = figure ("Name","Q2 - Error of Ramp Input",'Position',[100 200 900 500]);

hold all
plot(time, error_y,'LineWidth',2,'Color',"#0072BD")

grid on
grid minor
ylabel("Amplitude")
xlabel("t [sec]")
title("Q2 - Error of Ramp Input")
subtitle("Almog Dobrescu 214254252")
legend({'C_l_d*p_g_a_l*C_l_g'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig6, '2grap2.png','Resolution',1200);
