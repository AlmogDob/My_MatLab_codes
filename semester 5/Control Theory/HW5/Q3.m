%% Q3.1.
clc;
close all

num_of_iterations = 200;
mp_max = 0.16;
mp_min = 0.14;
ts_max = 1.6;
ts_min = 1.4;
M_p = linspace(mp_min, mp_max*3, num_of_iterations);
ts_1p = linspace(ts_min/2, ts_max*3, num_of_iterations);

c_s = {};

p = 4*tf([1 8],[1 10])*tf([1 12],[1 1 1.25]);
for i = 1:num_of_iterations
    zeta = (abs(log(M_p(i)))) / sqrt(pi^2 + (abs(log(M_p(i)))^2));
    omega_n = (log(1/0.01)) / (zeta * ts_1p(i));
    c = design_PD((p), [complex(-zeta*omega_n,omega_n * sqrt(1-zeta^2)), complex(-zeta*omega_n,-omega_n * sqrt(1-zeta^2))]);
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
            break
        end
    end

    zeta = (abs(log(M_p(num_of_iterations - i + 1)))) / sqrt(pi^2 + (abs(log(M_p(num_of_iterations - i + 1)))^2));
    omega_n = (log(1/0.01)) / (zeta * ts_1p(i));
    c = design_PD((p), [complex(-zeta*omega_n,omega_n * sqrt(1-zeta^2)), complex(-zeta*omega_n,-omega_n * sqrt(1-zeta^2))]);
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
            break
        end
    end
    i
end
fig1 = figure(1);
step(sys);
% stepinfo(sys,"SettlingTimeThreshold", 0.01)
%exportgraphics(fig1, '3.1grap1.png','Resolution',1200);

%%
p = tf(0.1492,[0.01061 0.0342 0]);
c11 = design_PD(p,[complex(-5.4, 7.2)])
