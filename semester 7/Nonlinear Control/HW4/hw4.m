clc; clear;

s = tf('s');
G1 = s/(s^2 - s + 1)

G2 = 1/(s+2)/(s+3)

G3 = 1/(s^2 + s + 1)

G4 = (1 - s)/(s + 1)^2

G5 = (s + 1)/(s + 2)^2/(s-1)

G6 = 1/(s^2 + 2*s + 5)

nyquist(G6)
axis equal
xlim([-0.4,0.4])
ylim([-0.4,0.4])
hold all 

x = 0.0546;
y = 0;
r = 0.235;
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit, "Color","r");

