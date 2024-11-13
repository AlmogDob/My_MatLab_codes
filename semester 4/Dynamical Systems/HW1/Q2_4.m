clc;
clear;
close;
syms A B C D E F
% A = [1 0 1 0 0;1 1 10 1 0; 21 9 37 7 1; 71 27 60 16 4; 54 27 36 12 4]
% B = [0;0;1;11;28]
% sol = linsolve(A,B)
equ5 = B+F ==0;
equ4 = A+C == 0;
equ3 = B+D == 0;
equ2 = 2*A+E+C == 0;
equ1 = 2*B+F+D == 2;
equ0 = A+E ==0;
[M1,M2] = equationsToMatrix ([equ5, equ4, equ3, equ2, equ1, equ0], [A, B, C, D, E, F])
sol = linsolve (M1,M2)