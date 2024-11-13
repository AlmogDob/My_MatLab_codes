%% Q1.3.
clc;
close all;

k_d = 9.95;
k_p = 9.95*21.0498;
t = 0:0.001:1;

theoretical_contoller = tf([k_d k_p],1);
p = tf(1,[1 2])*tf(1,[1 5]);
theoretical_h = tf(p*theoretical_contoller/(1+p*theoretical_contoller));
[theoretical_y, theoretical_x] = step(tf(p*theoretical_contoller/(1+p*theoretical_contoller)), t);

epsilon = [1/50, 1/500, 1/5000];
epsilon1_contoller = tf(k_p,1) + tf([k_d 0],[epsilon(1) 1]);
epsilon2_contoller = tf(k_p,1) + tf([k_d 0],[epsilon(2) 1]);
epsilon3_contoller = tf(k_p,1) + tf([k_d 0],[epsilon(3) 1]);

[epsilon1_y, epsilon1_x] = step(tf(p*epsilon1_contoller/(1+p*epsilon1_contoller)), t);
[epsilon2_y, epsilon2_x] = step(tf(p*epsilon2_contoller/(1+p*epsilon2_contoller)), t);
[epsilon3_y, epsilon3_x] = step(tf(p*epsilon3_contoller/(1+p*epsilon3_contoller)), t);

fig1 = figure ("Name","Plot Response of the Closed-Loop System ith the PD Controller",'Position',[100 300 900 500]);
hold all
grid on
grid minor

plot(theoretical_x, theoretical_y, '-', 'LineWidth',3.5,'Color',"#0072BD")
plot(epsilon1_x, epsilon1_y, '-', 'LineWidth',2,'Color',"#D95319")
plot(epsilon2_x, epsilon2_y, '-.', 'LineWidth',2,'Color',"#EDB120")
plot(epsilon3_x, epsilon3_y, ':', 'LineWidth',2,'Color',"#77AC30")

title ("Plot Response of the Closed-Loop System ith the PD Controller");
subtitle("Almog Dobrescu 214254252");
legend({'theoretical', sprintf("epsilon = %g", epsilon(1)), sprintf("epsilon = %g", epsilon(2)), sprintf("epsilon = %g", epsilon(3))},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig1, '1.3grap1.png','Resolution',1200);

%% Q1.4.
clc;


k_d = 9.95;
k_p = 9.95*21.0498;
t = 0:0.001:10;
epsilon = [1/50, 1/500, 1/5000];

p = tf(1,[1 2])*tf(1,[1 5]);

epsilon1_contoller = tf(k_p,1) + tf([k_d 0],[epsilon(1) 1]);
epsilon2_contoller = tf(k_p,1) + tf([k_d 0],[epsilon(2) 1]);
epsilon3_contoller = tf(k_p,1) + tf([k_d 0],[epsilon(3) 1]);

infor_e1 = stepinfo(tf(epsilon1_contoller/(1+p*epsilon1_contoller)));
infor_e2 = stepinfo(tf(epsilon2_contoller/(1+p*epsilon2_contoller)));
infor_e3 = stepinfo(tf(epsilon3_contoller/(1+p*epsilon3_contoller)));

