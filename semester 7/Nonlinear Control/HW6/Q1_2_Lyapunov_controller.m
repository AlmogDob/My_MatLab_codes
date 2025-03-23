function [u] = Q1_2_Lyapunov_controller(x1,x2)
    y1 = x1;
    y2 = x2 + 2;
    d_v_dx1 = 0.5 * (4 * y1.^3 + 4 * y2 .* y1 + 2 * y1);
    d_v_dx2 = 0.5 * (2 * y1.^2 + 2 * y2);
    f1 = y2 - 1 + (1 - y1).^2;
    f2 = -y1;
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

