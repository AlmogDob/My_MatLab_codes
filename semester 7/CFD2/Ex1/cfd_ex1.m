clc; clear; close all;

methods = ["Roe_first", "Roe_second", "MacCormack", "Beam_and_Warming"];
limiters = ["no_limiter", "van_Albada", "superbee", "van_Leer", "minmod"];

%% 1.3 - first
method = methods(1);
u0 = 1;
u1 = 0.0;
CFLs = 0.1:0.1:1.2;
mu = 0.0;
delta_time = 0;
theta = 0;
w = 0.0;

fig1 = figure ('Name', "1",'Position',[100 250 900 600]);
hold all
colors = parula(length(CFLs))*0.9;
leg = cell(0,0);
for index = 1:length(CFLs)
    CFL = CFLs(end - index + 1);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 0.5)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",1, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , method = %s", ellapsed_time, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , method = %s . limiter = %s", ellapsed_time, method, limiter),Interpreter="none")
        end
    else
        subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
    end
    leg{index} = sprintf("CFL=%g",CFL);
end
plot(x(2:end-1), linspace(1,mata_data.u1,length(x(2:end-1))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of CFL number on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")
grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig1, 'grap1.png','Resolution',600);

%% 1.3 - second no limiter
method = methods(2);
limiter = limiters(1);
u0 = 1;
u1 = 0.5;
CFLs = 0.1:0.1:1.2;
mu = 0.0;
delta_time = 0;
theta = 0;
w = 0.0;

fig2 = figure ('Name', "2",'Position',[250 250 900 600]);
hold all
colors = parula(length(CFLs))*0.9;
leg = cell(0,0);
for index = 1:length(CFLs)
    CFL = CFLs(end - index + 1);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (CFL < 1)
            if (ellapsed_time >= 0.3)
                break
            end
        else
            if (ellapsed_time >= 0.1)
                break
            end
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",1, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , method = %s", ellapsed_time, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , method = %s . limiter = %s", ellapsed_time, method, limiter),Interpreter="none")
        end
    else
        subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
    end
    leg{index} = sprintf("CFL=%g",CFL);
end
plot(x(2:end-1), linspace(1,mata_data.u1,length(x(2:end-1))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of CFL number on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")
ylim([0.4, 1.2])
grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig2, 'grap2.png','Resolution',600);

%% 1.3 - second van Albada
method = methods(2);
limiter = limiters(2);
u0 = 1;
u1 = 0.5;
CFLs = 0.1:0.1:1.2;
mu = 0.0;
delta_time = 0;
theta = 0;
w = 0.0;

fig3 = figure ('Name', "3",'Position',[400 250 900 600]);
hold all
colors = parula(length(CFLs))*0.9;
leg = cell(0,0);
for index = 1:length(CFLs)
    CFL = CFLs(end - index + 1);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 0.3)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",1, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , method = %s", ellapsed_time, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , method = %s . limiter = %s", ellapsed_time, method, limiter),Interpreter="none")
        end
    else
        subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
    end
    leg{index} = sprintf("CFL=%g",CFL);
end
plot(x(2:end-1), linspace(1,mata_data.u1,length(x(2:end-1))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of CFL number on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")
ylim([0.4, 1.2])
grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig3, 'grap3.png','Resolution',300);

%% 1.3 - second superbee
method = methods(2);
limiter = limiters(3);
u0 = 1;
u1 = 0.5;
CFLs = 0.1:0.1:1.2;
mu = 0.0;
delta_time = 0;
theta = 0;
w = 0.0;

fig4 = figure ('Name', "4",'Position',[550 250 900 600]);
hold all
colors = parula(length(CFLs))*0.9;
leg = cell(0,0);
for index = 1:length(CFLs)
    CFL = CFLs(end - index + 1);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 0.3)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",1, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , method = %s", ellapsed_time, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , method = %s . limiter = %s", ellapsed_time, method, limiter),Interpreter="none")
        end
    else
        subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
    end
    leg{index} = sprintf("CFL=%g",CFL);
end
plot(x(2:end-1), linspace(1,mata_data.u1,length(x(2:end-1))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of CFL number on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")
ylim([0.4, 1.2])
grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig4, 'grap4.png','Resolution',300);

%% 1.3 - second van_Leer
method = methods(2);
limiter = limiters(4);
u0 = 1;
u1 = 0.5;
CFLs = 0.1:0.1:1.2;
mu = 0.0;
delta_time = 0;
theta = 0;
w = 0.0;

fig5 = figure ('Name', "5",'Position',[700 250 900 600]);
hold all
colors = parula(length(CFLs))*0.9;
leg = cell(0,0);
for index = 1:length(CFLs)
    CFL = CFLs(end - index + 1);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 0.3)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",1, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , method = %s", ellapsed_time, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , method = %s . limiter = %s", ellapsed_time, method, limiter),Interpreter="none")
        end
    else
        subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
    end
    leg{index} = sprintf("CFL=%g",CFL);
end
plot(x(2:end-1), linspace(1,mata_data.u1,length(x(2:end-1))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of CFL number on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")
ylim([0.4, 1.2])
grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig5, 'grap5.png','Resolution',300);

%% 1.3 - second minmod
method = methods(2);
limiter = limiters(5);
u0 = 1;
u1 = 0.5;
CFLs = 0.1:0.1:1.2;
mu = 0.0;
delta_time = 0;
theta = 0;
w = 0.0;

fig6 = figure ('Name', "6",'Position',[100 100 900 600]);
hold all
colors = parula(length(CFLs))*0.9;
leg = cell(0,0);
for index = 1:length(CFLs)
    CFL = CFLs(end - index + 1);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 0.3)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",1, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , method = %s", ellapsed_time, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , method = %s . limiter = %s", ellapsed_time, method, limiter),Interpreter="none")
        end
    else
        subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
    end
    leg{index} = sprintf("CFL=%g",CFL);
end
plot(x(2:end-1), linspace(1,mata_data.u1,length(x(2:end-1))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of CFL number on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")
ylim([0.4, 1.2])
grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig6, 'grap6.png','Resolution',300);

%% 1.3 - second diff limiters
method = methods(2);

u0 = 1;
u1 = 0.5;
CFL = 0.7;
mu = 0.0;
delta_time = 0;
theta = 0;
w = 0.0;

fig7 = figure ('Name', "7",'Position',[250 100 900 600]);
hold all
colors = parula(length(limiters))*0.85;
leg = cell(0,0);
for index = 1:length(limiters)
    limiter = limiters(index);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 0.3)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",1, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s", ellapsed_time, CFL, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s", ellapsed_time, CFL, method),Interpreter="none")
        end
    else
        subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
    end
    leg{index} = sprintf("limiter=%s",limiter);
end
plot(x(2:end-1), linspace(1,mata_data.u1,length(x(2:end-1))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of limiter on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")
ylim([0.4, 1.2])
grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","no")
% exportgraphics(fig7, 'grap7.png','Resolution',300);

%% 2.4 - first mu 0.25
method = methods(1);

u0 = 0;
u1 = 1;
CFL = 0;
b = -1;
c = 0.5;
mu = 0.25;
delta_times = [1, 0.75, 0.5];
theta = 0;
w = 0.0;

fig8 = figure ('Name', "8",'Position',[400 100 900 600]);
hold all
colors = parula(length(delta_times))*0.85;
leg = cell(0,0);
for index = 1:length(delta_times)
    delta_time = delta_times(index);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 18)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",(6-index*2*2.5/length(delta_times)+2*delta_time)/1.5, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s", ellapsed_time, CFL, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s . limiter = %s", ellapsed_time, CFL, method, limiter),Interpreter="none")
        end
    else
        subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
    end
    leg{index} = sprintf("$\\Delta t=$%g",delta_time);
end
plot(x(2:end-1), -c/b*(1+tanh(c*(x(2:end-1)-(mata_data.x_max - mata_data.x_min)/2)./(2*mata_data.mu))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of time step on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")

grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig8, 'grap8.png','Resolution',300);

%% 2.4 - first mu 0.001
method = methods(1);

u0 = 0;
u1 = 1;
CFL = 0;
b = -1;
c = 0.5;
mu = 0.001;
delta_times = [1, 0.75, 0.5];
theta = 0;
w = 0.0;

fig9 = figure ('Name', "9",'Position',[550 100 900 600]);
hold all
colors = parula(length(delta_times))*0.85;
leg = cell(0,0);
for index = 1:length(delta_times)
    delta_time = delta_times(index);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 18)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",(6-index*2*2.5/length(delta_times)+2*delta_time)/1.5, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s", ellapsed_time, CFL, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s . limiter = %s", ellapsed_time, CFL, method, limiter),Interpreter="none")
        end
    else
        subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
    end
    leg{index} = sprintf("$\\Delta t=$%g",delta_time);
end
plot(x(2:end-1), -c/b*(1+tanh(c*(x(2:end-1)-(mata_data.x_max - mata_data.x_min)/2)./(2*mata_data.mu))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of time step on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")

grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig9, 'grap9.png','Resolution',300);

%% 2.4 - MacCormack mu 0.25
method = methods(3);

u0 = 0;
u1 = 1;
CFL = 0;
b = -1;
c = 0.5;
mu = 0.25;
delta_times = [1, 0.75, 0.5];
theta = 0;
w = 0.0;

fig10 = figure ('Name', "10",'Position',[700 100 900 600]);
hold all
colors = parula(length(delta_times))*0.85;
leg = cell(0,0);
for index = 1:length(delta_times)
    delta_time = delta_times(index);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 18)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",(6-index*2*2.5/length(delta_times)+2*delta_time)/1.5, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s", ellapsed_time, CFL, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s . limiter = %s", ellapsed_time, CFL, method, limiter),Interpreter="none")
        end
    else
        subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
    end
    leg{index} = sprintf("$\\Delta t=$%g",delta_time);
end
plot(x(2:end-1), -c/b*(1+tanh(c*(x(2:end-1)-(mata_data.x_max - mata_data.x_min)/2)./(2*mata_data.mu))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of time step on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")

grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig10, 'grap10.png','Resolution',300);

%% 2.4 - MacCormack mu 0.001
method = methods(3);

u0 = 0;
u1 = 1;
CFL = 0;
b = -1;
c = 0.5;
mu = 0.001;
delta_times = [1, 0.75, 0.5];
theta = 0;
w = 0.0;

fig11 = figure ('Name', "11",'Position',[100 0 900 600]);
hold all
colors = parula(length(delta_times))*0.85;
leg = cell(0,0);
for index = 1:length(delta_times)
    delta_time = delta_times(index);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 18)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",(6-index*2*2.5/length(delta_times)+2*delta_time)/1.5, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s", ellapsed_time, CFL, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s . limiter = %s", ellapsed_time, CFL, method, limiter),Interpreter="none")
        end
    else
        subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
    end
    leg{index} = sprintf("$\\Delta t=$%g",delta_time);
end
plot(x(2:end-1), -c/b*(1+tanh(c*(x(2:end-1)-(mata_data.x_max - mata_data.x_min)/2)./(2*mata_data.mu))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of time step on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")

grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig11, 'grap11.png','Resolution',300);

%% 2.4 - Beam and Warming first mu 0.25
method = methods(4);

u0 = 0;
u1 = 1;
CFL = 0;
b = -1;
c = 0.5;
mu = 0.25;
delta_times = [1, 0.75, 0.5];
theta = 1;
w = 0.5;

fig12 = figure ('Name', "12",'Position',[250 0 900 600]);
hold all
colors = parula(length(delta_times))*0.85;
leg = cell(0,0);
for index = 1:length(delta_times)
    delta_time = delta_times(index);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 18)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",(6-index*2*2.5/length(delta_times)+2*delta_time)/1.5, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s", ellapsed_time, CFL, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s . limiter = %s", ellapsed_time, CFL, method, limiter),Interpreter="none")
        end
    else
        if mata_data.theta == 0
            subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , mu = %g , theta = %g , method = %s", ellapsed_time, mata_data.mu, mata_data.theta, method),Interpreter="none")
        end
    end
    leg{index} = sprintf("$\\Delta t=$%g",delta_time);
end
plot(x(2:end-1), -c/b*(1+tanh(c*(x(2:end-1)-(mata_data.x_max - mata_data.x_min)/2)./(2*mata_data.mu))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of time step on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")

grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig12, 'grap12.png','Resolution',300);

%% 2.4 - Beam and Warming first mu 0.001
method = methods(4);

u0 = 0;
u1 = 1;
CFL = 0;
b = -1;
c = 0.5;
mu = 0.001;
delta_times = [1, 0.75, 0.5];
theta = 1;
w = 0.5;

fig13 = figure ('Name', "13",'Position',[400 0 900 600]);
hold all
colors = parula(length(delta_times))*0.85;
leg = cell(0,0);
for index = 1:length(delta_times)
    delta_time = delta_times(index);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 18)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",(6-index*2*2.5/length(delta_times)+2*delta_time)/1.5, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s", ellapsed_time, CFL, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s . limiter = %s", ellapsed_time, CFL, method, limiter),Interpreter="none")
        end
    else
        if mata_data.theta == 0
            subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , mu = %g , theta = %g , method = %s", ellapsed_time, mata_data.mu, mata_data.theta, method),Interpreter="none")
        end
    end
    leg{index} = sprintf("$\\Delta t=$%g",delta_time);
end
plot(x(2:end-1), -c/b*(1+tanh(c*(x(2:end-1)-(mata_data.x_max - mata_data.x_min)/2)./(2*mata_data.mu))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of time step on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")

grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig13, 'grap13.png','Resolution',300);

%% 2.4 - Beam and Warming second mu 0.25
method = methods(4);

u0 = 0;
u1 = 1;
CFL = 0;
b = -1;
c = 0.5;
mu = 0.25;
delta_times = [1, 0.75, 0.5];
theta = 0.5;
w = 0.5;

fig14 = figure ('Name', "14",'Position',[550 0 900 600]);
hold all
colors = parula(length(delta_times))*0.85;
leg = cell(0,0);
for index = 1:length(delta_times)
    delta_time = delta_times(index);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 18)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",(6-index*2*2.5/length(delta_times)+2*delta_time)/1.5, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s", ellapsed_time, CFL, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s . limiter = %s", ellapsed_time, CFL, method, limiter),Interpreter="none")
        end
    else
        if mata_data.theta == 0
            subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , mu = %g , theta = %g , method = %s", ellapsed_time, mata_data.mu, mata_data.theta, method),Interpreter="none")
        end
    end
    leg{index} = sprintf("$\\Delta t=$%g",delta_time);
end
plot(x(2:end-1), -c/b*(1+tanh(c*(x(2:end-1)-(mata_data.x_max - mata_data.x_min)/2)./(2*mata_data.mu))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of time step on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")

grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig14, 'grap14.png','Resolution',300);

%% 2.4 - Beam and Warming second mu 0.001
method = methods(4);

u0 = 0;
u1 = 1;
CFL = 0;
b = -1;
c = 0.5;
mu = 0.001;
delta_times = [1, 0.75, 0.5];
theta = 0.5;
w = 0.5;

fig15 = figure ('Name', "15",'Position',[700 0 900 600]);
hold all
colors = parula(length(delta_times))*0.85;
leg = cell(0,0);
for index = 1:length(delta_times)
    delta_time = delta_times(index);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 18)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",(6-index*2*2.5/length(delta_times)+2*delta_time)/1.5, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s", ellapsed_time, CFL, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s . limiter = %s", ellapsed_time, CFL, method, limiter),Interpreter="none")
        end
    else
        if mata_data.theta == 0
            subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , mu = %g , theta = %g , method = %s", ellapsed_time, mata_data.mu, mata_data.theta, method),Interpreter="none")
        end
    end
    leg{index} = sprintf("$\\Delta t=$%g",delta_time);
end
plot(x(2:end-1), -c/b*(1+tanh(c*(x(2:end-1)-(mata_data.x_max - mata_data.x_min)/2)./(2*mata_data.mu))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of time step on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")

grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig15, 'grap15.png','Resolution',300);

%% 2.4 - Beam and Warming first mu 0.001 diff w
method = methods(4);

u0 = 0;
u1 = 1;
CFL = 0;
b = -1;
c = 0.5;
mu = 0.001;
delta_time = 1;
theta = 1;
ws = 0:0.1:1;

fig16 = figure ('Name', "16",'Position',[100 300 900 600]);
hold all
colors = parula(length(ws))*0.85;
leg = cell(0,0);
for index = 1:length(ws)
    w = ws(index);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 18)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",1, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s", ellapsed_time, CFL, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s . limiter = %s", ellapsed_time, CFL, method, limiter),Interpreter="none")
        end
    else
        if mata_data.theta == 0
            subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , mu = %g , theta = %g , method = %s", ellapsed_time, mata_data.mu, mata_data.theta, method),Interpreter="none")
        end
    end
    leg{index} = sprintf("w=%g",w);
end
plot(x(2:end-1), -c/b*(1+tanh(c*(x(2:end-1)-(mata_data.x_max - mata_data.x_min)/2)./(2*mata_data.mu))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of time step on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")

grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig16, 'grap16.png','Resolution',300);

%% 2.4 - Beam and Warming second mu 0.001 diff w
method = methods(4);

u0 = 0;
u1 = 1;
CFL = 0;
b = -1;
c = 0.5;
mu = 0.001;
delta_time = 1;
theta = 0.5;
ws = 0:0.1:1;

fig17 = figure ('Name', "17",'Position',[250 300 900 600]);
hold all
colors = parula(length(ws))*0.85;
leg = cell(0,0);
for index = 1:length(ws)
    w = ws(index);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 18)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",1, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s", ellapsed_time, CFL, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s . limiter = %s", ellapsed_time, CFL, method, limiter),Interpreter="none")
        end
    else
        if mata_data.theta == 0
            subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , mu = %g , theta = %g , method = %s", ellapsed_time, mata_data.mu, mata_data.theta, method),Interpreter="none")
        end
    end
    leg{index} = sprintf("w=%g",w);
end
plot(x(2:end-1), -c/b*(1+tanh(c*(x(2:end-1)-(mata_data.x_max - mata_data.x_min)/2)./(2*mata_data.mu))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of time step on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")

grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig17, 'grap17.png','Resolution',300);

%% 2.4 - Beam and Warming first mu 0.001 diff w
method = methods(4);

u0 = 0;
u1 = 1;
CFL = 0;
b = -1;
c = 0.5;
mu = 0.25;
delta_time = 1;
theta = 1;
ws = 0:0.1:1;

fig18 = figure ('Name', "18",'Position',[400 300 900 600]);
hold all
colors = parula(length(ws))*0.85;
leg = cell(0,0);
for index = 1:length(ws)
    w = ws(index);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 18)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",1, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s", ellapsed_time, CFL, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s . limiter = %s", ellapsed_time, CFL, method, limiter),Interpreter="none")
        end
    else
        if mata_data.theta == 0
            subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , mu = %g , theta = %g , method = %s", ellapsed_time, mata_data.mu, mata_data.theta, method),Interpreter="none")
        end
    end
    leg{index} = sprintf("w=%g",w);
end
plot(x(2:end-1), -c/b*(1+tanh(c*(x(2:end-1)-(mata_data.x_max - mata_data.x_min)/2)./(2*mata_data.mu))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of time step on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")

grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig18, 'grap18.png','Resolution',300);

%% 2.4 - Beam and Warming second mu 0.001 diff w
method = methods(4);

u0 = 0;
u1 = 1;
CFL = 0;
b = -1;
c = 0.5;
mu = 0.25;
delta_time = 1;
theta = 0.5;
ws = 0:0.1:1;

fig19 = figure ('Name', "19",'Position',[550 300 900 600]);
hold all
colors = parula(length(ws))*0.85;
leg = cell(0,0);
for index = 1:length(ws)
    w = ws(index);
    [x, data, mata_data, data_of_iter] = read_data(method, u0, u1, mu, limiter, CFL, delta_time, theta, w);
    ellapsed_time = 0;
    for i = 1:2:length(data(2:end,1)) 
        ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
        if (ellapsed_time >= 18)
            break
        end
    end

    plot(x, [(data(i,1)+data(i,2))/2,data(i,2:end-1),(data(i,end-1)+data(i,end))/2], "LineWidth",1, "Color",colors(index,:));

    if mata_data.mu == 0
        if mata_data.method == "Roe_first"
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s", ellapsed_time, CFL, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , CFL = %g , method = %s . limiter = %s", ellapsed_time, CFL, method, limiter),Interpreter="none")
        end
    else
        if mata_data.theta == 0
            subtitle(sprintf("t = %2.1f , mu = %g , method = %s", ellapsed_time, mata_data.mu, method),Interpreter="none")
        else
            subtitle(sprintf("t = %2.1f , mu = %g , theta = %g , method = %s", ellapsed_time, mata_data.mu, mata_data.theta, method),Interpreter="none")
        end
    end
    leg{index} = sprintf("w=%g",w);
end
plot(x(2:end-1), -c/b*(1+tanh(c*(x(2:end-1)-(mata_data.x_max - mata_data.x_min)/2)./(2*mata_data.mu))),"--", "Color", "k");
leg{end+1} = "initial condition";

title("Effect of time step on the solution", "Interpreter","latex");
ylabel("u [-]")
xlabel("x [-]")

grid on
grid minor
legend(leg,'FontSize',13 ,'Location','southwest',"Interpreter","latex")
% exportgraphics(fig19, 'grap19.png','Resolution',300);


