function [C] = design_PI(p,poles)
%DESIGN_PD Summary of this function goes here
%   Detailed explanation goes here

p_polse = pole(p);
[p_zeros, gain] = zero(p);


sum_of_all_phases = atan2(imag(gain), real(gain)) - atan2(imag(poles(1)), real(poles(1)));
for i = 1:length(p_polse)
   sum_of_all_phases = sum_of_all_phases - atan2(imag(poles(1) - p_polse(i)), real(poles(1) - p_polse(i)));
end

for i = 1:length(p_zeros)
   sum_of_all_phases = sum_of_all_phases + atan2(imag(poles(1) - p_zeros(i)), real(poles(1) - p_zeros(i)));
end
% sum_of_all_phases
% poles(1)
a_ = imag(poles(1))/tan(-pi-sum_of_all_phases) - real(poles(1));


magnitude_of_zeors = abs(poles(1) + a_);
for i = 1:length(p_zeros)
   magnitude_of_zeors = magnitude_of_zeors * abs(poles(1) - p_zeros(i));
end

magnitude_of_poles = abs(poles(1));
for i = 1:length(p_polse)
   magnitude_of_poles = magnitude_of_poles * abs(poles(1) - p_polse(i));
end
% magnitude_of_poles
% magnitude_of_zeors

k_ = magnitude_of_poles / (gain*magnitude_of_zeors);

C = k_*tf([1 a_],[1 0]);

end

