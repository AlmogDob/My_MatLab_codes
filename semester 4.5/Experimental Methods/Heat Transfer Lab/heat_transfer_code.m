clc;
format long

% variabels and constants
file = readtable("צלעות קירור.csv");
DI1 = file(9:end, "Li1");
DI2 = file(9:end, "Li2");
DI3 = file(9:end, "Li3");
T1 = 24.34.*(DI1.^0.3831)-331.8;
T2 = 24.34.*(DI2.^0.3831)-331.8;
T3 = 24.34.*(DI3.^0.3831)-331.8;

%experiment
y_pix = 3:(254-3)/252:254;
y_cm = (40/(254-3))*(y_pix-y_pix(1));
y_cm(1) = [];
y_m = y_cm*10^(-2);

t1 = table2array(T1);
t2 = table2array(T2);
t3 = table2array(T3);

t_env = 30;
t_b1 = t1(1);
t_b2 = t2(1);
t_b3 = t3(1);
w = 2.5*10^(-2); % [m]
t = 0.5*10^(-2); % [m]
k = 18; % [W/m*celsius]
h1 = 8; 
h2 = 8;
h3 = 8;
p = 2*w+w*t;
A_c = w*t;
m1 = ((h1*p)/(k*A_c))^0.5;
m2 = ((h2*p)/(k*A_c))^0.5;
m3 = ((h3*p)/(k*A_c))^0.5;
theta_b1 = t_b1 - t_env;
theta_b2 = t_b2 - t_env;
theta_b3 = t_b3 - t_env;
L1 = 0.1;
L2 = 0.2;
L3 = 0.4;
t_ana1 = theta_b1.*((cosh(m1*(L1-y_m))+((h1)/(m1*k))*sinh(m1*(L1*y_m)))/(cosh(m1*L1)+(h1/(m1*k))*sinh(m1*L1)))+t_env;
t_ana2 = theta_b2.*((cosh(m2*(L2-y_m))+((h2)/(m2*k))*sinh(m2*(L2*y_m)))/(cosh(m2*L2)+(h2/(m2*k))*sinh(m2*L2)))+t_env;
t_ana3 = theta_b3.*((cosh(m3*(L3-y_m))+((h3)/(m3*k))*sinh(m3*(L3*y_m)))/(cosh(m3*L3)+(h3/(m3*k))*sinh(m3*L3)))+t_env;

%correction of the results
for i=64:length(t1)
    t1(i) = NaN;
    t_ana1(i) = NaN;
end

for i=125:length(t2)
    t2(i) = NaN;
    t_ana2(i) = NaN;
end

for i=250:length(t3)
    t3(i) = NaN;
    t_ana3(i) = NaN;
end


%analytical


fig1 = figure ("Name","Temp' as a Function of Hight",'Position',[500 200 900 500]);
hold all
plot(y_m,t1,'--','LineWidth',1,'Color',[1, 0.27, 0.62])
plot(y_m,t_ana1,'LineWidth',1,'Color',[1, 0.27, 0.62])
plot(y_m,t2,'--','LineWidth',1, 'Color',[0.97, 0.55, 0.35])
plot(y_m,t_ana2,'LineWidth',1, 'Color',[0.97, 0.55, 0.35])
plot(y_m,t3,'--','LineWidth',1, 'Color',[0.4940 0.1840 0.5560])
plot(y_m,t_ana3,'LineWidth',1, 'Color',[0.4940 0.1840 0.5560])

