function [u] = Q2_controller(t, omega, x1,x2, x3)
    k1 = 1;
    k2 = 3;
    k3 = 1;
    xi1 = x1;
    xi2 = x2; 
    xi3 = 1 - 4 * x3.^2 ./ (1 + x1).^2;
    r = 0.2 * sin(omega * t);
    r_dot = 0.2 * omega * cos(omega * t);
    r_dot_dot = -0.2 * omega^2 * sin(omega * t);
    r_dot_dot_dot = -0.2 * omega^3 * cos(omega * t);
    e1 = xi1 - r;
    e2 = xi2 - r_dot;
    e3 = xi3 - r_dot_dot;
    ni = -k1 .* e1 - k2 .* e2 - k3 .* e3;
    psi = 8 .* x3 ./ (1 + x1) ./ (3 * x1 + 5) .* (3 .* x2 .* x3 ./ (1 + x1) + x3);
    gamma = -8 .* x3 ./ (1 + x1) ./ (3 * x1 + 5);

    u = 1 ./ gamma .* (r_dot_dot_dot -psi + ni);
end

