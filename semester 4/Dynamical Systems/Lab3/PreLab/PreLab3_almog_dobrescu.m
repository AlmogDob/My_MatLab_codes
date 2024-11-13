%Almog Dobrescu
clc;
format long

%Q2

%defining constants and variabels
run_time = 100;
A = 1;
w1 = logspace(-1,0,10);
w2 = logspace(0, 1.2,100);
w3 = logspace(1.2,2,10);
w = [w1  w2(2:end) w3(2:end)];
% w_for_tests = logspace(-1,2,20);
% w = w_for_tests;
index_after_zero_output = 0;
Magnitudes = zeros(1, length(w));
Phases = zeros(1, length(w));
delta_ts = zeros(1, length(w));
outputs_y = cell(length(w), 1);
outputs_t = cell(length(w), 1);
inputs_y = cell(length(w), 1);
inputs_t = cell(length(w), 1);


%runing the simulations
for i = 1:length(w)
    w_run = w(i);
    sim("DSPrelab3.slx")
    outputs_t{i,1} = Output.time;
    outputs_y{i,1} = Output.signals.values;
    inputs_t{i,1} = Input.time;
    inputs_y{i,1} = Input.signals.values;
end

%% data processing
for i = 1:length(w)
    %removing transitioin phenomenas
    outputs_t_half{i,1} = outputs_t{i,1}(length(outputs_t{i,1})/2:end);
    outputs_y_half{i,1} = outputs_y{i,1}(length(outputs_y{i,1})/2:end);
    inputs_t_half{i,1} = inputs_t{i,1}(length(inputs_t{i,1})/2:end);
    inputs_y_half{i,1} = inputs_y{i,1}(length(inputs_y{i,1})/2:end);


    %finding the magnutide after removing transitioin phenomenas
    Magnitudes(i) = max(outputs_y_half{i,1})/A;
    %finding zeros
    for j=2:length(outputs_t_half{i,1})
        y_before = outputs_y_half{i,1}(j-1);
        y_now = outputs_y_half{i,1}(j);
        if (y_now < 0 && y_before > 0)
            index_after_zero_output = j;
            break
        end
    end
    for j=2:length(outputs_t{i,1})
        y_before = inputs_y_half{i,1}(j-1);
        y_now = inputs_y_half{i,1}(j);
        if (y_now < 0 && y_before > 0)
            index_after_zero_input = j;
            break
        end
    end
    delta_ts(i) = inputs_t_half{i,1}(index_after_zero_input)-outputs_t_half{i,1}(index_after_zero_output);    
end

%% ploting the bode plots
Phases = mod(delta_ts.*w,2*pi)-2*pi;
Phases_deg = Phases*180/pi;
Magnitudes_dB = 20*log10(Magnitudes);
fig1 = figure ("Name",'Bode Plots of G(s)','Position',[800 200 900 500]);
tiledlayout(2,1);
nexttile
semilogx(w,Magnitudes_dB,'LineWidth',1.5,'Color',[0 0.4470 0.7410])
title (["Bode Plots of G(s)", "Almog Dobrescu 214254252"])
xlabel('Omega [rad/s]')
ylabel('Magnitude [dB]')
grid on
grid minor
legend({'Magnitude'},'FontSize',14 ,'Location','northeast')
nexttile
semilogx(w,Phases_deg,'LineWidth',1.5,'Color',[0 0.4470 0.7410])
xlabel('Omega [rad/s]')
ylabel('Phase [dB]')
grid on
grid minor
legend({'Phase'},'FontSize',14 ,'Location','northeast')
%exportgraphics(fig1, 'Q2_graph.png','Resolution',1200); %export the fig to a png file

%% creating the table
name_for_tabel_colloms = {'ω, [rad/sec]', '|G(jω)| [dB]', '̸arg(G(jw)) [deg]'};
Table = table(transpose(w), transpose(Magnitudes_dB), transpose(Phases_deg), 'VariableNames', name_for_tabel_colloms);

%% ploting exampel plots

