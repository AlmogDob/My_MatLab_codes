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
 17     
zeta = (abs(log(M_p(i)))) / sqrt(pi^2 + (abs(log(M_p
 (i)))^2));
 18     
omega_n = (log(1/0.01)) / (zeta * ts_1p(i));
 19     
c = design_PD((p), [complex(-zeta*omega_n,omega_n * 
sqrt(1-zeta^2)), complex(-zeta*omega_n,-omega_n * sqrt(1
zeta^2))]);
 20     
c_s{end + 1} = c;
 21     
22     
23     
sys = c*p / (1+c*p);
 info = stepinfo(sys,"SettlingTimeThreshold", 0.01);
 if (info.Overshoot > mp_min*100) && (info.Overshoot < 
mp_max*100)
 24         
if (info.SettlingTime > ts_min) && (info.
 SettlingTime < ts_max)
 25             
zeta
 26             
27             
28             
29             
30             
omega_n
 c
 info
 disp("succes");
 break
19/02/2418:34 C:\Users\גומלא...\Q3.m 2 of 2
 31         end
 32     end
 33 
34     zeta = (abs(log(M_p(num_of_iterations - i + 1)))) / 
sqrt(pi^2 + (abs(log(M_p(num_of_iterations - i + 1)))^2));
 35     omega_n = (log(1/0.01)) / (zeta * ts_1p(i));
 36     c = design_PD((p), [complex(-zeta*omega_n,omega_n * 
sqrt(1-zeta^2)), complex(-zeta*omega_n,-omega_n * sqrt(1
zeta^2))]);
 37     c_s{end + 1} = c;
 38     sys = c*p / (1+c*p);
 39     info = stepinfo(sys,"SettlingTimeThreshold", 0.01);
 40     if (info.Overshoot > mp_min*100) && (info.Overshoot < 
mp_max*100)
 41         if (info.SettlingTime > ts_min) && (info.
 SettlingTime < ts_max)
 42             zeta
 43             omega_n
 44             c
 45             info
 46             disp("succes");
 47             break
 48         end
 49     end
 50     i
 51 end
 52 fig1 = figure(1);
 53 step(sys);
 54 % stepinfo(sys,"SettlingTimeThreshold", 0.01)
 55 %exportgraphics(fig1, '3.1grap1.png','Resolution',1200)