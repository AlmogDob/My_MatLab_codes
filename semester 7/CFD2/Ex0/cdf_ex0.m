%% part 1
clc; clear; close all;

alpha = "0";
delta_ts = ["1e-05", "1e-04", "1e-03", "2.5e-03", "5e-03", "7.5e-03", "1e-02"];
colors = cool(length(delta_ts));

fig1 = figure ("Name","Convergence history for $\alpha = 0$ for different $\Delta t$",'Position',[100 300 900 500]);

for i = 1:length(delta_ts)
    delta_t = delta_ts(i);
    path = sprintf("results/alpha-%s_dletat-%s", alpha, delta_t);
    data = readmatrix(sprintf("%s\\output_u.txt", path));
    meta_data = readtable(sprintf("%s\\mata_data.txt", path));
    iter_data = readmatrix(sprintf("%s\\output_iter.txt", path));

    loglog(iter_data(:,1)+1, iter_data(:,2), "LineWidth",1.5, "Color",colors(i,:));
    hold on
    leg{i} = sprintf("$\\Delta t=$%s",delta_t);
end
title("Convergence History for $\alpha = 0$ for different $\Delta t$", "Interpreter","latex");
ylabel("L2Norm [-]")
xlabel("num of iterations [-]")
subtitle("Almog Dobrescu 214254252")
grid on
legend(leg,'FontSize',13 ,'Location','northeast',"Interpreter","latex")
% exportgraphics(fig1, 'grap1.png','Resolution',1200);

fig2 = figure ("Name","Effect of $\Delta t$ on result for $\alpha =0$",'Position',[250 300 900 500]);

hold all
for i = 1:length(delta_ts)
    delta_t = delta_ts(i);
    path = sprintf("results/alpha-%s_dletat-%s", alpha, delta_t);
    data = readmatrix(sprintf("%s\\output_u.txt", path));
    meta_data = readtable(sprintf("%s\\mata_data.txt", path));
    iter_data = readmatrix(sprintf("%s\\output_iter.txt", path));
    y = linspace(meta_data.y_0, meta_data.y_N, meta_data.N);

    if mod(i, 2) == 0
        plot(y, data(end,:), "LineWidth",1.5,"LineStyle","--", "Color",colors(i,:));
    elseif mod(i, 3) == 0
        plot(y, data(end,:), "LineWidth",1.5,"LineStyle","-", "Color",colors(i,:));
    elseif mod(i, 4) == 0
        plot(y, data(end,:), "LineWidth",1.5,"LineStyle","-.", "Color",colors(i,:));
    else
        plot(y, data(end,:), "LineWidth",1.5,"LineStyle",":", "Color",colors(i,:));
    end
    
    leg{i} = sprintf("$\\Delta t=$%s",delta_t);
end

plot(y, linspace(0,1,length(y)),'*-',"LineWidth",0.5, "Color","k");
leg{end+1} = "Exact";

title("Effect of $\Delta t$ on result for $\alpha =0$", "Interpreter","latex");
ylabel("u [-]")
xlabel("y [m]")
ylim([-0.25,1.25])
xlim([-0.25,1.25])
subtitle("Almog Dobrescu 214254252")
grid on
legend(leg,'FontSize',13 ,'Location','southeast',"Interpreter","latex")
% exportgraphics(fig2, 'grap2.1.png','Resolution',1200);

%% part 2
clc; clear;

alpha = "0.5";
delta_ts = ["1e-4", "1e-3", "1e-2", "1e-1", "1e0", "1e1", "1e2", "1e30"];
colors = cool(length(delta_ts));

fig3 = figure ("Name","Convergence history for $\alpha = 0.5$ for different $\Delta t$",'Position',[400 300 900 500]);

for i = 1:length(delta_ts)
    delta_t = delta_ts(i);
    path = sprintf("results/alpha-%s_dletat-%s", alpha, delta_t);
    data = readmatrix(sprintf("%s\\output_u.txt", path));
    meta_data = readtable(sprintf("%s\\mata_data.txt", path));
    iter_data = readmatrix(sprintf("%s\\output_iter.txt", path));

    loglog(iter_data(:,1)+1, iter_data(:,2), "LineWidth",1.5, "Color",colors(i,:));
    hold on
    leg{i} = sprintf("$\\Delta t=$%s",delta_t);
end
title("Convergence History for $\alpha = 0.5$ for different $\Delta t$", "Interpreter","latex");
ylabel("L2Norm [-]")
xlabel("num of iterations [-]")
subtitle("Almog Dobrescu 214254252")
grid on
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig3, 'grap3.png','Resolution',1200);

