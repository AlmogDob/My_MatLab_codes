clc;
format long

%% gauge 1
V1 = [100.3 320.9 519.2 724.6 928.8 1129 1343 1546 1736 1958 2179]; % [10^(-6)*V]
T1 = [31 36 41 46 51 56 61 66 71 76 81]; % [degree C]

V1_as_a_func_of_T1_poly = [41.18 -1171];
R_sq_V1_as_a_func_of_T1 = 0.9999;
V1_as_a_func_of_T1 = V1_as_a_func_of_T1_poly(1)*T1+V1_as_a_func_of_T1_poly(2);

delta_T1 = zeros(1, length(T1)) + 0.5; % [degree C]

fig1 = figure ("Name","Gauge 1 - Voltage as a Function of Temperature",'Position',[100 350 900 500]);
hold all
plot (T1,V1_as_a_func_of_T1,'LineWidth',2,'Color',[0 0.4470 0.7410])

e1 = errorbar(T1,V1,zeros(1,length(T1)), 'LineStyle','none');
e1.Color = [0 0 0];
e1.Marker = '.';
e1.MarkerSize = 15;

e1.XNegativeDelta = delta_T1;
e1.XPositiveDelta = delta_T1;

title ("Gauge 1 - Voltage as a Function of Temperature")
ylabel("Voltage [μV]")
xlabel("Temperature [°C]")
grid on
grid minor
legend({'y = 41.18*x - 1171'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig1, 'P1-graph1.png','Resolution',1200);

%% gauge 2
V2 = [1047 1320 1536 1748 1952 2166 2372 2594 2815 3024 3234]; % [10^(-6)*V]
T2 = [31 36 41 46 51 56 61 66 71 76 81]; % [degree C]

V2_as_a_func_of_T2_poly = [43.09 -248.7];
R_sq_V2_as_a_func_of_T2 = 0.9995;
V2_as_a_func_of_T2 = V2_as_a_func_of_T2_poly(1)*T2+V2_as_a_func_of_T2_poly(2);

delta_T2 = zeros(1, length(T2)) + 0.5; % [degree C]

fig2 = figure ("Name","Gauge 2 - Voltage as a Function of Temperature",'Position',[300 350 900 500]);
hold all
plot (T2,V2_as_a_func_of_T2,'LineWidth',2,'Color',[0 0.4470 0.7410])

e2 = errorbar(T2,V2,zeros(1,length(T2)), 'LineStyle','none');
e2.Color = [0 0 0];
e2.Marker = '.';
e2.MarkerSize = 15;

e2.XNegativeDelta = delta_T2;
e2.XPositiveDelta = delta_T2;

title ("Gauge 2 - Voltage as a Function of Temperature")
ylabel("Voltage [μV]")
xlabel("Temperature [°C]")
grid on
grid minor
legend({'y = 43.09*x - 248.7'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig2, 'P1-graph2.png','Resolution',1200);

%% gauge 3
V3 = [1096 1381 1610 1848 2059 2282 2507 2734 2941 3147 3367]; % [10^(-6)*V]
T3 = [31 36 41 46 51 56 61 66 71 76 81]; % [degree C]

V3_as_a_func_of_T3_poly = [44.79 -237.8];
R_sq_V3_as_a_func_of_T3 = 0.9989;
V3_as_a_func_of_T3 = V3_as_a_func_of_T3_poly(1)*T3+V3_as_a_func_of_T3_poly(2);

delta_T3 = zeros(1, length(T3)) + 0.5; % [degree C]

fig3 = figure ("Name","Gauge 3 - Voltage as a Function of Temperature",'Position',[500 350 900 500]);
hold all
plot (T3,V3_as_a_func_of_T3,'LineWidth',2,'Color',[0 0.4470 0.7410])

e3 = errorbar(T3,V3,zeros(1,length(T3)), 'LineStyle','none');
e3.Color = [0 0 0];
e3.Marker = '.';
e3.MarkerSize = 15;

e3.XNegativeDelta = delta_T3;
e3.XPositiveDelta = delta_T3;

title ("Gauge 3 - Voltage as a Function of Temperature")
ylabel("Voltage [μV]")
xlabel("Temperature [°C]")
grid on
grid minor
legend({'y = 44.79*x - 237.8'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig3, 'P1-graph3.png','Resolution',1200);

%% gauge 4
V4 = [1470 1777 2021 2282 2542 2837 3088 3329 3574 3822 4071]; % [10^(-6)*V]
T4 = [31 36 41 46 51 56 61 66 71 76 81]; % [degree C]

V4_as_a_func_of_T4_poly = [51.79 -99.01];
R_sq_V4_as_a_func_of_T4 = 0.9993;
V4_as_a_func_of_T4 = V4_as_a_func_of_T4_poly(1)*T4+V4_as_a_func_of_T4_poly(2);

delta_T4 = zeros(1, length(T4)) + 0.5; % [degree C]

fig4 = figure ("Name","Gauge 4 - Voltage as a Function of Temperature",'Position',[100 250 900 500]);
hold all
plot (T4,V4_as_a_func_of_T4,'LineWidth',2,'Color',[0 0.4470 0.7410])

e4 = errorbar(T4,V4,zeros(1,length(T4)), 'LineStyle','none');
e4.Color = [0 0 0];
e4.Marker = '.';
e4.MarkerSize = 15;

e4.XNegativeDelta = delta_T4;
e4.XPositiveDelta = delta_T4;

title ("Gauge 4 - Voltage as a Function of Temperature")
ylabel("Voltage [μV]")
xlabel("Temperature [°C]")
grid on
grid minor
legend({'y = 51.79*x - 99.01'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig4, 'P1-graph4.png','Resolution',1200);

%% gauge 6
V6 = [1120 1348 1535 1738 1947 2145 2361 2582 2792 2979 3139]; % [10^(-6)*V]
T6 = [31 36 41 46 51 56 61 66 71 76 81]; % [degree C]

V6_as_a_func_of_T6_poly = [40.89 -136.8];
R_sq_V6_as_a_func_of_T6 = 0.9993;
V6_as_a_func_of_T6 = V6_as_a_func_of_T6_poly(1)*T6+V6_as_a_func_of_T6_poly(2);

delta_T6 = zeros(1, length(T6)) + 0.5; % [degree C]

fig6 = figure ("Name","Gauge 6 - Voltage as a Function of Temperature",'Position',[300 250 900 500]);
hold all
plot (T6,V6_as_a_func_of_T6,'LineWidth',2,'Color',[0 0.4470 0.7410])

e6 = errorbar(T6,V6,zeros(1,length(T6)), 'LineStyle','none');
e6.Color = [0 0 0];
e6.Marker = '.';
e6.MarkerSize = 15;

e6.XNegativeDelta = delta_T6;
e6.XPositiveDelta = delta_T6;

title ("Gauge 6 - Voltage as a Function of Temperature")
ylabel("Voltage [μV]")
xlabel("Temperature [°C]")
grid on
grid minor
legend({'y = 40.89*x - 136.8'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig6, 'P1-graph6.png','Resolution',1200);

%% gauge 7
V7 = [264.2 563.1 778.3 1000 1185 1405 1612 1818 2020 2195 2400]; % [10^(-6)*V]
T7 = [31 36 41 46 51 56 61 66 71 76 81]; % [degree C]

V7_as_a_func_of_T7_poly = [41.81 -955.8];
R_sq_V7_as_a_func_of_T7 = 0.9979;
V7_as_a_func_of_T7 = V7_as_a_func_of_T7_poly(1)*T7+V7_as_a_func_of_T7_poly(2);

delta_T7 = zeros(1, length(T7)) + 0.5; % [degree C]

fig7 = figure ("Name","Gauge 7 - Voltage as a Function of Temperature",'Position',[500 250 900 500]);
hold all
plot (T7,V7_as_a_func_of_T7,'LineWidth',2,'Color',[0 0.4470 0.7410])

e7 = errorbar(T7,V7,zeros(1,length(T7)), 'LineStyle','none');
e7.Color = [0 0 0];
e7.Marker = '.';
e7.MarkerSize = 15;

e7.XNegativeDelta = delta_T7;
e7.XPositiveDelta = delta_T7;

title ("Gauge 7 - Voltage as a Function of Temperature")
ylabel("Voltage [μV]")
xlabel("Temperature [°C]")
grid on
grid minor
legend({'y = 41.81*x - 955.8'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig7, 'P1-graph7.png','Resolution',1200);

%% gauge 8
V8 = [614.9 896.4 1065 1270 1417 1627 1813 1982 2158 2319 2475]; % [10^(-6)*V]
T8 = [31 36 41 46 51 56 61 66 71 76 81]; % [degree C]

V8_as_a_func_of_T8_poly = [36.53 -442.1];
R_sq_V8_as_a_func_of_T8 = 0.9967;
V8_as_a_func_of_T8 = V8_as_a_func_of_T8_poly(1)*T8+V8_as_a_func_of_T8_poly(2);

delta_T8 = zeros(1, length(T8)) + 0.5; % [degree C]

fig8 = figure ("Name","Gauge 8 - Voltage as a Function of Temperature",'Position',[700 250 900 500]);
hold all
plot (T8,V8_as_a_func_of_T8,'LineWidth',2,'Color',[0 0.4470 0.7410])

e8 = errorbar(T8,V8,zeros(1,length(T8)), 'LineStyle','none');
e8.Color = [0 0 0];
e8.Marker = '.';
e8.MarkerSize = 15;

e8.XNegativeDelta = delta_T8;
e8.XPositiveDelta = delta_T8;

title ("Gauge 8 - Voltage as a Function of Temperature")
ylabel("Voltage [μV]")
xlabel("Temperature [°C]")
grid on
grid minor
legend({'y = 36.53*x - 442.1'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig8, 'P1-graph8.png','Resolution',1200);

%% gauge 9
R9 = [111.7 113.2 114.7 116.2 117.9 119.7 121.6 123.4 125.4 127.1 129.1]; % [10^(-6)*V]
T9 = [31 36 41 46 51 56 61 66 71 76 81]; % [degree C]

R9_as_a_func_of_T9_poly = [0.3505 100.4];
R_sq_R9_as_a_func_of_T9 = 0.9978;
R9_as_a_func_of_T9 = R9_as_a_func_of_T9_poly(1)*T9+R9_as_a_func_of_T9_poly(2);

delta_T9 = zeros(1, length(T9)) + 0.5; % [degree C]

fig9 = figure ("Name","Gauge 9 - Resistance as a Function of Temperature",'Position',[100 150 900 400]);
hold all
plot (T9,R9_as_a_func_of_T9,'LineWidth',2,'Color',[0 0.4470 0.7410])

e9 = errorbar(T9,R9,zeros(1,length(T9)), 'LineStyle','none');
e9.Color = [0 0 0];
e9.Marker = '.';
e9.MarkerSize = 15;

e9.XNegativeDelta = delta_T9;
e9.XPositiveDelta = delta_T9;

title ("Gauge 9 - Resistance as a Function of Temperature")
ylabel("Resistance [Ω]")
xlabel("Temperature [°C]")
grid on
grid minor
legend({'y = 0.3505*x + 100.4'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig9, 'P1-graph9.png','Resolution',1200);

%%
fig10 = figure ("Name","Voltage as a Function of Temperature",'Position',[300 150 800 600]);
hold all
plot (T1,V1_as_a_func_of_T1,'LineWidth',2,'Color',[0 0.4470 0.7410])
plot (T2,V2_as_a_func_of_T2,'LineWidth',2,'Color',[0.8500 0.3250 0.0980])
plot (T3,V3_as_a_func_of_T3,'LineWidth',2,'Color',[0.9290 0.6940 0.1250])
plot (T4,V4_as_a_func_of_T4,'LineWidth',2,'Color',[0.4940 0.1840 0.5560])
plot (T6,V6_as_a_func_of_T6,'LineWidth',2,'Color',[0.4660 0.6740 0.1880])
plot (T7,V7_as_a_func_of_T7,'LineWidth',2,'Color',[0.3010 0.7450 0.9330])
plot (T8,V8_as_a_func_of_T8,'LineWidth',2,'Color',[0.6350 0.0780 0.1840])


e1 = errorbar(T1,V1,zeros(1,length(T1)), 'LineStyle','none');
e1.Color = [0 0.4470 0.7410];
e1.Marker = '.';
e1.MarkerSize = 15;

e1.XNegativeDelta = delta_T1;
e1.XPositiveDelta = delta_T1;


e2 = errorbar(T2,V2,zeros(1,length(T2)), 'LineStyle','none');
e2.Color = [0.8500 0.3250 0.0980];
e2.Marker = '.';
e2.MarkerSize = 15;

e2.XNegativeDelta = delta_T2;
e2.XPositiveDelta = delta_T2;


e3 = errorbar(T3,V3,zeros(1,length(T3)), 'LineStyle','none');
e3.Color = [0.9290 0.6940 0.1250];
e3.Marker = '.';
e3.MarkerSize = 15;

e3.XNegativeDelta = delta_T3;
e3.XPositiveDelta = delta_T3;


e4 = errorbar(T4,V4,zeros(1,length(T4)), 'LineStyle','none');
e4.Color = [0.4940 0.1840 0.5560];
e4.Marker = '.';
e4.MarkerSize = 15;

e4.XNegativeDelta = delta_T4;
e4.XPositiveDelta = delta_T4;


e6 = errorbar(T6,V6,zeros(1,length(T6)), 'LineStyle','none');
e6.Color = [0.4660 0.6740 0.1880];
e6.Marker = '.';
e6.MarkerSize = 15;

e6.XNegativeDelta = delta_T6;
e6.XPositiveDelta = delta_T6;


e7 = errorbar(T7,V7,zeros(1,length(T7)), 'LineStyle','none');
e7.Color = [0.3010 0.7450 0.9330];
e7.Marker = '.';
e7.MarkerSize = 15;

e7.XNegativeDelta = delta_T7;
e7.XPositiveDelta = delta_T7;


e8 = errorbar(T8,V8,zeros(1,length(T8)), 'LineStyle','none');
e8.Color = [0.6350 0.0780 0.1840];
e8.Marker = '.';
e8.MarkerSize = 15;

e8.XNegativeDelta = delta_T8;
e8.XPositiveDelta = delta_T8;


title ("Voltage as a Function of Temperature")
ylabel("Voltage [μV]")
xlabel("Temperature [°C]")
grid on
grid minor
legend({'Gauge 1 - y = 41.18*x - 1171','Gauge 2 - y = 43.09*x - 248.7', ...
    'Gauge 3 - y = 44.79*x - 237.8','Gauge 4 - y = 51.79*x - 99.01', ...
    'Gauge 6 - y = 40.89*x - 136.8','Gauge 7 - y = 41.81*x - 955.8', ...
    'Gauge 8 - y = 36.53*x - 442.1'},'FontSize',11 ,'Location','northwest')
%exportgraphics(fig10, 'P1-graph10.png','Resolution',1200);
