function [u] = Q1_1_Feedback_controller(x1,x2)
    k1 = 1;
    k2 = 2;
    xi1 = x1;
    xi2 = x1 + x2 ./ (1 + x1.^2);
    ni = -k1 .* xi1 - k2 .* xi2;
    psi = x1 - 2 * x1.^2 .* x2 ./ (1 + x1.^2).^2 - 2 * x1 .* x2.^2 ./ (1 + x1.^2).^3;
    gamma = 1 ./ (1 + x1.^2);

    u = 1 ./ gamma .* (-psi + ni);
end