fig4 = figure ("Name","Oscillation for Crank-Nicolson with $\Delta t=10$",'Position',[550 300 900 500]);

hold all

delta_t = delta_ts(end-2);
path = sprintf("results/alpha-%s_dletat-%s", alpha, delta_t);
data = readmatrix(sprintf("%s\\output_u.txt", path));
meta_data = readtable(sprintf("%s\\mata_data.txt", path));
iter_data = readmatrix(sprintf("%s\\output_iter.txt", path));
y = linspace(meta_data.y_0, meta_data.y_N, meta_data.N);

indexes = logspace(0,log10(length(data(:,1))),10)+1;
indexes(end) = indexes(end)-1;
colors = cool(length(indexes));
leg = cell(0,0);
for i = 1:length(indexes)
    index = floor(indexes(i));
    plot(y, data(index-1,:), "LineWidth",1.5,"LineStyle","-", "Color",colors(i,:));
    leg{end+1,1} = sprintf("iteration: %d",floor(indexes(i))-1);
    plot(y, data(index,:), "LineWidth",1.5,"LineStyle","-", "Color",colors(i,:));
    leg{end+1,1} = sprintf("iteration: %d",floor(indexes(i)));
end

plot(y, linspace(0,1,length(y)),'*-',"LineWidth",0.5, "Color","k");
leg{end+1,1} = "Exact";

title("Oscillation for Crank-Nicolson with $\Delta t=10$", "Interpreter","latex");
ylabel("u [-]")
xlabel("y [m]")
ylim([-1,1.25])
xlim([-0.25,1.25])
subtitle("Almog Dobrescu 214254252")
grid on
legend(leg,'FontSize',10 ,'Location','southeast',"Interpreter","latex")
% exportgraphics(fig4, 'grap4.png','Resolution',1200);

clear;

alpha = "0.5";
delta_ts = ["1e-4", "1e-3", "1e-2", "1e-1", "1e0", "1e1", "1e2", "1e30"];
colors = cool(length(delta_ts));

fig5 = figure ("Name","Effect of $\Delta t$ on result for $\alpha =0.5$",'Position',[700 300 900 500]);

hold all
for i = 1:length(delta_ts)
    delta_t = delta_ts(i);
    path = sprintf("results/alpha-%s_dletat-%s", alpha, delta_t);
    data = readmatrix(sprintf("%s\\output_u.txt", path));
    meta_data = readtable(sprintf("%s\\mata_data.txt", path));
    iter_data = readmatrix(sprintf("%s\\output_iter.txt", path));
    y = linspace(meta_data.y_0, meta_data.y_N, meta_data.N);

    if mod(i, 2) == 0
        plot(y, data(end,:), "LineWidth",1.5,"LineStyle","--", "Color",colors(i,:));
    elseif mod(i, 3) == 0
        plot(y, data(end,:), "LineWidth",1.5,"LineStyle","-.", "Color",colors(i,:));
    elseif mod(i, 4) == 0
        plot(y, data(end,:), "LineWidth",1.5,"LineStyle","-", "Color",colors(i,:));
    else
        plot(y, data(end,:), "LineWidth",1.5,"LineStyle",":", "Color",colors(i,:));
    end
    
    leg{i} = sprintf("$\\Delta t=$%s",delta_t);
end

plot(y, linspace(0,1,length(y)),'*-',"LineWidth",0.5, "Color","k");
leg{end+1} = "Exact";

title("Effect of $\Delta t$ on result for $\alpha =0.5$", "Interpreter","latex");
ylabel("u [-]")
xlabel("y [m]")
ylim([-0.25,1.25])
xlim([-0.25,1.25])
subtitle("Almog Dobrescu 214254252")
grid on
legend(leg,'FontSize',13 ,'Location','southeast',"Interpreter","latex")
% exportgraphics(fig5, 'grap5.1.png','Resolution',1200);

clear;

alpha = "0.5";
delta_ts = ["1e-4", "1e-3", "1e-2", "1e-1", "1e0", "1e1", "1e2", "1e30"];

fig6 = figure ("Name","Oscillation for Crank-Nicolson with $\Delta t=\infty$",'Position',[100 100 900 500]);

hold all

delta_t = delta_ts(end);
path = sprintf("results/alpha-%s_dletat-%s", alpha, delta_t);
data = readmatrix(sprintf("%s\\output_u.txt", path));
meta_data = readtable(sprintf("%s\\mata_data.txt", path));
iter_data = readmatrix(sprintf("%s\\output_iter.txt", path));
y = linspace(meta_data.y_0, meta_data.y_N, meta_data.N);

