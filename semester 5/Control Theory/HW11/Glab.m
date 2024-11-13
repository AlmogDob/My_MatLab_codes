clc, clear
s = tf('s');
K = 115.8;
Ti = 1/0.9186;
Td = 0.1633;
C = K*(1 + Td*s + 1/Ti/s)
H = 1/(s+1)/(s+3)/(s+5); % HW06
GCL_c = feedback(C*H,1)
figure(1)
hold all
step(GCL_c)
grid on
figure(2)
hold all
bode(C*H)
grid on
for Ts = [0.01 0.05 0.1]
 [b,a] = PID_backward(K,Td,Ti,Ts)
 Cd = tf(b,a,Ts)
 Hd = c2d(H,Ts,'zoh');
 GCL_d = feedback(Cd*Hd,1);
 figure(1)
 step(GCL_d)
 figure(2)
 bode(Cd*Hd)
end
figure(1)
legend('continuous','Ts = 0.01 [s]','Ts = 0.05 [s]','Ts = 0.1 [s]')
figure(2)
legend('continuous','Ts = 0.01 [s]','Ts = 0.05 [s]','Ts = 0.1 [s]')
function [b,a] = PID_backward(K,Td,Ti,T)
 b(1) = K*(1 + T/Ti + Td/T);
 b(2) = -K*(1 + 2*Td/T);
 b(3) = K*(Td/T);
 a = [1 -1 0];
end