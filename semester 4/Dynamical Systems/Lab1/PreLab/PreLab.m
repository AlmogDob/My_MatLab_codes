clc;
clear;
close;
Myu_v = 6.7*10^(-5);
m = 0.04;
l = 0.35;
Myu_d = 1.3*10^(-4);
g = 9.81;
c = 10;

run_times = [20 30 50 80 100 100 100];
initial_theta = [5 10 30 60 90 135 179];
initial_theta_rad = initial_theta*(pi/180);
theta_dot_0 = 0;
thetas_Lin = cell([7 1]);
ts_Lin = cell([7 1]);
thetas_NonLin = cell([7 1]);
ts_NonLin = cell([7 1]);

for i = 1:length(initial_theta_rad)
    run_time = run_times(i);
    theta_0 = initial_theta_rad(i);
    sim("LiniarModel.slx")
    ts_Lin{i,:} = ans.x1_Liniar.time;
    thetas_Lin{i,:} = ans.x1_Liniar.signals.values;
    sim("NonLiniarModel.slx")
    ts_NonLin{i,:} = ans.x1_NonLiniar.time;
    thetas_NonLin{i,:} = ans.x1_NonLiniar.signals.values;

end

fig1 = figure('name', 'graghs');

for i = 1:length(initial_theta_rad)
    subplot(4,2,i);
    plot(ts_NonLin{i,1}, thetas_NonLin{i,1},ts_Lin{i,1}, thetas_Lin{i,1});
    xlabel('Time (sec)')
    ylabel('\theta (rad)')
    TitleLeg = "$Graph\: of\: Linearization\: and\: Non-Linear\: Models\:" + ...
        " for\: \theta_0 = " + string(initial_theta(i)) + "(^\circ) ,\:" + ...
        " \dot{\theta_0} = 0(^\circ)\: |\: (Almog\: Dobrescu,\: ID\: -\:" + ...
        " 214254252)$";
    title(TitleLeg,'Interpreter','latex');
    set(get(gca,'YLabel'),'rotation',0);
    legend('Non-Linear Model', 'Linearization Model')
end


