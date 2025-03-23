function [u] = Q1_2_Feedback_controller(x1,x2)
    y1 = x1;
    y2 = x2 + 2;
    k1 = 1;
    k2 = 1;
    xi1 = y1;
    xi2 = y2 - 1 + (1 - y1).^2;
    ni = -k1 .* xi1 - k2 .* xi2;
    psi = 2 * y1.^3 - 6 * y1.^2 + 2 * y1 .* y2 + 3 * y1 - 2 *y2;
    gamma = 1;

    u = 1 ./ gamma .* (-psi + ni);
end