title (["Plot of Temp' as a Function of Hight"])%, "Revital Frenkel 213554694 | Almog Dobrescu 214254252"])
xlabel('$ y [m] $','Interpreter','Latex','fontsize', 12)
ylabel('$ T [^{\circ}C] $','Interpreter','Latex','fontsize', 12)
grid on
grid minor
legend({'short fin experiment','short fin analytical',"mid fin experiment",'mid fin analytical', "long fin experiment",'long fin analytical'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig1, 'Q6_5-graph.png','Resolution',1200);

avg_t1 = sum(t1,"omitnan")/64
avg_t2 = sum(t2,"omitnan")/125
avg_t3 = sum(t3,"omitnan")/250


% plot(y_m,t1,y_m,t2,y_m,t3)
% plot(y_m,di1,y_m,di2,y_m,di3)
% % 
% % 
% % T1 = ((DI1-1105)./0.823).^(1/1.478);
% % T2 = ((DI2-1105)./0.823).^(1/1.478);
% % T3 = ((DI3-1105)./0.823).^(1/1.478);
% % 
% % t1 = table2array(T1);
% % t2 = table2array(T2);
% % t3 = table2array(T3);
% % 
% % for i=64:length(t1)
% %     t1(i) = NaN;
% %     t_ana1(i) = NaN;
% % end
% % 
% % for i=125:length(t2)
% %     t2(i) = NaN;
% %     t_ana2(i) = NaN;
% % end
% % 
% % for i=250:length(t3)
% %     t3(i) = NaN;
% %     t_ana3(i) = NaN;
% % end
% % 
% % fig2 = figure ("Name","Temp' as a Function of Hight",'Position',[500 200 900 500]);
% % hold all
% % plot(y_m,t1,'--','LineWidth',1,'Color',[1, 0.27, 0.62])
% % plot(y_m,t_ana1,'LineWidth',1,'Color',[1, 0.27, 0.62])
% % plot(y_m,t2,'--','LineWidth',1, 'Color',[0.97, 0.55, 0.35])
% % plot(y_m,t_ana2,'LineWidth',1, 'Color',[0.97, 0.55, 0.35])
% % plot(y_m,t3,'--','LineWidth',1, 'Color',[0.4940 0.1840 0.5560])
% % plot(y_m,t_ana3,'LineWidth',1, 'Color',[0.4940 0.1840 0.5560])
% % 
% % title (["Plot of Temp' as a Function of Hight"])%, "Revital Frenkel 213554694 | Almog Dobrescu 214254252"])
% % xlabel('$ y [m] $','Interpreter','Latex','fontsize', 12)
% % ylabel('$ T [^{\circ}C] $','Interpreter','Latex','fontsize', 12)
% % grid on
% % grid minor
% % legend({'short fin experiment','short fin analytical',"mid fin experiment",'mid fin analytical', "long fin experiment",'long fin analytical'},'FontSize',11 ,'Location','northeast')
% % %exportgraphics(fig2, 'Q6_5-graph2.png','Resolution',1200);
%%
% t_env = 30;
% t_b1 = t1(1);
% t_b2 = t2(1);
% t_b3 = t3(1);
% w = 2.5*10^(-2); % [m]
% t = 0.5*10^(-2); % [m]
% k = 18; % [W/m*celsius]
% h1 = 8; 
% h2 = 2;
% h3 = 1;
% p = 2*w+w*t;
% A_c = w*t;
% m1 = ((h1*p)/(k*A_c))^0.5;
% m2 = ((h2*p)/(k*A_c))^0.5;
% m3 = ((h3*p)/(k*A_c))^0.5;
% theta_b1 = t_b1 - t_env;
% theta_b2 = t_b2 - t_env;
% theta_b3 = t_b3 - t_env;
% L1 = 0.1;
% L2 = 0.8;
% L3 = 1.6;
% 
% x = 0:0.01:1.6
% 
% 
% t_ana2 = theta_b2.*((cosh(m2*(L2-x))+((h2)/(m2*k))*sinh(m2*(L2*x)))/(cosh(m2*L2)+(h2/(m2*k))*sinh(m2*L2)))+t_env;
% t_ana3 = theta_b3.*((cosh(m3*(L3-x))+((h3)/(m3*k))*sinh(m3*(L3*x)))/(cosh(m3*L3)+(h3/(m3*k))*sinh(m3*L3)))+t_env;
% 
% for i=82:length(t_ana2)
%     t_ana2(i) = NaN;
% end
% 
% plot(x,t_ana3,x,t_ana2)
%%
fig2 = figure ('Position',[500 200 900 500]);
file2I = readtable("הולכה.csv");
DII = table2array(file2I(11:178,"Li1"));
pixel = transpose((74:171/167:245) - 74);
y_cmI = pixel*(20.5/(245-74));
y_mI = y_cmI*10^(-2);
temp = 24.34.*(DII.^0.3831)-331.8;
plot(y_mI,temp)

% delta_m = ((1/x)^2+(((y-b)/(x^2))*0.5*10^(-3))^2)^0.5
temp1 = temp(2:39);
temp2 = temp(40:80);
temp3 = temp(81:149);
temp4 = temp(150:165);
temp5 = temp(165:167);

