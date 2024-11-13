clc;
clear;

%definig the constants and variables

gama = 1.4;
D_t = 0.039; %meters
D_e = 0.081; %meters
A_t = pi*(D_t/2)^2;
A_e = pi*(D_e/2)^2;
x_0 = 9.5;
x_n = x_0;
epsilon = 10^(-5); %convergence condition
num_of_iteretions = 0;

%defining the functions

M = 1:0.00001:5;
syms f(x)
f(x) = (1/x)*(((2)/(gama+1)*(1+((gama-1)/(2))*x^2)))^((gama+1)/(2*(gama-1)))-A_e/A_t;
der_of_f(x) = diff(f,x);
f_for_ploting = (1./M).*(((2)./(gama+1).*(1+((gama-1)/(2)).*M.^2))).^((gama+1)./(2.*(gama-1)))-A_e/A_t;

%%

%Q1.2.

%defining the method

to_stop = false;
while (not(to_stop))
    x_n_plus1 = double(x_n - (f(x_n)/der_of_f(x_n)));
    if (abs(x_n_plus1-x_n) <= epsilon)
        to_stop = true;
        break
    end
    x_n = x_n_plus1;
    if num_of_iteretions > 200
        break
    end
    num_of_iteretions = num_of_iteretions+1;
end
Me = x_n
num_of_iteretions

%%

%Q1.3.

%ploting f of x and y = 0
fig1 = figure ("Name",'plot of f of x','Position',[20 50 1500 800]);
plot(M,f_for_ploting,'LineWidth',2)
title (["Plot of f of M", "Almog Dobrescu 214254252 & Ronnel Nawy 325021152"])
xlabel('M [-]')
ylabel('f(M)')
set(gca,'XAxisLocation','origin')
set(gca,'YAxisLocation','origin')
grid on
grid minor
legend({'f(M)'},'FontSize',14 ,'Location','southeast')

%%

%Q1.4.

%reseting the constants and variables
x_n = x_0;
to_stop = false;
num_of_iteretions = 0;
epsilon_n = []; %array of every convergence condition

%runing the method while recording the valuse of epsilon as a function of
%the number of iterations
while (not(to_stop))
    x_n_plus1 = double(x_n - (f(x_n)/der_of_f(x_n)));
    if (abs(x_n_plus1-x_n) <= epsilon)
        to_stop = true;
        break
    end
    epsilon_n = [epsilon_n,[abs(x_n_plus1-x_n)]];
    x_n = x_n_plus1;
    if num_of_iteretions > 200
        break
    end
    num_of_iteretions = num_of_iteretions+1;
end

%ploting the convergence condition graph
fig2 = figure ("Name",'convergence condition graph','Position',[20 50 1500 800]);
semilogy(1:1:num_of_iteretions,epsilon_n,'LineWidth',3)
title (["Plot of Convergence Condition as a Function of the Number of Iteretion", "Almog Dobrescu 214254252 & Ronnel Nawy 325021152"])
xlabel('Num of Iteretion [-]')
ylabel('epsilon-n [-]')
set(gca,'XAxisLocation','origin')
set(gca,'YAxisLocation','origin')
grid on
grid minor
legend({'Convergence Condition'},'FontSize',14 ,'Location','southeast')
exportgraphics(fig2, 'Q1_4-graph.png','Resolution',1200); %export the fig to a png file

%%

%Q1.5.

%defining the constants and variables
epsilon_t = 0.001:0.001:1;
Me_s = zeros(1,length(epsilon_t));

%running the method for each epsilon_t
for index = 1:length(epsilon_t)
    %reseting the constants and variables
    x_n = x_0;
    to_stop = false;
    num_of_iteretions = 0;
    while (not(to_stop))
        x_n_plus1 = double(x_n - (f(x_n)/der_of_f(x_n)));
        if (abs(x_n_plus1-x_n) <= epsilon_t(index))
            to_stop = true;
            break
        end
        x_n = x_n_plus1;
        if num_of_iteretions > 200
            break
        end
        num_of_iteretions = num_of_iteretions+1;
    end
    Me_s(index) = x_n;
end

%%

%ploting the sensitivity of the convergence condition graph
fig3 = figure ("Name",'sensitivity of the convergence condition graph','Position',[20 50 1500 800]);
semilogx(epsilon_t,Me_s,'LineWidth',2)
title (["Plot of the Sensitivity of the Convergence Condition as a Function of Epsilon-t", "Almog Dobrescu 214254252 & Ronnel Nawy 325021152"])
xlabel('epsilon-t [-]')
ylabel('Me [-]')
set(gca,'XAxisLocation','origin')
set(gca,'YAxisLocation','origin')
grid on
grid minor
legend({'Me as a function of epsilon-t'},'FontSize',14 ,'Location','southeast')
exportgraphics(fig3, 'Q1_5-graph.png','Resolution',1200); %export the fig to a png file

%%

%Q1.6.

%reseting the constans and variables
x_n = x_0;
to_stop = false;
num_of_iteretions = 0;

% I will plot f again but now between 0 to 10
M = 0:0.001:10;
f_for_ploting = (1./M).*(((2)./(gama+1).*(1+((gama-1)/(2)).*M.^2))).^((gama+1)./(2.*(gama-1)))-A_e/A_t;
fig4 = figure ("Name",'plot of f of x between 0 to 10','Position',[20 50 1500 800]);
plot(M,f_for_ploting,'LineWidth',2)
title (["Plot of f of M Between 0 to 10", "Almog Dobrescu 214254252 & Ronnel Nawy 325021152"])
xlabel('M [-]')
ylabel('f(M)')
set(gca,'XAxisLocation','origin')
set(gca,'YAxisLocation','origin')
grid on
grid minor
legend({'f(M)'},'FontSize',14 ,'Location','southeast')
exportgraphics(fig4, 'Q1_6_1-graph.png','Resolution',1200); %export the fig to a png file

%%

% We can see that there is a asimptot at M equal zero, so I will start the
% graph from 0.01 so that the scale of the Y axis will be usefull

%defining the constants and variables
epsilon = 10^(-5); %convergence condition
x_0_s = 0.01:0.01:10;
Me_s = zeros(1,length(x_0_s));

%running the method for each x_0
for index = 1:length(x_0_s)
    %reseting the constants and variables
    x_n = x_0_s(index);
    to_stop = false;
    num_of_iteretions = 0;
    while (not(to_stop))
        x_n_plus1 = double(x_n - (f(x_n)/der_of_f(x_n)));
        if (abs(x_n_plus1-x_n) <= epsilon)
            to_stop = true;
            break
        end
        x_n = x_n_plus1;
        if num_of_iteretions > 200
            break
        end
        num_of_iteretions = num_of_iteretions+1;
    end
    Me_s(index) = x_n;
end

%%

%ploting the sensitivity to the initial condition graph
fig5 = figure ("Name",'plot of the sensitivity to the initial condition','Position',[20 50 1500 800]);
plot(x_0_s,Me_s,'LineWidth',2)
title (["Plot of of the Sensitivity to the Initial Condition as a Function of x-0", "Almog Dobrescu 214254252 & Ronnel Nawy 325021152"])
xlabel('x-0 [-]')
ylabel('Me [-]')
set(gca,'XAxisLocation','origin')
set(gca,'YAxisLocation','origin')
grid on
grid minor
legend({'Me(x-0)'},'FontSize',14 ,'Location','southeast')
exportgraphics(fig5, 'Q1_6_2-graph.png','Resolution',1200); %export the fig to a png file
