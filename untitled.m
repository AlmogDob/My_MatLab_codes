clc; clear;
 
syms r x

eq = r+x-log(1+x)

solve(eq == 0, x)