y1 = y_mI(2:39);
y2 = y_mI(40:80);
y3 = y_mI(81:149);
y4 = y_mI(150:165);
y5 = y_mI(165:167);

b1 = 281.8;
b2 = 376;
b3 = 116.9;
b4 = 350.5;
b5 = 1335;
delta_m1 = ((1./y1).^2.+(((temp1-b1)./(y1.^2)).*0.5*10^(-3)).^2).^0.5;
delta_m2 = ((1./y2).^2.+(((temp2-b2)./(y2.^2)).*0.5*10^(-3)).^2).^0.5;
delta_m3 = ((1./y3).^2.+(((temp3-b3)./(y3.^2)).*0.5*10^(-3)).^2).^0.5;
delta_m4 = ((1./y4).^2.+(((temp4-b4)./(y4.^2)).*0.5*10^(-3)).^2).^0.5;
delta_m5 = ((1./y5).^2.+(((temp5-b5)./(y5.^2)).*0.5*10^(-3)).^2).^0.5;

delta_m1_avg = sum(delta_m1)/length(delta_m1)
delta_m2_avg = sum(delta_m2)/length(delta_m2)
delta_m3_avg = sum(delta_m3)/length(delta_m3)
delta_m4_avg = sum(delta_m4)/length(delta_m4)
delta_m5_avg = sum(delta_m5)/length(delta_m5)
%%
% delta_k = ((k_steel*(1/m_mat)*delta_m_steel)^2+(k_steel*(m_steel/(m_mat^2))*delta_m_mat)^2)0.5
k_steel = 18;
m_steel = -437.2;
m_mat1 = -437.2;
m_mat2 = -2703;
m_mat3 = -61.2;
m_mat4 = -1386;
m_mat5 = -6285;

delta_m_steel = delta_m1_avg;
delta_m_mat1 = delta_m1_avg;
delta_m_mat2 = delta_m2_avg;
delta_m_mat3 = delta_m3_avg;
delta_m_mat4 = delta_m4_avg;
delta_m_mat5 = delta_m5_avg;

delta_k1 = ((k_steel*(1/m_mat1)*delta_m_steel)^2+(k_steel*(m_steel/(m_mat1^2))*delta_m_mat1)^2)^0.5
delta_k2 = ((k_steel*(1/m_mat2)*delta_m_steel)^2+(k_steel*(m_steel/(m_mat2^2))*delta_m_mat2)^2)^0.5
delta_k3 = ((k_steel*(1/m_mat3)*delta_m_steel)^2+(k_steel*(m_steel/(m_mat3^2))*delta_m_mat3)^2)^0.5
delta_k4 = ((k_steel*(1/m_mat4)*delta_m_steel)^2+(k_steel*(m_steel/(m_mat4^2))*delta_m_mat4)^2)^0.5
delta_k5 = ((k_steel*(1/m_mat5)*delta_m_steel)^2+(k_steel*(m_steel/(m_mat5^2))*delta_m_mat5)^2)^0.5

%%

syms T1(y,T_inf,h) T2(y,T_inf,h) T3(y,T_inf,h) T_inf T_base1 T_base2 T_base3 h p k A_c L y
% T(y,T_inf,h) = T_inf+(T_base-T_inf)*((cosh(sqrt((h*p)/(k*A_c ))*(L-y))+(sqrt((h*p)/(k*A_c ))*h/k)*sinh(sqrt((h*p)/(k*A_c ))*(L-y)))/(cosh(((h*p)/(k*A_c)*L))+(sqrt((h*p)/(k*A_c ))*h/k)*sinh(sqrt((h*p)/(k*A_c))*L)))
% T_wrt_T_inf = diff(T,T_inf)
% T_wrt_h = diff(T,h)
% delta_T = sqrt((T_wrt_T_inf*2.5)^2+T_wrt_h^2)

T_base1 = t1(1);
T_base2 = t2(1);
T_base3 = t3(1);
w = 2.5*10^(-2); % [m]
t = 0.5*10^(-2); % [m]
k = 18; % [W/m*celsius]
% h = 8;
p = 2*w+w*t;
A_c = w*t;
L1 = 0.1;
L2 = 0.2;
L3 = 0.4;



