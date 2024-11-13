%% Q2.a
clear; clc; close all;

dirs = {'AL - 0.xlsx', 'AL - 1.xlsx', 'AL - 2.xlsx'}

fig1 = figure ("Name","T_c as a Function of O/F ratio",'Position',[100 300 900 500]);
hold on;

for indexs = 1:length(dirs)
    data = readtable(dirs{indexs});
    T_c = data.t;
    o_to_f = linspace(5, 10, length(T_c));   
    
    plot(o_to_f, T_c,'LineWidth',1.5)
end

grid on
grid minor
ylabel("Tc [K]")
xlabel("O/F [-]")
title("T_c as a Function of O/F ratio")
subtitle("Almog Dobrescu 214254252")
legend({'AL - 0%', 'AL - 10%', 'AL - 20%'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig1, 'grap1.png','Resolution',1200);

%------------------------------------------------------------------------
dirs = {'AL - 0.xlsx', 'AL - 1.xlsx', 'AL - 2.xlsx'}

Mw_headers = 1e-3*[2*1.008+15.9994, 1.008+35.453, 12.0107+2*15.9994, 2*14.0087, 12.0107+15.9994, 15.9994+1.008, 35.453, 1.008*2, 15.9994*2, 2*26.9815+3*15.9994];
% Mw_headers = 1e-3*[2*1+16, 1+35.453, 12+2*16, 2*14, 12+16, 16+1, 35.453, 1*2, 16*2, 2*26.9815+3*16];
R0 = 8.314;

fig2 = figure ("Name","C* as a Function of O/F ratio",'Position',[250 300 900 500]);
hold on;

for indexs = 1:length(dirs)
    data = readtable(dirs{indexs});
    T_c = data.t;
    gamma = data.gam;
    o_to_f = linspace(5, 10, length(T_c));
    names = data.Properties.VariableNames
    species = {};
    x_i = [];
    A = data.Variables;
    count = 1;
    for n = 1:length(names)
        if names{n} ~= 't'
            if names{n} ~= "gam"
                species{count} = names{n};
                x_i(:, count) = A(:, n);
                count = count+1;
            end
        end
    end
    
    for j = 1:length(o_to_f)
        Gamma(j) = gamma(j)^0.5*(2/(gamma(j)+1))^((gamma(j)+1)/(2*(gamma(j)-1)));
        Mw_bar(j) = dot(Mw_headers(1:length(x_i(j,1:end-1))), x_i(j,1:end-1))/sum(x_i(j,1:end-1));
        C_star(j) = 1/Gamma(j)*(R0*T_c(j)/(Mw_bar(j)))^0.5;
    end


    plot(o_to_f, C_star,'LineWidth',1.5)

end

grid on
grid minor
ylabel("C* [m/sec]")
xlabel("O/F [-]")
title("C* as a Function of O/F ratio")
subtitle("Almog Dobrescu 214254252")
legend({'AL - 0%', 'AL - 10%', 'AL - 20%'},'FontSize',11 ,'Location','northeast')
% exportgraphics(fig2, 'grap2.png','Resolution',1200);

%------------------------------------------------------------------------
dirs = {'AL - 0.xlsx', 'AL - 1.xlsx', 'AL - 2.xlsx'}

Mw_headers = 1e-3*[2*1.008+15.9994, 1.008+35.453, 12.0107+2*15.9994, 2*14.0087, 12.0107+15.9994, 15.9994+1.008, 35.453, 1.008*2, 15.9994*2, 2*26.9815+3*15.9994];
% Mw_headers = 1e-3*[2*1+16, 1+35.453, 12+2*16, 2*14, 12+16, 16+1, 35.453, 1*2, 16*2, 2*26.9815+3*16];
R0 = 8.314;
Pe = 1;
Pc = 30;
g0 = 9.81;

fig3 = figure ("Name","I_s_p as a Function of O/F ratio",'Position',[400 300 900 500]);
hold on;

for indexs = 1:length(dirs)
    data = readtable(dirs{indexs});
    T_c = data.t;
    gamma = data.gam;
    o_to_f = linspace(5, 10, length(T_c));
    names = data.Properties.VariableNames;
    species = {};
    x_i = [];
    A = data.Variables;
    count = 1;
    for n = 1:length(names)
        if names{n} ~= 't'
            if names{n} ~= "gam"
                species{count} = names{n};
                x_i(:, count) = A(:, n);
                count = count+1;
            end
        end
    end
    
    for j = 1:length(o_to_f)
        Gamma(j) = gamma(j)^0.5*(2/(gamma(j)+1))^((gamma(j)+1)/(2*(gamma(j)-1)));
        Mw_bar(j) = dot(Mw_headers(1:length(x_i(j,1:end-1))), x_i(j,1:end-1))/sum(x_i(j,1:end-1));
        C_star(j) = 1/Gamma(j)*(R0*T_c(j)/(Mw_bar(j)))^0.5;
        C_F(j) = Gamma(j)*(2*gamma(j)/(gamma(j)-1)*(1-(Pe/Pc)^((gamma(j)-1)/gamma(j))))^0.5;
        Isp(j) = C_F(j)*C_star(j)/g0;
    end


    plot(o_to_f, Isp,'LineWidth',1.5)

end

grid on
grid minor
ylabel("I_s_p [sec]")
xlabel("O/F [-]")
title("I_s_p as a Function of O/F ratio")
subtitle("Almog Dobrescu 214254252")
legend({'AL - 0%', 'AL - 10%', 'AL - 20%'},'FontSize',11 ,'Location','northeast')
% exportgraphics(fig3, 'grap3.png','Resolution',1200);

%% Q2.c

fig4 = figure ("Name","X_i as a Function of O/F ratio",'Position',[550 300 900 500]);
hold all

colors = {"#0072BD", "#D95319", "#EDB120", "#7E2F8E", "#77AC30", "#4DBEEE", "#FF00FF", "#000000", "#FF0000"};

data = readtable('AL - 0.xlsx');
o_to_f = linspace(5, 10, length(T_c));
names = data.Properties.VariableNames;
species = {};
x_i = [];
A = data.Variables;
count = 1;
for n = 1:length(names)
    if names{n} ~= 't'
        if names{n} ~= "gam"
            species{count} = names{n};
            x_i(:, count) = A(:, n);
            count = count+1;
        end
    end
end
species;
for n = 1:length(species) 
    plot(o_to_f, x_i(:, n),'LineWidth',1.5, 'Color',colors{n})
    lgn{n} = species{n};
end

grid on
grid minor
ylabel("x_i [-]")
xlabel("O/F [-]")
title("x_i as a Function of O/F ratio")
subtitle("Almog Dobrescu 214254252")
legend(lgn,'FontSize',11 ,'Location','northeast')
% exportgraphics(fig4, 'grap4.png','Resolution',1200);

