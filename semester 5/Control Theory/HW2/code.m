clc;

t = 0:0.01:8;

fig1 = figure ("Name","Step Response of Y(s)/R(s) for Different k",'Position',[100 350 900 500]);
hold all
grid on
grid minor

stepp = 0.1;
max = 3;
min = 1;

k = max:-stepp:min;
for i = 1:((max - min)/stepp)
    h_s = tf(3*k(i), [1 2 3*k(i)]);
    [yh_s, xh_s] = step(h_s,t);
    % r = 0.9290 + k/3;
    % g = 0.6940 + k/3;
    % b = 0.1250 + k/3;
    r = k(i)/3 - k(i)/(3*1);
    g = k(i)/3 - k(i)/(3*3);
    b = k(i)/3 - k(i)/(3*4);
    c = hsv(ceil(((max-min)/stepp)*3));
    color  = sprintf("[%f %f %f]", r, g, b);
    color = c(i*2,:);
    if k(i) == min || k(i) == max
        plot (xh_s, yh_s ,'LineWidth',1,'Color',color)
    else
        plot (xh_s, yh_s ,'LineWidth',1,'Color',color, 'HandleVisibility','off')
    end
end
plot (xh_s, yh_s ,'LineWidth',1,'Color',color)
title ("Step Response of Y(s)/R(s) for Different k");
subtitle("Almog Dobrescu 214254252")
ylabel("y(t)")
xlabel("t [sec]")
grid on
grid minor
legend({sprintf("k = %g", max), sprintf("k = %g", min)},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig1, '2.4grap1.png','Resolution',1200);

