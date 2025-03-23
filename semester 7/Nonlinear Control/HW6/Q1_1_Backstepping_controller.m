function [u] = Q1_1_Backstepping_controller(x1,x2)
    z = x2 + 2 * x1 .* (1 + x1.^2);
    u = -2 * x1 .* (1 + x1.^2) - 2 * (1 + 3 * x1.^2) .* (-x1 + z ./ (1 + x1.^2)) - x1 ./ (1 + x1.^2);
end