fig2 = figure ("Name",'Plot of The Input and Output of The System','Position',[800 200 900 500]);
tiledlayout(4,1);
nexttile
i = 5;
hold all
semilogx(outputs_t{i,1},outputs_y{i,1},'LineWidth',1.5,'Color',[0 0.4470 0.7410])
semilogx(inputs_t{i,1},inputs_y{i,1},'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
title (["Plot of the Output and Input for Omega = " + w(i) + " [rad/s]", "Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('y(t) or u(t) [-]')
grid on
grid minor
legend({'Output','Input'},'FontSize',10 ,'Location','northeast')

nexttile
i = 40;
hold all
semilogx(outputs_t{i,1},outputs_y{i,1},'LineWidth',1.5,'Color',[0 0.4470 0.7410])
semilogx(inputs_t{i,1},inputs_y{i,1},'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
title (["Plot of the Output and Input for Omega = " + w(i) + " [rad/s]", "Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('y(t) or u(t) [-]')
grid on
grid minor
legend({'Output','Input'},'FontSize',10 ,'Location','northeast')

nexttile
i = 70;
hold all
semilogx(outputs_t{i,1},outputs_y{i,1},'LineWidth',1.5,'Color',[0 0.4470 0.7410])
semilogx(inputs_t{i,1},inputs_y{i,1},'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
title (["Plot of the Output and Input for Omega = " + w(i) + " [rad/s]", "Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('y(t) or u(t) [-]')
grid on
grid minor
legend({'Output','Input'},'FontSize',10 ,'Location','northeast')

nexttile
i = 100;
hold all
semilogx(outputs_t{i,1},outputs_y{i,1},'LineWidth',1,'Color',[0 0.4470 0.7410])
semilogx(inputs_t{i,1},inputs_y{i,1},'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
title (["Plot of the Output and Input for Omega = " + w(i) + " [rad/s]", "Almog Dobrescu 214254252"])
xlabel('t [s]')
ylabel('y(t) or u(t) [-]')
grid on
grid minor
legend({'Output','Input'},'FontSize',10 ,'Location','northeast')
%exportgraphics(fig2, 'Q2_2graph.png','Resolution',1800); %export the fig to a png file

%% Q3

%ploting the magnitude to take mesuerment
fig3 = figure ("Name",'Plot of The Magnitude of G(s)','Position',[800 200 900 500]);
semilogx(w,Magnitudes_dB,'LineWidth',1.5,'Color',[0 0.4470 0.7410])
title (["Plot of The Magnitude of G(s)", "Almog Dobrescu 214254252"])
xlabel('Omega [rad/s]')
ylabel('Magnitude [dB]')
grid on
grid minor
legend({'Magnitude'},'FontSize',14 ,'Location','northeast')
%exportgraphics(fig3, 'Q3_graph.png','Resolution',1200); %export the fig to a png file

%% Q4

%defining the constants
zeta = 0.202;
omega_n = 2.37949;
A = 1;

sys = tf(omega_n^2, [1 2*zeta*omega_n omega_n^2]);

%extracting the vectors of the plots form the bode function
[Magnitude_3d, Phase_3d, Omega] = bode(sys);

%they came out as a matrix so I will convert them to a vector
Magnitude_1d = zeros(1,length(Magnitude_3d));
Phase_1d_in_deg = zeros(1,length(Phase_3d));
for i = 1:length(Magnitude_3d)
    Magnitude_1d(i) = Magnitude_3d(1,1,i);
    Phase_1d_in_deg(i) = Phase_3d(1,1,i);
end

Magnitude_in_dB = zeros(1,length(Magnitude_3d));
for i = 1:length(Magnitude_3d)
    Magnitude_in_dB(i) = 20*log10(Magnitude_1d(i));
end
Omega_log = log10(Omega);

%ploting the bode plots of the system and simulation
fig4 = figure ("Name",'Bode Plots of Simulated and Estimated G(s)','Position',[800 200 900 500]);
tiledlayout(2,1);
nexttile
hold all
semilogx(Omega_log,Magnitude_in_dB, 'LineWidth',1.5,'Color',[0 0.4470 0.7410])
semilogx(log10(w),Magnitudes_dB,'-.','LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
title (["Bode Plots of Simulated and Estimated G(s)", "Almog Dobrescu 214254252"])
xlabel('log10(Omega) [rad/s]')
ylabel('Magnitude [dB]')
grid on
grid minor
legend({'Estimated Magnitude', 'Simulated Magnitude'},'FontSize',14 ,'Location','northeast')

nexttile
hold all
semilogx(Omega_log,Phase_1d_in_deg,'LineWidth',1.5,'Color',[0 0.4470 0.7410])
semilogx(log10(w),Phases_deg,'-.','LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
xlabel('log10(Omega) [rad/s]')
ylabel('Phase [dB]')
grid on
grid minor
legend({'Estimated Phase', 'Simulated Phase'},'FontSize',14 ,'Location','northeast')
%exportgraphics(fig4, 'Q4_graph.png','Resolution',1200); %export the fig to a png file

