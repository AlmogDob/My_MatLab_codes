function [u] = Q1_2_Backstepping_controller(x1,x2)
    y1 = x1;
    y2 = x2 + 2;
    z = y2 + y1.^2;
    u = 4 * y1.^2 - 2 * y1 .*z;
end

