function [CD] = Mach_to_CD(file,Mach)
% Converts Mach to CD for every Mach using second order interpolation

h_M = file(2,1) - file(1,1);
p = mod(Mach, h_M)/h_M;
index = 1;
for i=1:(length(file(:,1))-1)
    if (file(i,1) < Mach && file(i+1,1) > Mach)
        index = i;
    end
    if (file(i, 1) == Mach)
        index = i;
    end
end

% Forward Differences (Hefreshim Kidmiim) interpolation
if Mach < file((length(file(:,1))+1)/2,1)
    f_x = file(index, 2);
    f_x_h = file(index + 1, 2);
    f_x_2h = file(index + 2, 2);
    CD = f_x + p*(f_x_h - f_x) + ((p*(p - 1))/2)*(f_x_2h - 2*f_x_h + f_x);
else % Backward Differences (Hefreshim Ahoriim) interpolation
    f_x = file(index, 2);
    f_x_h = file(index - 1, 2);
    f_x_2h = file(index - 2, 2);
    CD = f_x + p*(f_x - f_x_h) + ((p*(p + 1))/2)*(f_x_2h - 2*f_x_h + f_x);
end
end