T1(y,T_inf,h) = T_inf+(T_base1-T_inf)*((cosh(sqrt((h*p)/(k*A_c ))*(L1-y))+(sqrt((h*p)/(k*A_c ))*h/k)*sinh(sqrt((h*p)/(k*A_c ))*(L1-y)))/(cosh(((h*p)/(k*A_c)*L1))+(sqrt((h*p)/(k*A_c ))*h/k)*sinh(sqrt((h*p)/(k*A_c))*L1)));
T2(y,T_inf,h) = T_inf+(T_base2-T_inf)*((cosh(sqrt((h*p)/(k*A_c ))*(L2-y))+(sqrt((h*p)/(k*A_c ))*h/k)*sinh(sqrt((h*p)/(k*A_c ))*(L2-y)))/(cosh(((h*p)/(k*A_c)*L2))+(sqrt((h*p)/(k*A_c ))*h/k)*sinh(sqrt((h*p)/(k*A_c))*L2)));
T3(y,T_inf,h) = T_inf+(T_base3-T_inf)*((cosh(sqrt((h*p)/(k*A_c ))*(L3-y))+(sqrt((h*p)/(k*A_c ))*h/k)*sinh(sqrt((h*p)/(k*A_c ))*(L3-y)))/(cosh(((h*p)/(k*A_c)*L3))+(sqrt((h*p)/(k*A_c ))*h/k)*sinh(sqrt((h*p)/(k*A_c))*L3)));

T_wrt_T_inf1 = diff(T1,T_inf);
T_wrt_T_inf2 = diff(T2,T_inf);
T_wrt_T_inf3 = diff(T3,T_inf);

T_wrt_h1 = diff(T1,h);
T_wrt_h2 = diff(T2,h);
T_wrt_h3 = diff(T3,h);

delta_T1 = sqrt((T_wrt_T_inf1*2.5)^2+T_wrt_h1^2);
delta_T2 = sqrt((T_wrt_T_inf2*2.5)^2+T_wrt_h2^2);
delta_T3 = sqrt((T_wrt_T_inf3*2.5)^2+T_wrt_h3^2);

delta_T1s = delta_T1(y_m,t_env,8);
delta_T2s = delta_T2(y_m,t_env,8);
delta_T3s = delta_T3(y_m,t_env,8);


fig3 = figure ("Name","Temp' as a Function of Hight",'Position',[500 200 900 500]);
hold all
plot(y_m,t1,'--','LineWidth',1,'Color',[1, 0.27, 0.62])
plot(y_m,t_ana1,'LineWidth',1,'Color',[1, 0.27, 0.62])
plot(y_m,t2,'--','LineWidth',1, 'Color',[0.97, 0.55, 0.35])
plot(y_m,t_ana2,'LineWidth',1, 'Color',[0.97, 0.55, 0.35])
plot(y_m,t3,'--','LineWidth',1, 'Color',[0.4940 0.1840 0.5560])
plot(y_m,t_ana3,'LineWidth',1, 'Color',[0.4940 0.1840 0.5560])

e1 = errorbar([y_m(20) y_m(40) y_m(60)],[t_ana1(20) t_ana1(40) t_ana1(60)],[delta_T1s(20) delta_T1s(40) delta_T1s(60)],'LineStyle','none');
e2 = errorbar([y_m(30) y_m(70) y_m(110)],[t_ana2(30) t_ana2(70) t_ana2(110)],[delta_T2s(30) delta_T2s(70) delta_T2s(110)],'LineStyle','none');
e3 = errorbar([y_m(50) y_m(120) y_m(190)],[t_ana3(50) t_ana3(120) t_ana3(190)],[delta_T3s(50) delta_T3s(120) delta_T3s(190)],'LineStyle','none');

e1.Color = [1, 0.27, 0.62];
e1.LineWidth = 1;
e2.Color = [0.97, 0.55, 0.35];
e2.LineWidth = 1;
e3.Color = [0.4940 0.1840 0.5560];
e3.LineWidth = 1;

title ("Plot of Temp' as a Function of Hight")%, "Revital Frenkel 213554694 | Almog Dobrescu 214254252"])
xlabel('$ y [m] $','Interpreter','Latex','fontsize', 12)
ylabel('$ T [^{\circ}C] $','Interpreter','Latex','fontsize', 12)
grid on
grid minor
legend({'short fin experiment','short fin analytical',"mid fin experiment",'mid fin analytical', "long fin experiment",'long fin analytical'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig3, 'Q6_5-graph_30_error.png','Resolution',1200);


