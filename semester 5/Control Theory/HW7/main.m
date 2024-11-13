clc;
s = tf('s')
plant = (s+4)/(s-5);

nyquist(plant)  