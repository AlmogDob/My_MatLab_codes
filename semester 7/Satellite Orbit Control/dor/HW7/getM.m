function [M]=getM(t,F,G)

fun=@(tau) expm(F*(t-tau))*(G*G')*expm(-F'*tau);
M=-integral(fun,0,t,'ArrayValued',true);