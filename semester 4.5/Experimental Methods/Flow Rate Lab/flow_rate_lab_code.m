clc;
format long

%% Part 1
manometar_hieght = [0.5 0.78 1.12 1.39 1.74 2.03 2.29]; % [m]
pressure_gauge = [0.3 0.5 0.8 1.1 1.45 1.75 2]; % [V]
g = 9.81; % [m/s^2]
rho = 997; % [Kg/m^3]
delta_p = rho*g*manometar_hieght; % [pa]
delta_p_as_a_func_of_pressure_gauge_poly = [1.0040e+04,2.4314e+03];
delta_p_as_a_func_of_pressure_gauge = delta_p_as_a_func_of_pressure_gauge_poly(1)*pressure_gauge+delta_p_as_a_func_of_pressure_gauge_poly(2);

fig1 = figure ("Name","Delta P as a Function of Voltage",'Position',[100 350 900 500]);
hold all
plot (pressure_gauge,delta_p_as_a_func_of_pressure_gauge,'LineWidth',2,'Color',[0 0.4470 0.7410])

e1 = errorbar(pressure_gauge,delta_p,zeros(1,length(delta_p)), 'LineStyle','none');
e1.Color = [0 0 0];
e1.Marker = '.';
e1.MarkerSize = 15;

e1.XNegativeDelta = zeros(1,length(delta_p))+0.05;
e1.XPositiveDelta = zeros(1,length(delta_p))+0.05;
e1.YNegativeDelta = zeros(1,length(delta_p))+502;
e1.YPositiveDelta = zeros(1,length(delta_p))+502;

