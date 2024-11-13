clc


s = tf('s');
p = 1*(s-4)/(s+0.2)/s^3
hold all
nyquist(p)
grid on