function [C] = design_PD(p,poles)
%DESIGN_PD Summary of this function goes here
%   Detailed explanation goes here

p_polse = pole(p);
[p_zeros, gain] = zero(p);

syms a

sum_of_all_phases = atan2(imag(gain), real(gain));
for i = 1:length(p_polse)
   sum_of_all_phases = sum_of_all_phases - atan2(imag(poles(1) - p_polse(i)), real(poles(1) - p_polse(i)));
end

for i = 1:length(p_zeros)
   sum_of_all_phases = sum_of_all_phases + atan2(imag(poles(1) - p_zeros(i)), real(poles(1) - p_zeros(i)));
end


a_ = real(double(solve(atan2(imag(poles(1)), real(poles(1) + a)) + sum_of_all_phases == -pi)));


magnitude_of_zeors = abs(poles(1) + a_);
for i = 1:length(p_zeros)
   magnitude_of_zeors = magnitude_of_zeors * abs(poles(1) - p_zeros(i));
end

magnitude_of_poles = 1;
for i = 1:length(p_polse)
   magnitude_of_poles = magnitude_of_poles * abs(poles(1) - p_polse(i));
end

k_ = magnitude_of_poles / magnitude_of_zeors;

C = tf([k_ k_*a_],1);

end

