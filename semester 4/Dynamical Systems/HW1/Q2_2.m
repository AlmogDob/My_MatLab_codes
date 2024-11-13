clc;
clear;
close;
syms A B C D E
% A = [1 0 1 0 0;1 1 10 1 0; 21 9 37 7 1; 71 27 60 16 4; 54 27 36 12 4]
% B = [0;0;1;11;28]
% sol = linsolve(A,B)
equ4 = A+C == 0;
equ3 = 11*A+B+10*C+D == 0;
equ2 = 9*A+6*A+6*A+3*B+6*B+9*C+24*C+4*C+7*D+E == 1;
equ1 = 35*A+36*A+18*B+9*B+36*C+24*C+16*D+4*E == 11;
equ0 = 54*A+27*B+36*C+12*D+4*E ==28;
[M1,M2] = equationsToMatrix ([equ4, equ3, equ2, equ1, equ0], [A, B, C, D, E])
sol = linsolve (M1,M2)