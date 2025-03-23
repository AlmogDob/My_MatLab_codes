function [u] = Q1_1_Lyapunov_controller(x1,x2)
    d_v_dx1 = 0.5 * (24 * x1.^5 + 32 * x1.^3 + 12 * x1.^2 .* x2 + 4 * x2 + 10 * x1);
    d_v_dx2 = 0.5 * (4 * x1.^3 + 4 * x1 + 2 * x2);
    f1 = x1 + x2 ./ (1 + x1.^2);
    f2 = -x2;
    g1 = 0;
    g2 = 1;

    a = d_v_dx1 .* f1 + d_v_dx2 .* f2;
    b = d_v_dx1 .* g1 + d_v_dx2 .* g2;

    if b == 0
        u = 0;
    else
        u = - (a + sqrt(a.^2 + b.^4)) ./ b;
    end
end

