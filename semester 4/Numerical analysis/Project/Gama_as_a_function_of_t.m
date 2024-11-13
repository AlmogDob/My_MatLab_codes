function [gama] = Gama_as_a_function_of_t(t)
global t_90 gama_end beta Gama_Const

if (t <= t_90) | (Gama_Const == true)
    gama = 90;
else
    gama = (90-gama_end)*exp((-beta)*(t-t_90)) + gama_end;
end