title ("Delta P as a Function of Voltage")
ylabel("Delta P [Pa]")
xlabel("Voltage [V]")
grid on
grid minor
legend({'y = 1.0040e+04*x + 2.4314e+03'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig1, 'P1-graph1.png','Resolution',1200);


%% Part 2 - 1
true_flow_rate = [56.71 174.8 359.1 482.0 595.4]*10^(-6); % [m^3/sec]
rotmeter_flow_rate = [83.33 200.0 366.7 500.0 633.3]*10^(-6); % [m^3/sec]
h_calib = [0.06 0.185 0.38 0.51 0.63]; % [m]
t = [30 30 30 30 30]; % [sec]

true_flow_rate_as_a_func_of_rotmeter_flow_rate_poly = [0.9902 -1.958e-05];
true_flow_rate_as_a_func_of_rotmeter_flow_rate = true_flow_rate_as_a_func_of_rotmeter_flow_rate_poly(1)*rotmeter_flow_rate+true_flow_rate_as_a_func_of_rotmeter_flow_rate_poly(2);

delta_FR_calib = (((1.418*10^(-4))./t).^2+(1.418*10^(-3).*h_calib./t.^2 ).^2 ).^0.5;
dleta_FR_real_from_rotmeter = 16.51*10^(-6); 
delta_FR_real = (delta_FR_calib.^2.+dleta_FR_real_from_rotmeter.^2).^0.5;

fig2 = figure ("Name","True Flow Rate as a Fuction of Rotmeter Flow Rate",'Position',[300 350 900 500]);
hold all
plot (rotmeter_flow_rate,true_flow_rate_as_a_func_of_rotmeter_flow_rate,'LineWidth',2,'Color',[0 0.4470 0.7410])

e1 = errorbar(rotmeter_flow_rate,true_flow_rate,zeros(1,length(rotmeter_flow_rate)), 'LineStyle','none');
e1.Color = [0 0 0];
e1.Marker = '.';
e1.MarkerSize = 15;

e1.XNegativeDelta = zeros(1,length(rotmeter_flow_rate))+16.67*10^(-6);
e1.XPositiveDelta = zeros(1,length(rotmeter_flow_rate))+16.67*10^(-6);
e1.YNegativeDelta = delta_FR_real;
e1.YPositiveDelta = delta_FR_real;

title ("True Flow Rate as a Fuction of Rotmeter Flow Rate")
ylabel("True Flow Rate [m^3/sec]")
xlabel("Rotmeter Flow Rate [m^3/sec]")
grid on
grid minor
legend({'y = 0.9902*x - 1.958e-05'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig2, 'P2-graph1.png','Resolution',1200);

error = 100*(rotmeter_flow_rate - true_flow_rate)./true_flow_rate;

%% Part 2 - 2
true_flow_rate = [56.71 174.8 359.1 482.0 595.4]*10^(-6); % [m^3/sec]
h_rotmeter = [5 37.5 72 94 115]*10^(-3); % [m]
h_calib = [0.06 0.185 0.38 0.51 0.63]; % [m]
t = [30 30 30 30 30]; % [sec]

true_flow_rate_as_a_func_of_h_rotmeter_poly = [4.977e-3 1.158e-5];
true_flow_rate_as_a_func_of_h_rotmeter = true_flow_rate_as_a_func_of_h_rotmeter_poly(1)*h_rotmeter+true_flow_rate_as_a_func_of_h_rotmeter_poly(2);

delta_FR_calib = (((1.418*10^(-4))./t).^2+(1.418*10^(-3).*h_calib./t.^2 ).^2 ).^0.5;
dleta_FR_real_from_h_rotmeter = 2.489*10^(-6); 
delta_FR_real = (delta_FR_calib.^2.+dleta_FR_real_from_h_rotmeter.^2).^0.5;

fig3 = figure ("Name","True Flow Rate as a Fuction of Rotmeter Hieght",'Position',[500 350 900 500]);
hold all
plot (h_rotmeter,true_flow_rate_as_a_func_of_h_rotmeter,'LineWidth',2,'Color',[0 0.4470 0.7410])

e1 = errorbar(h_rotmeter,true_flow_rate,zeros(1,length(h_rotmeter)), 'LineStyle','none');
e1.Color = [0 0 0];
e1.Marker = '.';
e1.MarkerSize = 5;

e1.XNegativeDelta = zeros(1,length(h_rotmeter))+0.5*10^(-3);
e1.XPositiveDelta = zeros(1,length(h_rotmeter))+0.5*10^(-3);
e1.YNegativeDelta = delta_FR_real;
e1.YPositiveDelta = delta_FR_real;

title ("True Flow Rate as a Fuction of Rotmeter Hieght")
ylabel("True Flow Rate [m^3/sec]")
xlabel("Rotmeter Hieght [m]")
grid on
grid minor
legend({'y = 4.977e-3*x + 1.158e-5'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig3, 'P2-graph2.png','Resolution',1200);

%% Part 2 - 3
true_flow_rate = [56.71 174.8 359.1 482.0 595.4]*10^(-6); % [m^3/sec]
frequency = [2.9 16.6 29.6 39.2 48.4]; % [Hz]
h_calib = [0.06 0.185 0.38 0.51 0.63]; % [m]
t = [30 30 30 30 30]; % [sec]

true_flow_rate_as_a_func_of_frequency_poly = [1.214e-5 1.733e-6];
true_flow_rate_as_a_func_of_frequency = true_flow_rate_as_a_func_of_frequency_poly(1)*frequency+true_flow_rate_as_a_func_of_frequency_poly(2);

delta_FR_calib = (((1.418*10^(-4))./t).^2+(1.418*10^(-3).*h_calib./t.^2 ).^2 ).^0.5;
dleta_FR_real_from_frequency = 0.607e-6;
delta_FR_real = (delta_FR_calib.^2.+dleta_FR_real_from_frequency.^2).^0.5;

fig4 = figure ("Name","True Flow Rate as a Fuction of Frequency",'Position',[700 350 900 500]);
hold all
plot (frequency,true_flow_rate_as_a_func_of_frequency,'LineWidth',2,'Color',[0 0.4470 0.7410])

e1 = errorbar(frequency,true_flow_rate,zeros(1,length(frequency)), 'LineStyle','none');
e1.Color = [0 0 0];
e1.Marker = '.';
e1.MarkerSize = 5;

e1.XNegativeDelta = zeros(1,length(frequency))+0.05;
e1.XPositiveDelta = zeros(1,length(frequency))+0.05;
e1.YNegativeDelta = delta_FR_real;
e1.YPositiveDelta = delta_FR_real;

title ("True Flow Rate as a Fuction of Frequency")
ylabel("True Flow Rate [m^3/sec]")
xlabel("Frequency [Hz]")
grid on
grid minor
legend({'y = 1.214e-5*x + 1.733e-6'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig4, 'P2-graph3.png','Resolution',1200);

%% Part 2 - 4 - 1 - 1
h_calib = [0.095 0.2 0.37 0.485 0.625]; % [m]
t = [30 30 30 30 30]; % [sec]
x = 58*10^(-3); % [m]
L = (58+263.5)*10^(-3); % [m]
d_calib = 0.19; % [m]
d_entrenc = 0.024; % [m]
d_exit = 0.024; % [m]
d_disturbance = 0.0115; % [m]
rho = 997; % [Kg/m^3]

A_entrenc = pi*(0.5*d_entrenc)^2;
A_exit = pi*(0.5*d_exit)^2;
A_disturbance = pi*(0.5*d_disturbance)^2;
FR_real = (pi*(0.5*d_calib)^2.*h_calib)./(t);
dp_E_D_V = [0.6 0.7 1.15 1.55 2.1];
dp_E_D_Pa = 1.004e4*dp_E_D_V+2.431e3;
FR_ideal = ((A_disturbance)./(1-(A_disturbance/A_entrenc).^2).^0.5)*((2*dp_E_D_Pa)/(rho)).^0.5;

FR_ideal_as_a_func_of_FR_real_poly = [0.6023 3.666e-4];
R_sqr_FR_ideal_as_a_func_of_FR_real = 0.9856;
FR_ideal_as_a_func_of_FR_real = FR_ideal_as_a_func_of_FR_real_poly(1)*FR_real+FR_ideal_as_a_func_of_FR_real_poly(2);

delta_FR_real = (((1.418*10^(-4))./t).^2+(1.418*10^(-3).*h_calib./t.^2 ).^2 ).^0.5;
delta_FR_ideal = ((A_disturbance)./(1-(A_disturbance/A_entrenc).^2).^0.5).*(502./(rho.*((2.*dp_E_D_Pa)./rho).^0.5));
%
v_entrenc_real = FR_real/A_entrenc;
v_disturbance = FR_real/A_disturbance;
v_avg_venturi = (v_entrenc_real+v_disturbance)/2;
Reinolds_venturi = (v_avg_venturi.*d_disturbance)./(0.801*10^(-6));
c = [0.94 0.96 0.967 0.97 0.971];
FR_fixed_c = c.*FR_ideal;

FR_fixed_c_as_a_func_of_FR_real_poly = [0.6094 3.434e-4];
R_FR_fixed_c_as_a_func_of_FR_real = 0.9910;
FR_fixed_c_as_a_func_of_FR_real = FR_fixed_c_as_a_func_of_FR_real_poly(1)*FR_real+FR_fixed_c_as_a_func_of_FR_real_poly(2);

delta_FR_fixed_c = c.*delta_FR_ideal;
%
dp_E_E_V = [0.55 0.6 0.6 0.7 0.75];
dp_E_E_Pa = 1.004e4*dp_E_E_V+2.431e3;
dp_loss_Pa = (x/L)*dp_E_E_Pa;
dp_E_D_fixed_Pa = dp_E_D_Pa - dp_loss_Pa;
FR_fixed_pressurefall = ((A_disturbance)./(1-(A_disturbance/A_entrenc).^2).^0.5)*((2*dp_E_D_fixed_Pa)/(rho)).^0.5;

FR_fixed_pressurefall_as_a_func_of_FR_real_poly = [0.6254 3.25e-4];
R_FR_fixed_pressurefall_as_a_func_of_FR_real = 0.9862;
FR_fixed_pressurefall_as_a_func_of_FR_real = FR_fixed_pressurefall_as_a_func_of_FR_real_poly(1)*FR_real+FR_fixed_pressurefall_as_a_func_of_FR_real_poly(2);

delta_dp_loss_Pa = (x/L)*502;
delta_dp_E_D_fixed_Pa = (delta_dp_loss_Pa^2+502^2)^0.5;
delta_FR_fixed_pressurefall = ((A_disturbance)./(1-(A_disturbance/A_entrenc).^2).^0.5).*(502./(rho.*((2.*delta_dp_E_D_fixed_Pa)./rho).^0.5));

%
fig5 = figure ("Name","Flow Rate as a Fuction of Measured Flow Rate",'Position',[100 250 900 500]);
hold all
plot (FR_real,FR_ideal_as_a_func_of_FR_real,'LineStyle','-.','LineWidth',2,'Color',[0 0.4470 0.7410])
plot (FR_real,FR_fixed_c_as_a_func_of_FR_real,'LineStyle','-.','LineWidth',2,'Color',[0.4940 0.1840 0.5560])
plot (FR_real,FR_fixed_pressurefall_as_a_func_of_FR_real,'LineStyle','-.','LineWidth',2,'Color',[0.8500 0.3250 0.0980])

e1 = errorbar(FR_real,FR_ideal,zeros(1,length(FR_real)), 'LineStyle','none');
e1.Color = [0 0.4470 0.7410];
e1.Marker = '.';
e1.MarkerSize = 15;

e1.XNegativeDelta = delta_FR_real;
e1.XPositiveDelta = delta_FR_real;
e1.YNegativeDelta = delta_FR_ideal;
e1.YPositiveDelta = delta_FR_ideal;

e2 = errorbar(FR_real,FR_fixed_c,zeros(1,length(FR_real)), 'LineStyle','none');
e2.Color = [0.4940 0.1840 0.5560];
e2.Marker = '.';
e2.MarkerSize = 15;

e2.XNegativeDelta = delta_FR_real;
e2.XPositiveDelta = delta_FR_real;
e2.YNegativeDelta = delta_FR_fixed_c;
e2.YPositiveDelta = delta_FR_fixed_c;

e3 = errorbar(FR_real,FR_fixed_pressurefall,zeros(1,length(FR_real)), 'LineStyle','none');
e3.Color = [0.8500 0.3250 0.0980];
e3.Marker = '.';
e3.MarkerSize = 15;

e3.XNegativeDelta = delta_FR_real;
e3.XPositiveDelta = delta_FR_real;
e3.YNegativeDelta = zeros(1,length(FR_real))+delta_FR_fixed_pressurefall;
e3.YPositiveDelta = zeros(1,length(FR_real))+delta_FR_fixed_pressurefall;

title ("Venturi - Flow Rate as a Fuction of Measured Flow Rate")
ylabel("Flow Rate [m^3/sec]")
xlabel("Measured Flow Rate [m^3/sec]")
grid on
grid minor
legend({'Ideal - y = 0.6023*x + 3.666e-4','Fixed C - y = 0.6094*x + 3.434e-4','Fixed Pressurefall - y = 0.6254*x + 3.25e-4'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig5, 'P2-graph4-1-1.png','Resolution',1200);

error1 = 100*(FR_ideal - FR_real)./FR_real;
error2 = 100*(FR_fixed_c - FR_real)./FR_real;
error3 = 100*(FR_fixed_pressurefall - FR_real)./FR_real;

%% Part 2 - 4 - 1 - 2
h_calib = [0.095 0.2 0.37 0.485 0.625]; % [m]
t = [30 30 30 30 30]; % [sec]
x = 58*10^(-3); % [m]
L = (58+263.5)*10^(-3); % [m]
d_calib = 0.19; % [m]
d_entrenc = 0.024; % [m]
d_exit = 0.024; % [m]
d_disturbance = 0.0115; % [m]
rho = 997; % [Kg/m^3]

FR_real = (pi*(0.5*d_calib)^2.*h_calib)./(t);
dp_E_D_V = [0.6 0.7 1.15 1.55 2.1];
dp_E_D_Pa = 1.004e4*dp_E_D_V+2.431e3;
sqrt_dp_E_D_Pa = (dp_E_D_Pa).^0.5;

FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly = [7.822e-6 -5.952e-4];
R_FR_real_as_a_func_of_sqrt_dp_E_D_Pa = 0.9856;
FR_real_as_a_func_of_sqrt_dp_E_D_Pa = FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly(1)*sqrt_dp_E_D_Pa+FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly(2);

delta_FR_calib = (((1.418*10^(-4))./t).^2+(1.418*10^(-3).*h_calib./t.^2 ).^2 ).^0.5;
delta_FR_from_sqrt_delta_dp_E_D_Pa = (7.822e-6*502)./(2.*(dp_E_D_Pa).^0.5);
delta_FR_real = ((delta_FR_calib).^2.+(delta_FR_from_sqrt_delta_dp_E_D_Pa).^2).^0.5;

fig6 = figure ("Name","Venturi - True Flow Rate as a Fuction of √∆p",'Position',[300 250 900 500]);
hold all
plot (sqrt_dp_E_D_Pa,FR_real_as_a_func_of_sqrt_dp_E_D_Pa,'LineWidth',2,'Color',[0 0.4470 0.7410])

e1 = errorbar(sqrt_dp_E_D_Pa,FR_real,zeros(1,length(sqrt_dp_E_D_Pa)), 'LineStyle','none');
e1.Color = [0 0 0];
e1.Marker = '.';
e1.MarkerSize = 15;

e1.XNegativeDelta = 502./(2.*(dp_E_D_Pa).^0.5);
e1.XPositiveDelta = 502./(2.*(dp_E_D_Pa).^0.5);
e1.YNegativeDelta = delta_FR_real;
e1.YPositiveDelta = delta_FR_real;

title ("Venturi - True Flow Rate as a Fuction of √∆p")
ylabel("True Flow Rate [m^3/sec]")
xlabel("√∆p [√Pa]")
grid on
grid minor
legend({'y = 7.822e-6 *x - 5.952e-4'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig6, 'P2-graph4-1-2.png','Resolution',1200);

%% Part 2 - 4 - 2 - 1
h_calib = [0.08 0.2 0.385 0.51 0.595]; % [m]
t = [30 30 30 30 30]; % [sec]
x = 47*10^(-3); % [m]
L = (47+228.5)*10^(-3); % [m]
d_calib = 0.19; % [m]
d_entrenc = 0.024; % [m]
d_exit = 0.024; % [m]
d_disturbance = 0.0115; % [m]
beta = d_disturbance/d_entrenc;
rho = 997; % [Kg/m^3]

A_entrenc = pi*(0.5*d_entrenc)^2;
A_exit = pi*(0.5*d_exit)^2;
A_disturbance = pi*(0.5*d_disturbance)^2;
FR_real = (pi*(0.5*d_calib)^2.*h_calib)./(t);
dp_E_D_V = [0.6 0.7 1.15 1.55 2.05];
dp_E_D_Pa = 1.004e4*dp_E_D_V+2.431e3;
FR_ideal = ((A_disturbance)./(1-(A_disturbance/A_entrenc).^2).^0.5)*((2*dp_E_D_Pa)/(rho)).^0.5;

FR_ideal_as_a_func_of_FR_real_poly = [0.5824 3.723e-4];
R_sqr_FR_ideal_as_a_func_of_FR_real = 0.9652;
FR_ideal_as_a_func_of_FR_real = FR_ideal_as_a_func_of_FR_real_poly(1)*FR_real+FR_ideal_as_a_func_of_FR_real_poly(2);

delta_FR_real = (((1.418*10^(-4))./t).^2+(1.418*10^(-3).*h_calib./t.^2 ).^2 ).^0.5;
delta_FR_ideal = ((A_disturbance)./(1-(A_disturbance/A_entrenc).^2).^0.5).*(502./(rho.*((2.*dp_E_D_Pa)./rho).^0.5));
%
v_entrenc_real = FR_real/A_entrenc;
v_disturbance = FR_real/A_disturbance;
v_avg_nozzle = (v_entrenc_real+v_disturbance)/2;
Reinolds_nozzle = (v_avg_nozzle.*d_entrenc)./(0.801*10^(-6));
c = [0.95 0.96 0.97 0.975 0.98];
FR_fixed_c = c.*FR_ideal;

FR_fixed_c_as_a_func_of_FR_real_poly = [0.5961 3.501e-4];
R_FR_fixed_c_as_a_func_of_FR_real = 0.9679;
FR_fixed_c_as_a_func_of_FR_real = FR_fixed_c_as_a_func_of_FR_real_poly(1)*FR_real+FR_fixed_c_as_a_func_of_FR_real_poly(2);

delta_FR_fixed_c = c.*delta_FR_ideal;
%
dp_E_E_V = [0.6 0.6 0.9 1.2 1.5];
dp_E_E_Pa = 1.004e4*dp_E_E_V+2.431e3;
dp_loss_Pa = (x/L)*dp_E_E_Pa;
dp_E_D_fixed_Pa = dp_E_D_Pa - dp_loss_Pa;
FR_fixed_pressurefall = ((A_disturbance)./(1-(A_disturbance/A_entrenc).^2).^0.5)*((2*dp_E_D_fixed_Pa)/(rho)).^0.5;

FR_fixed_pressurefall_as_a_func_of_FR_real_poly = [0.561 3.371e-4];
R_FR_fixed_pressurefall_as_a_func_of_FR_real = 0.9684;
FR_fixed_pressurefall_as_a_func_of_FR_real = FR_fixed_pressurefall_as_a_func_of_FR_real_poly(1)*FR_real+FR_fixed_pressurefall_as_a_func_of_FR_real_poly(2);

delta_dp_loss_Pa = (x/L)*502;
delta_dp_E_D_fixed_Pa = (delta_dp_loss_Pa^2+502^2)^0.5;
delta_FR_fixed_pressurefall = ((A_disturbance)./(1-(A_disturbance/A_entrenc).^2).^0.5).*(502./(rho.*((2.*delta_dp_E_D_fixed_Pa)./rho).^0.5));

%
fig7 = figure ("Name","Nozzle - Flow Rate as a Fuction of Measured Flow Rate",'Position',[500 250 900 500]);
hold all
plot (FR_real,FR_ideal_as_a_func_of_FR_real,'LineStyle','-.','LineWidth',2,'Color',[0 0.4470 0.7410])
plot (FR_real,FR_fixed_c_as_a_func_of_FR_real,'LineStyle','-.','LineWidth',2,'Color',[0.4940 0.1840 0.5560])
plot (FR_real,FR_fixed_pressurefall_as_a_func_of_FR_real,'LineStyle','-.','LineWidth',2,'Color',[0.8500 0.3250 0.0980])

e1 = errorbar(FR_real,FR_ideal,zeros(1,length(FR_real)), 'LineStyle','none');
e1.Color = [0 0.4470 0.7410];
e1.Marker = '.';
e1.MarkerSize = 15;

e1.XNegativeDelta = delta_FR_real;
e1.XPositiveDelta = delta_FR_real;
e1.YNegativeDelta = delta_FR_ideal;
e1.YPositiveDelta = delta_FR_ideal;

e2 = errorbar(FR_real,FR_fixed_c,zeros(1,length(FR_real)), 'LineStyle','none');
e2.Color = [0.4940 0.1840 0.5560];
e2.Marker = '.';
e2.MarkerSize = 15;

e2.XNegativeDelta = delta_FR_real;
e2.XPositiveDelta = delta_FR_real;
e2.YNegativeDelta = delta_FR_fixed_c;
e2.YPositiveDelta = delta_FR_fixed_c;

e3 = errorbar(FR_real,FR_fixed_pressurefall,zeros(1,length(FR_real)), 'LineStyle','none');
e3.Color = [0.8500 0.3250 0.0980];
e3.Marker = '.';
e3.MarkerSize = 15;

e3.XNegativeDelta = delta_FR_real;
e3.XPositiveDelta = delta_FR_real;
e3.YNegativeDelta = zeros(1,length(FR_real))+delta_FR_fixed_pressurefall;
e3.YPositiveDelta = zeros(1,length(FR_real))+delta_FR_fixed_pressurefall;

title ("Nozzle - Flow Rate as a Fuction of Measured Flow Rate")
ylabel("Flow Rate [m^3/sec]")
xlabel("Measured Flow Rate [m^3/sec]")
grid on
grid minor
legend({'Ideal - y = 0.5824*x + 3.723e-4','Fixed C - y = 0.5961*x + 3.501e-4','Fixed Pressurefall - y = 0.561*x + 3.371e-4'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig7, 'P2-graph4-2-1.png','Resolution',1200);

error1 = 100*(FR_ideal - FR_real)./FR_real;
error2 = 100*(FR_fixed_c - FR_real)./FR_real;
error3 = 100*(FR_fixed_pressurefall - FR_real)./FR_real;

%% Part 2 - 4 - 2 - 2
h_calib = [0.08 0.2 0.385 0.51 0.595]; % [m]
t = [30 30 30 30 30]; % [sec]
x = 47*10^(-3); % [m]
L = (47+228.5)*10^(-3); % [m]
d_calib = 0.19; % [m]
d_entrenc = 0.024; % [m]
d_exit = 0.024; % [m]
d_disturbance = 0.0115; % [m]
beta = d_disturbance/d_entrenc;
rho = 997; % [Kg/m^3]


FR_real = (pi*(0.5*d_calib)^2.*h_calib)./(t);
dp_E_D_V = [0.6 0.7 1.15 1.55 2.05];
dp_E_D_Pa = 1.004e4*dp_E_D_V+2.431e3;
sqrt_dp_E_D_Pa = (dp_E_D_Pa).^0.5;

FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly = [7.921e-6 -6.053e-4];
R_FR_real_as_a_func_of_sqrt_dp_E_D_Pa = 0.9652;
FR_real_as_a_func_of_sqrt_dp_E_D_Pa = FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly(1)*sqrt_dp_E_D_Pa+FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly(2);
% 
delta_FR_calib = (((1.418*10^(-4))./t).^2+(1.418*10^(-3).*h_calib./t.^2 ).^2 ).^0.5;
delta_FR_from_sqrt_delta_dp_E_D_Pa = (7.921e-6*502)./(2.*(dp_E_D_Pa).^0.5);
delta_FR_real = ((delta_FR_calib).^2.+(delta_FR_from_sqrt_delta_dp_E_D_Pa).^2).^0.5;

fig8 = figure ("Name","Nozzle - True Flow Rate as a Fuction of √∆p",'Position',[700 250 900 500]);
hold all
plot (sqrt_dp_E_D_Pa,FR_real_as_a_func_of_sqrt_dp_E_D_Pa,'LineWidth',2,'Color',[0 0.4470 0.7410])

e1 = errorbar(sqrt_dp_E_D_Pa,FR_real,zeros(1,length(sqrt_dp_E_D_Pa)), 'LineStyle','none');
e1.Color = [0 0 0];
e1.Marker = '.';
e1.MarkerSize = 15;

e1.XNegativeDelta = 502./(2.*(dp_E_D_Pa).^0.5);
e1.XPositiveDelta = 502./(2.*(dp_E_D_Pa).^0.5);
e1.YNegativeDelta = delta_FR_real;
e1.YPositiveDelta = delta_FR_real;

title ("Nozzle - True Flow Rate as a Fuction of √∆p")
ylabel("True Flow Rate [m^3/sec]")
xlabel("√∆p [√Pa]")
grid on
grid minor
legend({'y = 7.921e-6 *x - 6.053e-4'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig8, 'P2-graph4-2-2.png','Resolution',1200);

%% Part 2 - 4 - 3 - 1
h_calib = [0.06 0.185 0.38 0.51 0.63]; % [m]
t = [30 30 30 30 30]; % [sec]
x = 36*10^(-3); % [m]
L = (36+236.5)*10^(-3); % [m]
d_calib = 0.19; % [m]
d_entrenc = 0.024; % [m]
d_exit = 0.024; % [m]
d_disturbance = 0.0115; % [m]
beta = d_disturbance/d_entrenc;
rho = 997; % [Kg/m^3]

A_entrenc = pi*(0.5*d_entrenc)^2;
A_exit = pi*(0.5*d_exit)^2;
A_disturbance = pi*(0.5*d_disturbance)^2;
M = 1/(1-(A_disturbance/A_entrenc)^2)^0.5;
FR_real = (pi*(0.5*d_calib)^2.*h_calib)./(t);
dp_E_D_V = [0.6 0.85 1.6 2.4 3.45];
dp_E_D_Pa = 1.004e4*dp_E_D_V+2.431e3;
FR_ideal = ((A_disturbance)./(1-(A_disturbance/A_entrenc).^2).^0.5)*((2*dp_E_D_Pa)/(rho)).^0.5;

FR_ideal_as_a_func_of_FR_real_poly = [0.89 3.609e-4];
R_sqr_FR_ideal_as_a_func_of_FR_real = 9809;
FR_ideal_as_a_func_of_FR_real = FR_ideal_as_a_func_of_FR_real_poly(1)*FR_real+FR_ideal_as_a_func_of_FR_real_poly(2);

delta_FR_real = (((1.418*10^(-4))./t).^2+(1.418*10^(-3).*h_calib./t.^2 ).^2 ).^0.5;
delta_FR_ideal = ((A_disturbance)./(1-(A_disturbance/A_entrenc).^2).^0.5).*(502./(rho.*((2.*dp_E_D_Pa)./rho).^0.5));
%
v_entrenc_real = FR_real/A_entrenc;
v_disturbance = FR_real/A_disturbance;
v_avg_orifice = (v_entrenc_real+v_disturbance)/2;
Reinolds_orifice = (v_avg_orifice.*d_entrenc)./(0.801*10^(-6));
c = [0.6132 0.6132 0.6035 0.6035 0.6035];
FR_fixed_c = c.*FR_ideal;

FR_fixed_c_as_a_func_of_FR_real_poly = [0.527 2.23e-4];
R_FR_fixed_c_as_a_func_of_FR_real = 0.9792;
FR_fixed_c_as_a_func_of_FR_real = FR_fixed_c_as_a_func_of_FR_real_poly(1)*FR_real+FR_fixed_c_as_a_func_of_FR_real_poly(2);

delta_FR_fixed_c = c.*delta_FR_ideal;
%
dp_E_E_V = [0.55 0.75 1.3 1.9 2.6];
dp_E_E_Pa = 1.004e4*dp_E_E_V+2.431e3;
dp_loss_Pa = (x/L)*dp_E_E_Pa;
dp_E_D_fixed_Pa = dp_E_D_Pa - dp_loss_Pa;
FR_fixed_pressurefall = ((A_disturbance)./(1-(A_disturbance/A_entrenc).^2).^0.5)*((2*dp_E_D_fixed_Pa)/(rho)).^0.5;

FR_fixed_pressurefall_as_a_func_of_FR_real_poly = [0.8529 3.358e-4];
R_FR_fixed_pressurefall_as_a_func_of_FR_real = 0.9807;
FR_fixed_pressurefall_as_a_func_of_FR_real = FR_fixed_pressurefall_as_a_func_of_FR_real_poly(1)*FR_real+FR_fixed_pressurefall_as_a_func_of_FR_real_poly(2);

delta_dp_loss_Pa = (x/L)*502;
delta_dp_E_D_fixed_Pa = (delta_dp_loss_Pa^2+502^2)^0.5;
delta_FR_fixed_pressurefall = ((A_disturbance)./(1-(A_disturbance/A_entrenc).^2).^0.5).*(502./(rho.*((2.*delta_dp_E_D_fixed_Pa)./rho).^0.5));


fig9 = figure ("Name","Orifice - Flow Rate as a Fuction of Measured Flow Rate",'Position',[100 150 900 500]);
hold all
plot (FR_real,FR_ideal_as_a_func_of_FR_real,'LineStyle','-.','LineWidth',2,'Color',[0 0.4470 0.7410])
plot (FR_real,FR_fixed_c_as_a_func_of_FR_real,'LineStyle','-.','LineWidth',2,'Color',[0.4940 0.1840 0.5560])
plot (FR_real,FR_fixed_pressurefall_as_a_func_of_FR_real,'LineStyle','-.','LineWidth',2,'Color',[0.8500 0.3250 0.0980])

e1 = errorbar(FR_real,FR_ideal,zeros(1,length(FR_real)), 'LineStyle','none');
e1.Color = [0 0.4470 0.7410];
e1.Marker = '.';
e1.MarkerSize = 15;

e1.XNegativeDelta = delta_FR_real;
e1.XPositiveDelta = delta_FR_real;
e1.YNegativeDelta = delta_FR_ideal;
e1.YPositiveDelta = delta_FR_ideal;

e2 = errorbar(FR_real,FR_fixed_c,zeros(1,length(FR_real)), 'LineStyle','none');
e2.Color = [0.4940 0.1840 0.5560];
e2.Marker = '.';
e2.MarkerSize = 15;

e2.XNegativeDelta = delta_FR_real;
e2.XPositiveDelta = delta_FR_real;
e2.YNegativeDelta = delta_FR_fixed_c;
e2.YPositiveDelta = delta_FR_fixed_c;

e3 = errorbar(FR_real,FR_fixed_pressurefall,zeros(1,length(FR_real)), 'LineStyle','none');
e3.Color = [0.8500 0.3250 0.0980];
e3.Marker = '.';
e3.MarkerSize = 15;

e3.XNegativeDelta = delta_FR_real;
e3.XPositiveDelta = delta_FR_real;
e3.YNegativeDelta = zeros(1,length(FR_real))+delta_FR_fixed_pressurefall;
e3.YPositiveDelta = zeros(1,length(FR_real))+delta_FR_fixed_pressurefall;

title ("Orifice - Flow Rate as a Fuction of Measured Flow Rate")
ylabel("Flow Rate [m^3/sec]")
xlabel("Measured Flow Rate [m^3/sec]")
grid on
grid minor
legend({'Ideal - y = 0.89*x + 3.609e-4','Fixed C - y = 0.527*x + 2.23e-4','Fixed Pressurefall - y = 0.8529*x + 3.358e-4'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig9, 'P2-graph4-3-1.png','Resolution',1200);

error1 = 100*(FR_ideal - FR_real)./FR_real;
error2 = 100*(FR_fixed_c - FR_real)./FR_real;
error3 = 100*(FR_fixed_pressurefall - FR_real)./FR_real;

%% Part 2 - 4 - 3 - 2
h_calib = [0.06 0.185 0.38 0.51 0.63]; % [m]
t = [30 30 30 30 30]; % [sec]
x = 47*10^(-3); % [m]
L = (47+228.5)*10^(-3); % [m]
d_calib = 0.19; % [m]
d_entrenc = 0.024; % [m]
d_exit = 0.024; % [m]
d_disturbance = 0.0115; % [m]
beta = d_disturbance/d_entrenc;
rho = 997; % [Kg/m^3]


FR_real = (pi*(0.5*d_calib)^2.*h_calib)./(t);
dp_E_D_V = [0.6 0.85 1.6 2.4 3.45];
dp_E_D_Pa = 1.004e4*dp_E_D_V+2.431e3;
sqrt_dp_E_D_Pa = (dp_E_D_Pa).^0.5;

FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly = [5.268e-6 -3.914e-4];
R_FR_real_as_a_func_of_sqrt_dp_E_D_Pa = 0.9809;
FR_real_as_a_func_of_sqrt_dp_E_D_Pa = FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly(1)*sqrt_dp_E_D_Pa+FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly(2);
% 
delta_FR_calib = (((1.418*10^(-4))./t).^2+(1.418*10^(-3).*h_calib./t.^2 ).^2 ).^0.5;
delta_FR_from_sqrt_delta_dp_E_D_Pa = (5.268e-6*502)./(2.*(dp_E_D_Pa).^0.5);
delta_FR_real = ((delta_FR_calib).^2.+(delta_FR_from_sqrt_delta_dp_E_D_Pa).^2).^0.5;

fig10 = figure ("Name","Orifice - True Flow Rate as a Fuction of √∆p",'Position',[300 150 900 500]);
hold all
plot (sqrt_dp_E_D_Pa,FR_real_as_a_func_of_sqrt_dp_E_D_Pa,'LineWidth',2,'Color',[0 0.4470 0.7410])

e1 = errorbar(sqrt_dp_E_D_Pa,FR_real,zeros(1,length(sqrt_dp_E_D_Pa)), 'LineStyle','none');
e1.Color = [0 0 0];
e1.Marker = '.';
e1.MarkerSize = 15;

e1.XNegativeDelta = 502./(2.*(dp_E_D_Pa).^0.5);
e1.XPositiveDelta = 502./(2.*(dp_E_D_Pa).^0.5);
e1.YNegativeDelta = delta_FR_real;
e1.YPositiveDelta = delta_FR_real;

title ("Orifice - True Flow Rate as a Fuction of √∆p")
ylabel("True Flow Rate [m^3/sec]")
xlabel("√∆p [√Pa]")
grid on
grid minor
legend({'y = 5.268e-6*x - 3.914e-4'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig10, 'P2-graph4-3-2.png','Resolution',1200);

%% Part 2 - 4 - 4 - 1
h_calib1 = [0.095 0.2 0.37 0.485 0.625]; % [m]
h_calib2 = [0.08 0.2 0.385 0.51 0.595]; % [m]
h_calib3 = [0.06 0.185 0.38 0.51 0.63]; % [m]
t = [30 30 30 30 30]; % [sec]
x = 58*10^(-3); % [m]
L = (58+263.5)*10^(-3); % [m]
d_calib = 0.19; % [m]
d_entrenc = 0.024; % [m]
d_exit = 0.024; % [m]
d_disturbance = 0.0115; % [m]
rho = 997; % [Kg/m^3]

FR_real1 = (pi*(0.5*d_calib)^2.*h_calib1)./(t);
dp_E_D_V1 = [0.6 0.7 1.15 1.55 2.1];
dp_E_D_Pa1 = 1.004e4*dp_E_D_V1+2.431e3;
sqrt_dp_E_D_Pa1 = (dp_E_D_Pa1).^0.5;

FR_real2 = (pi*(0.5*d_calib)^2.*h_calib2)./(t);
dp_E_D_V2 = [0.6 0.7 1.15 1.55 2.05];
dp_E_D_Pa2 = 1.004e4*dp_E_D_V2+2.431e3;
sqrt_dp_E_D_Pa2 = (dp_E_D_Pa2).^0.5;

FR_real3 = (pi*(0.5*d_calib)^2.*h_calib3)./(t);
dp_E_D_V3 = [0.6 0.85 1.6 2.4 3.45];
dp_E_D_Pa3 = 1.004e4*dp_E_D_V3+2.431e3;
sqrt_dp_E_D_Pa3 = (dp_E_D_Pa3).^0.5;


FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly1 = [7.822e-6 -5.952e-4];
R_FR_real_as_a_func_of_sqrt_dp_E_D_Pa1 = 0.9856;
FR_real_as_a_func_of_sqrt_dp_E_D_Pa1 = FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly1(1)*sqrt_dp_E_D_Pa1+FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly1(2);

FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly2 = [7.921e-6 -6.053e-4];
R_FR_real_as_a_func_of_sqrt_dp_E_D_Pa2 = 0.9652;
FR_real_as_a_func_of_sqrt_dp_E_D_Pa2 = FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly2(1)*sqrt_dp_E_D_Pa2+FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly2(2);

FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly3 = [5.268e-6 -3.914e-4];
R_FR_real_as_a_func_of_sqrt_dp_E_D_Pa3 = 0.9809;
FR_real_as_a_func_of_sqrt_dp_E_D_Pa3 = FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly3(1)*sqrt_dp_E_D_Pa3+FR_real_as_a_func_of_sqrt_dp_E_D_Pa_poly3(2);


delta_FR_calib1 = (((1.418*10^(-4))./t).^2+(1.418*10^(-3).*h_calib1./t.^2 ).^2 ).^0.5;
delta_FR_from_sqrt_delta_dp_E_D_Pa1 = (7.822e-6*502)./(2.*(dp_E_D_Pa1).^0.5);
delta_FR_real1 = ((delta_FR_calib1).^2.+(delta_FR_from_sqrt_delta_dp_E_D_Pa1).^2).^0.5;

delta_FR_calib2 = (((1.418*10^(-4))./t).^2+(1.418*10^(-3).*h_calib2./t.^2 ).^2 ).^0.5;
delta_FR_from_sqrt_delta_dp_E_D_Pa2 = (7.921e-6*502)./(2.*(dp_E_D_Pa2).^0.5);
delta_FR_real2 = ((delta_FR_calib2).^2.+(delta_FR_from_sqrt_delta_dp_E_D_Pa2).^2).^0.5;

delta_FR_calib3 = (((1.418*10^(-4))./t).^2+(1.418*10^(-3).*h_calib3./t.^2 ).^2 ).^0.5;
delta_FR_from_sqrt_delta_dp_E_D_Pa3 = (5.268e-6*502)./(2.*(dp_E_D_Pa3).^0.5);
delta_FR_real3 = ((delta_FR_calib3).^2.+(delta_FR_from_sqrt_delta_dp_E_D_Pa3).^2).^0.5;


fig11 = figure ("Name","Calibration  - True Flow Rate as a Fuction of √∆p",'Position',[500 150 900 500]);
hold all
plot (sqrt_dp_E_D_Pa1,FR_real_as_a_func_of_sqrt_dp_E_D_Pa1,'LineWidth',2,'Color',[0 0.4470 0.7410])
plot (sqrt_dp_E_D_Pa2,FR_real_as_a_func_of_sqrt_dp_E_D_Pa2,'LineWidth',2,'Color',[0.4940 0.1840 0.5560])
plot (sqrt_dp_E_D_Pa3,FR_real_as_a_func_of_sqrt_dp_E_D_Pa3,'LineWidth',2,'Color',[0.8500 0.3250 0.0980])

e1 = errorbar(sqrt_dp_E_D_Pa1,FR_real1,zeros(1,length(sqrt_dp_E_D_Pa1)), 'LineStyle','none');
e1.Color = [0 0.4470 0.7410];
e1.Marker = '.';
e1.MarkerSize = 15;

e1.XNegativeDelta = 502./(2.*(dp_E_D_Pa1).^0.5);
e1.XPositiveDelta = 502./(2.*(dp_E_D_Pa1).^0.5);
e1.YNegativeDelta = delta_FR_real1;
e1.YPositiveDelta = delta_FR_real1;

e2 = errorbar(sqrt_dp_E_D_Pa2,FR_real2,zeros(1,length(sqrt_dp_E_D_Pa2)), 'LineStyle','none');
e2.Color = [0.4940 0.1840 0.5560];
e2.Marker = '.';
e2.MarkerSize = 15;

e2.XNegativeDelta = 502./(2.*(dp_E_D_Pa2).^0.5);
e2.XPositiveDelta = 502./(2.*(dp_E_D_Pa2).^0.5);
e2.YNegativeDelta = delta_FR_real2;
e2.YPositiveDelta = delta_FR_real2;

e3 = errorbar(sqrt_dp_E_D_Pa3,FR_real3,zeros(1,length(sqrt_dp_E_D_Pa3)), 'LineStyle','none');
e3.Color = [0.8500 0.3250 0.0980];
e3.Marker = '.';
e3.MarkerSize = 15;

e3.XNegativeDelta = 502./(2.*(dp_E_D_Pa3).^0.5);
e3.XPositiveDelta = 502./(2.*(dp_E_D_Pa3).^0.5);
e3.YNegativeDelta = delta_FR_real3;
e3.YPositiveDelta = delta_FR_real3;

title ("Calibration  - True Flow Rate as a Fuction of √∆p")
ylabel("True Flow Rate [m^3/sec]")
xlabel("√∆p [√Pa]")
grid on
grid minor
legend({'Venturi - y = 7.822e-6 *x - 5.952e-4', 'Nozzle - y = 7.921e-6 *x - 6.053e-4', 'Orifice - y = 5.268e-6*x - 3.914e-4'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig11, 'P2-graph4-4-1.png','Resolution',1200);

%% Part 2 - 4 - 4 - 2
h_calib1 = [0.095 0.2 0.37 0.485 0.625]; % [m]
h_calib2 = [0.08 0.2 0.385 0.51 0.595]; % [m]
h_calib3 = [0.06 0.185 0.38 0.51 0.63]; % [m]
t = [30 30 30 30 30]; % [sec]
x = 58*10^(-3); % [m]
L = (58+263.5)*10^(-3); % [m]
d_calib = 0.19; % [m]
d_entrenc = 0.024; % [m]
d_exit = 0.024; % [m]
d_disturbance = 0.0115; % [m]
rho = 997; % [Kg/m^3]

FR_real1 = (pi*(0.5*d_calib)^2.*h_calib1)./(t);
dp_E_D_V1 = [0.6 0.7 1.15 1.55 2.1];
dp_E_D_Pa1 = 1.004e4*dp_E_D_V1+2.431e3;
sq_FR_real1 = FR_real1.^2;

FR_real2 = (pi*(0.5*d_calib)^2.*h_calib2)./(t);
dp_E_D_V2 = [0.6 0.7 1.15 1.55 2.05];
dp_E_D_Pa2 = 1.004e4*dp_E_D_V2+2.431e3;
sq_FR_real2 = FR_real2.^2;

FR_real3 = (pi*(0.5*d_calib)^2.*h_calib3)./(t);
dp_E_D_V3 = [0.6 0.85 1.6 2.4 3.45];
dp_E_D_Pa3 = 1.004e4*dp_E_D_V3+2.431e3;
sq_FR_real3 = FR_real3.^2;


dp_E_D_Pa_as_a_func_of_sq_FR_real_poly1 = [4.487e10 8173];
R_dp_E_D_Pa_as_a_func_of_sq_FR_real1 = 0.9970;
dp_E_D_Pa_as_a_func_of_sq_FR_real1 = dp_E_D_Pa_as_a_func_of_sq_FR_real_poly1(1)*sq_FR_real1+dp_E_D_Pa_as_a_func_of_sq_FR_real_poly1(2);

dp_E_D_Pa_as_a_func_of_sq_FR_real_poly2 = [4.621e10 7904];
R_dp_E_D_Pa_as_a_func_of_sq_FR_real2 = 0.9948;
dp_E_D_Pa_as_a_func_of_sq_FR_real2 = dp_E_D_Pa_as_a_func_of_sq_FR_real_poly2(1)*sq_FR_real2+dp_E_D_Pa_as_a_func_of_sq_FR_real_poly2(2);

dp_E_D_Pa_as_a_func_of_sq_FR_real_poly3 = [8.053e10 8229];
R_dp_E_D_Pa_as_a_func_of_sq_FR_real3 = 0.9994;
dp_E_D_Pa_as_a_func_of_sq_FR_real3 = dp_E_D_Pa_as_a_func_of_sq_FR_real_poly3(1)*sq_FR_real3+dp_E_D_Pa_as_a_func_of_sq_FR_real_poly3(2);


delta_FR_calib1 = (((1.418*10^(-4))./t).^2+(1.418*10^(-3).*h_calib1./t.^2 ).^2 ).^0.5;
delta_dp_E_D_Pa_from_sq_FR_calib1 = 4.487e10*2*FR_real1.*delta_FR_calib1;
delta_dp_E_D_Pa1 = ((502).^2.+(delta_dp_E_D_Pa_from_sq_FR_calib1).^2).^0.5;

delta_FR_calib2 = (((1.418*10^(-4))./t).^2+(1.418*10^(-3).*h_calib2./t.^2 ).^2 ).^0.5;
delta_dp_E_D_Pa_from_sq_FR_calib2 = 4.621e10*2*FR_real2.*delta_FR_calib2;
delta_dp_E_D_Pa2 = ((502).^2.+(delta_dp_E_D_Pa_from_sq_FR_calib2).^2).^0.5;

delta_FR_calib3 = (((1.418*10^(-4))./t).^2+(1.418*10^(-3).*h_calib3./t.^2 ).^2 ).^0.5;
delta_dp_E_D_Pa_from_sq_FR_calib3 = 8.053e10*2*FR_real3.*delta_FR_calib3;
delta_dp_E_D_Pa3 = ((502).^2.+(delta_dp_E_D_Pa_from_sq_FR_calib3).^2).^0.5;


fig12 = figure ("Name","Calibration  - ∆p as a Fuction of True Flow Rate Square",'Position',[700 150 900 500]);
hold all
plot (sq_FR_real1,dp_E_D_Pa_as_a_func_of_sq_FR_real1,'LineWidth',2,'Color',[0 0.4470 0.7410])
plot (sq_FR_real2,dp_E_D_Pa_as_a_func_of_sq_FR_real2,'LineWidth',2,'Color',[0.4940 0.1840 0.5560])
plot (sq_FR_real3,dp_E_D_Pa_as_a_func_of_sq_FR_real3,'LineWidth',2,'Color',[0.8500 0.3250 0.0980])

e1 = errorbar(sq_FR_real1,dp_E_D_Pa1,zeros(1,length(sq_FR_real1)), 'LineStyle','none');
e1.Color = [0 0.4470 0.7410];
e1.Marker = '.';
e1.MarkerSize = 15;

e1.XNegativeDelta = 2*FR_real1.*delta_FR_calib1;
e1.XPositiveDelta = 2*FR_real1.*delta_FR_calib1;
e1.YNegativeDelta = delta_dp_E_D_Pa1;
e1.YPositiveDelta = delta_dp_E_D_Pa1;

e2 = errorbar(sq_FR_real2,dp_E_D_Pa2,zeros(1,length(sq_FR_real2)), 'LineStyle','none');
e2.Color = [0.4940 0.1840 0.5560];
e2.Marker = '.';
e2.MarkerSize = 15;

e2.XNegativeDelta = 2*FR_real2.*delta_FR_calib2;
e2.XPositiveDelta = 2*FR_real2.*delta_FR_calib2;
e2.YNegativeDelta = delta_dp_E_D_Pa2;
e2.YPositiveDelta = delta_dp_E_D_Pa2;

e3 = errorbar(sq_FR_real3,dp_E_D_Pa3,zeros(1,length(sq_FR_real3)), 'LineStyle','none');
e3.Color = [0.8500 0.3250 0.0980];
e3.Marker = '.';
e3.MarkerSize = 15;

e3.XNegativeDelta = 2*FR_real3.*delta_FR_calib3;
e3.XPositiveDelta = 2*FR_real3.*delta_FR_calib3;
e3.YNegativeDelta = delta_dp_E_D_Pa3;
e3.YPositiveDelta = delta_dp_E_D_Pa3;

title ("Calibration  - ∆p as a Fuction of True Flow Rate Square")
ylabel("∆p [Pa]")
xlabel("True Flow Rate Square [m^6/sec^2]")
grid on
grid minor
legend({'Venturi - y = 4.487e10*x + 8173', 'Nozzle - y = 4.621e10*x + 7904', 'Orifice - y = 8.053e10*x + 8229'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig12, 'P2-graph4-4-2.png','Resolution',1200);
