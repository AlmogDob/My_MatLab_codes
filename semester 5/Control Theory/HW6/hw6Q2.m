clc;

p = 4*(tf([1 8],1)*tf([1 2],1))/ (tf([1 4],1)*tf([1 2 3.25],1));

% zeta = 0.52;
% omega_n = 30;
% c = design_PI(p,[complex(-zeta*omega_n,omega_n * sqrt(1-zeta^2)),complex(-zeta*omega_n,-omega_n * sqrt(1-zeta^2))])

num_of_iterations = 100;
mp_max = 0.16;
mp_min = 0.14;
ts_max = 0.35;
ts_min = 0.25;
M_p = linspace(mp_min*1e-8, mp_max*1e1, num_of_iterations);
ts_1p = linspace(ts_min*1e-8, ts_max*1e1, num_of_iterations);

c_s = {};
to_break = 0;
p = 4*(tf([1 8],1)*tf([1 2],1))/ (tf([1 4],1)*tf([1 2 3.25],1));
for i = 1:num_of_iterations
    for j = 1:num_of_iterations
        zeta = (abs(log(M_p(i)))) / sqrt(pi^2 + (abs(log(M_p(i)))^2));
        omega_n = (log(1/0.01)) / (zeta * ts_1p(j));
        c = design_PI((p), [complex(-zeta*omega_n,omega_n * sqrt(1-zeta^2)), complex(-zeta*omega_n,-omega_n * sqrt(1-zeta^2))]);
        c_s{end + 1} = c;
        sys = c*p / (1+c*p);
        info = stepinfo(sys,"SettlingTimeThreshold", 0.01);
        if (info.Overshoot > mp_min*100) && (info.Overshoot < mp_max*100)
            if (info.SettlingTime > ts_min) && (info.SettlingTime < ts_max)
                zeta
                omega_n
                c
                info
                disp("succes");
                to_break = 1;
                break
            end
        end
        disp(sprintf("j = %d, i = %d",j,i));
    end
    if to_break
            break
        end
    disp(sprintf("i = %d",i));
end

%%

time = 0:0.01:1;
[y,t] = step(sys,time);
info = stepinfo(sys)

fig1 = figure ("Name","Step Response of the Closed-Loop System with the PI Controller",'Position',[100 300 900 500]);
hold all
grid on
grid minor

plot(t, y, 'LineWidth',2,'Color',"#0072BD")

title ("Step Response of the Closed-Loop System with the PI Controller");
subtitle("Almog Dobrescu 214254252");
% legend({''},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig1, '2.3grap1.png','Resolution',1200);

%%
time = 0:0.01:20;
ramp = 1*time;
y_ramp = lsim(sys,ramp,time);

for i = 1:length(time)
    error_y(i) = y_ramp(i) - ramp(i);
    i;
end

fig2 = figure ("Name","Error to Unit Ramp Input of the Closed-Loop System with the PI Controller",'Position',[100 300 900 500]);
hold all
grid on
grid minor

plot(time, error_y, 'LineWidth',2,'Color',"#0072BD")

title ("Error to Unit Ramp Input of the Closed-Loop System with the PI Controller");
subtitle("Almog Dobrescu 214254252");
% legend({''},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig2, '2.3grap2.png','Resolution',1200);