indexes = logspace(0,log10(length(data(:,1))),10)+1;
indexes(end) = indexes(end)-1;
colors = cool(length(indexes));
leg = cell(0,0);
for i = 1:length(indexes)
    index = floor(indexes(i));
    plot(y, data(index-1,:), "LineWidth",6-i*2*2.5/length(indexes),"LineStyle","-", "Color",colors(i,:));
    leg{end+1,1} = sprintf("iteration: %d",floor(indexes(i))-1);
    plot(y, data(index,:), "LineWidth",6-i*2*2.5/length(indexes),"LineStyle","-", "Color",colors(i,:));
    leg{end+1,1} = sprintf("iteration: %d",floor(indexes(i)));
end

plot(y, linspace(0,1,length(y)),'*-',"LineWidth",0.5, "Color","k");
leg{end+1,1} = "Exact";

title("Oscillation for Crank-Nicolson with $\Delta t=\infty$", "Interpreter","latex");
ylabel("u [-]")
xlabel("y [m]")
ylim([-1,1.25])
xlim([-0.25,1.25])
subtitle("Almog Dobrescu 214254252")
grid on
legend(leg,'FontSize',10 ,'Location','southeast',"Interpreter","latex")
% exportgraphics(fig6, 'grap6.png','Resolution',1200);

%% part 3
clear; clc;

alpha = "1";
delta_ts = ["1e-2", "1e-1", "1e0", "1e1", "1e2", "1e4", "1e10", "1e15", "1e20"];
colors = cool(length(delta_ts));

fig7 = figure ("Name","Convergence history for $\alpha = 1$ for different $\Delta t$",'Position',[250 100 900 500]);

for i = 1:length(delta_ts)
    delta_t = delta_ts(i);
    path = sprintf("results/alpha-%s_dletat-%s", alpha, delta_t);
    data = readmatrix(sprintf("%s\\output_u.txt", path));
    meta_data = readtable(sprintf("%s\\mata_data.txt", path));
    iter_data = readmatrix(sprintf("%s\\output_iter.txt", path));

    loglog(iter_data(:,1)+1, iter_data(:,2), "LineWidth",1.5, "Color",colors(i,:));
    hold on
    leg{i} = sprintf("$\\Delta t=$%s",delta_t);
end
title("Convergence History for $\alpha = 1$ for different $\Delta t$", "Interpreter","latex");
ylabel("L2Norm [-]")
xlabel("num of iterations [-]")
subtitle("Almog Dobrescu 214254252")
grid on
legend(leg,'FontSize',13 ,'Location','southeast',"Interpreter","latex")
% exportgraphics(fig7, 'grap7.png','Resolution',1200);

clear;

alpha = "1";
delta_ts = ["1e-2", "1e-1", "1e0", "1e1", "1e2", "1e4", "1e10"];
colors = cool(length(delta_ts));

fig8 = figure ("Name","Effect of $\Delta t$ on result for $\alpha =1$",'Position',[400 100 900 500]);

hold all
for i = 1:length(delta_ts)
    delta_t = delta_ts(i);
    path = sprintf("results/alpha-%s_dletat-%s", alpha, delta_t);
    data = readmatrix(sprintf("%s\\output_u.txt", path));
    meta_data = readtable(sprintf("%s\\mata_data.txt", path));
    iter_data = readmatrix(sprintf("%s\\output_iter.txt", path));
    y = linspace(meta_data.y_0, meta_data.y_N, meta_data.N);

    if mod(i, 2) == 0
        plot(y, data(end,:), "LineWidth",1.5,"LineStyle","--", "Color",colors(i,:));
    elseif mod(i, 3) == 0
        plot(y, data(end,:), "LineWidth",1.5,"LineStyle","-.", "Color",colors(i,:));
    elseif mod(i, 4) == 0
        plot(y, data(end,:), "LineWidth",1.5,"LineStyle","-", "Color",colors(i,:));
    else
        plot(y, data(end,:), "LineWidth",1.5,"LineStyle",":", "Color",colors(i,:));
    end
    
    leg{i} = sprintf("$\\Delta t=$%s",delta_t);
end

plot(y, linspace(0,1,length(y)),'*-',"LineWidth",0.5, "Color","k");
leg{end+1} = "Exact";

title("Effect of $\Delta t$ on result for $\alpha =1$", "Interpreter","latex");
ylabel("u [-]")
xlabel("y [m]")
ylim([-0.25,1.25])
xlim([-0.25,1.25])
subtitle("Almog Dobrescu 214254252")
grid on
legend(leg,'FontSize',13 ,'Location','southeast',"Interpreter","latex")
% exportgraphics(fig8, 'grap8.1.png','Resolution',1200);