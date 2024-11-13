clc;

kp = 2.2479;
kd = 0.4239;

c = tf([kd kp],1);
bode(c)