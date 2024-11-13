%% Q2.a
clc; clear;

% mu = 3.986e5;
% a = 6738; 
% n = sqrt(mu/(a)^3);
syms x_wc(t) y_wc(t) z_wc(t) t x0 y0 z0 x0_dot y0_dot z0_dot n

x_wc(t) = (4-3*cos(n*t))*x0 + x0_dot/n*sin(n*t)+2/n*(1-cos(n*t))*y0_dot;
y_wc(t) = 6*((sin(n*t)-n*t))*x0 + y0 + 2/n*(cos(n*t)-1)*x0_dot + (4*sin(n*t)-3*n*t)*y0_dot/n;
z_wc(t) = z0*cos(n*t)+z0_dot/n*sin(n*t);

y0 = 0;
z0 = 0;
x0_dot = 0;
y0_dot = -2*n*x0;

x_wc(t)=simplify(subs(x_wc(t)))
y_wc(t)=simplify(subs(y_wc(t)))
z_wc(t)=simplify(subs(z_wc(t)))

d = simplify(sqrt(x_wc^2+y_wc^2+z_wc^2))

%% Q2.b.1
clc; clear;
syms x_wc(t) y_wc(t) z_wc(t) t x0 y0 z0 x0_dot y0_dot z0_dot n a

x_wc(t) = (4-3*cos(n*t))*x0 + x0_dot/n*sin(n*t)+2/n*(1-cos(n*t))*y0_dot;
y_wc(t) = 6*((sin(n*t)-n*t))*x0 + y0 + 2/n*(cos(n*t)-1)*x0_dot + (4*sin(n*t)-3*n*t)*y0_dot/n;
z_wc(t) = z0*cos(n*t)+z0_dot/n*sin(n*t);

x0 = 0.001*a;
y0 = 0;
z0 = 0;

x_wc(t)=simplify(subs(x_wc(t)));
y_wc(t)=simplify(subs(y_wc(t)));
z_wc(t)=simplify(subs(z_wc(t)));

x_wc_at_pi_over_2n = x_wc(pi/2/n);
y_wc_at_pi_over_2n = y_wc(pi/2/n);
z_wc_at_pi_over_2n = z_wc(pi/2/n);

S = solve([x_wc_at_pi_over_2n == 0,y_wc_at_pi_over_2n == 0,z_wc_at_pi_over_2n == 0],[x0_dot y0_dot z0_dot]);
simplify(S.x0_dot)
simplify(S.y0_dot)
simplify(S.z0_dot)

x_wc(t) = (4-3*cos(n*t))*x0 + x0_dot/n*sin(n*t)+2/n*(1-cos(n*t))*y0_dot;
y_wc(t) = 6*((sin(n*t)-n*t))*x0 + y0 + 2/n*(cos(n*t)-1)*x0_dot + (4*sin(n*t)-3*n*t)*y0_dot/n;
z_wc(t) = z0*cos(n*t)+z0_dot/n*sin(n*t);

x0 = 0.001*a;
y0 = 0;
z0 = 0;
x0_dot = simplify(S.x0_dot);
y0_dot = simplify(S.y0_dot);
z0_dot = simplify(S.z0_dot);

x_wc_diff = diff(x_wc,t);
y_wc_diff = diff(y_wc,t);
z_wc_diff = diff(z_wc,t);

x_wc_diff(t)=simplify(subs(x_wc_diff(t)))
y_wc_diff(t)=simplify(subs(y_wc_diff(t)))
z_wc_diff(t)=simplify(subs(z_wc_diff(t)))

x_wc_diff_at_pi_over_2n = x_wc_diff(pi/2/n)
y_wc_diff_at_pi_over_2n = y_wc_diff(pi/2/n)
z_wc_diff_at_pi_over_2n = z_wc_diff(pi/2/n)

%% Q2.b.2
clc; clear;
fig1 = figure ("Name","3D Figure of The Trajectory",'Position',[100 300 900 500]);
maximum = 200;
min = 5;
ks = linspace(min, maximum, 10);
for index = 1:length(ks)
    x_out = [];
    t_out = [];
    x = [];
    syms x_wc(t) y_wc(t) z_wc(t) t x0 y0 z0 x0_dot y0_dot z0_dot n a 
    syms x_wc_diff(t) y_wc_diff(t) z_wc_diff(t) state_space(t) k

    x_wc(t) = (4-3*cos(n*t))*x0 + x0_dot/n*sin(n*t)+2/n*(1-cos(n*t))*y0_dot;
    y_wc(t) = 6*((sin(n*t)-n*t))*x0 + y0 + 2/n*(cos(n*t)-1)*x0_dot + (4*sin(n*t)-3*n*t)*y0_dot/n;
    z_wc(t) = z0*cos(n*t)+z0_dot/n*sin(n*t);
    
    x0 = 0.001*a;
    y0 = 0;
    z0 = 0;
    
    x_wc(t)=simplify(subs(x_wc(t)));
    y_wc(t)=simplify(subs(y_wc(t)));
    z_wc(t)=simplify(subs(z_wc(t)));
    
    x_wc_at_pi_over_2n = x_wc(pi/2/n);
    y_wc_at_pi_over_2n = y_wc(pi/2/n);
    z_wc_at_pi_over_2n = z_wc(pi/2/n);
    
    S = solve([x_wc_at_pi_over_2n == 0,y_wc_at_pi_over_2n == 0,z_wc_at_pi_over_2n == 0],[x0_dot y0_dot z0_dot]);
    
    x_wc(t) = (4-3*cos(n*t))*x0 + x0_dot/n*sin(n*t)+2/n*(1-cos(n*t))*y0_dot;
    y_wc(t) = 6*((sin(n*t)-n*t))*x0 + y0 + 2/n*(cos(n*t)-1)*x0_dot + (4*sin(n*t)-3*n*t)*y0_dot/n;
    z_wc(t) = z0*cos(n*t)+z0_dot/n*sin(n*t);
    
    x_wc_diff(t) = diff(x_wc,t);
    y_wc_diff(t) = diff(y_wc,t);
    z_wc_diff(t) = diff(z_wc,t);
    
    A1 = [3*n^2 0   0;
            0   0   0;
            0   0 -n^2];
    A2 = [  0  2*n 0;
          -2*n  0  0;
            0   0  0];
    F = [zeros(3,3) eye(3,3);A1 A2];
    G = [zeros(3,3);eye(3,3)];
    
    p = k.*[-n+i*n -n-n*i -4*n+3*n*i -4*n-3*n*i -3*n+n*i -3*n-n*i];

    k = ks(index)
    mu = 3.986e5;
    RE = 6371;
    a = 450+RE;
    n = sqrt(mu/(a^3));
    
    x_wc(t)=simplify(subs(x_wc(t)));
    y_wc(t)=simplify(subs(y_wc(t)));
    z_wc(t)=simplify(subs(z_wc(t)));
    x_wc_diff(t)=simplify(subs(x_wc_diff(t)));
    y_wc_diff(t)=simplify(subs(y_wc_diff(t)));
    z_wc_diff(t)=simplify(subs(z_wc_diff(t)));
    F = double(subs(F));
    G = double(subs(G));
    p = double(subs(p));

    K = place(F, G, p);
    
    x0 = 0.001*a;
    y0 = 0;
    z0 = 0;
    x0_dot = double(subs(simplify(S.x0_dot)));
    y0_dot = double(subs(simplify(S.y0_dot)));
    z0_dot = double(subs(simplify(S.z0_dot)));
    
    x(1,:) = [x0 y0 z0 x0_dot y0_dot z0_dot];
    
    time_interval = [0 pi/2/n];
    
    % This is where we integrate the equations of motion.
    [t_out, x_out] = ode45(@(t,x)Satellite(x, F, G, K), time_interval, x(1,:), odeset('RelTol',1e-10,'AbsTol',1e-10));

    miss_distance = norm([x_out(end,1),x_out(end,2),x_out(end,3)])*1e3;
    miss_velocity = norm([x_out(end,4),x_out(end,5),x_out(end,6)])*1e3;
    
    color = "#000000";
    if (ks(index) < (maximum+min)/2)
        disp("hi")
        color = "#7E2F8E";
    end
    plot3(x_out(:,1),x_out(:,2),x_out(:,3), "LineWidth", 2, "Color", color)
    hold all
    plot3(x_out(1,1),x_out(1,2),x_out(1,3),"diamond", "LineWidth", 2, "Color", "#000000")
    plot3(x_out(end,1),x_out(end,2),x_out(end,3),"diamond", "LineWidth", 6, "Color", "#0000FF")
    plot3(0,0,0,"hexagram", "LineWidth", 2, "Color", "#FF0000")
    
end

xlabel('X [km]')
ylabel('Y [km]')
zlabel('Z [km]')
grid on
grid minor
title(sprintf("3D Figure of The Trajectory for k = %d | miss dis = %.5g[m] | miss val = %.5g[m/sec]", k, miss_distance, miss_velocity))
subtitle("Almog Dobrescu 214254252")
legend({'The Trajectory','Initial Point','Final Point','Locatioin of The Station'},'FontSize',11 ,'Location','southeast')
%exportgraphics(fig1, 'grap1.png','Resolution',1200);
%%
fig2 = figure ("Name","The Relative Position Components as a Function of Time",'Position',[250 300 900 500]);
hold all

plot(t_out,x_out(:,1), "LineWidth", 2, "Color", "#7E2F8E")
plot(t_out,x_out(:,2), "LineWidth", 2, "Color", "#0072BD")
plot(t_out,x_out(:,3), "LineWidth", 2, "Color", "#A2142F")

xlabel('Time [sec]')
ylabel('Magnitude [km]')

grid on
grid minor
title(sprintf("The Relative Position Components as a Function of Time for k = %d", k))
subtitle("Almog Dobrescu 214254252")
legend({'x','y','z'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig2, 'grap2.png','Resolution',1200);

%%
fig3 = figure ("Name","The Relative Velocity Components as a Function of Time",'Position',[400 300 900 500]);
hold all

plot(t_out,x_out(:,4), "LineWidth", 2, "Color", "#7E2F8E")
plot(t_out,x_out(:,5), "LineWidth", 2, "Color", "#0072BD")
plot(t_out,x_out(:,6), "LineWidth", 2, "Color", "#A2142F")

xlabel('Time [sec]')
ylabel('Magnitude [km/sec]')

grid on
grid minor
title(sprintf("The Relative Velocity Components as a Function of Time for k = %d", k))
subtitle("Almog Dobrescu 214254252")
legend({'x dot','y dot','z dot'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig3, 'grap3.png','Resolution',1200);

%% Q2.b.bonus
clc; clear;
fig4 = figure ("Name","delta v for diffrent k",'Position',[550 300 900 500]);
maximum = 1000;
min = 1;
ks = linspace(min, maximum, 20);
for index = 1:length(ks)
    x_out = [];
    t_out = [];
    x = [];
    syms x_wc(t) y_wc(t) z_wc(t) t x0 y0 z0 x0_dot y0_dot z0_dot n a 
    syms x_wc_diff(t) y_wc_diff(t) z_wc_diff(t) state_space(t) k

    x_wc(t) = (4-3*cos(n*t))*x0 + x0_dot/n*sin(n*t)+2/n*(1-cos(n*t))*y0_dot;
    y_wc(t) = 6*((sin(n*t)-n*t))*x0 + y0 + 2/n*(cos(n*t)-1)*x0_dot + (4*sin(n*t)-3*n*t)*y0_dot/n;
    z_wc(t) = z0*cos(n*t)+z0_dot/n*sin(n*t);
    
    x0 = 0.001*a;
    y0 = 0;
    z0 = 0;
    
    x_wc(t)=simplify(subs(x_wc(t)));
    y_wc(t)=simplify(subs(y_wc(t)));
    z_wc(t)=simplify(subs(z_wc(t)));
    
    x_wc_at_pi_over_2n = x_wc(pi/2/n);
    y_wc_at_pi_over_2n = y_wc(pi/2/n);
    z_wc_at_pi_over_2n = z_wc(pi/2/n);
    
    S = solve([x_wc_at_pi_over_2n == 0,y_wc_at_pi_over_2n == 0,z_wc_at_pi_over_2n == 0],[x0_dot y0_dot z0_dot]);
    
    x_wc(t) = (4-3*cos(n*t))*x0 + x0_dot/n*sin(n*t)+2/n*(1-cos(n*t))*y0_dot;
    y_wc(t) = 6*((sin(n*t)-n*t))*x0 + y0 + 2/n*(cos(n*t)-1)*x0_dot + (4*sin(n*t)-3*n*t)*y0_dot/n;
    z_wc(t) = z0*cos(n*t)+z0_dot/n*sin(n*t);
    
    x_wc_diff(t) = diff(x_wc,t);
    y_wc_diff(t) = diff(y_wc,t);
    z_wc_diff(t) = diff(z_wc,t);
    
    A1 = [3*n^2 0   0;
            0   0   0;
            0   0 -n^2];
    A2 = [  0  2*n 0;
          -2*n  0  0;
            0   0  0];
    F = [zeros(3,3) eye(3,3);A1 A2];
    G = [zeros(3,3);eye(3,3)];
    
    p = k.*[-n+i*n -n-n*i -4*n+3*n*i -4*n-3*n*i -3*n+n*i -3*n-n*i];

    k = ks(index)
    mu = 3.986e5;
    RE = 6371;
    a = 450+RE;
    n = sqrt(mu/(a^3));
    
    x_wc(t)=simplify(subs(x_wc(t)));
    y_wc(t)=simplify(subs(y_wc(t)));
    z_wc(t)=simplify(subs(z_wc(t)));
    x_wc_diff(t)=simplify(subs(x_wc_diff(t)));
    y_wc_diff(t)=simplify(subs(y_wc_diff(t)));
    z_wc_diff(t)=simplify(subs(z_wc_diff(t)));
    F = double(subs(F));
    G = double(subs(G));
    p = double(subs(p));

    K = place(F, G, p);
    
    x0 = 0.001*a;
    y0 = 0;
    z0 = 0;
    x0_dot = double(subs(simplify(S.x0_dot)));
    y0_dot = double(subs(simplify(S.y0_dot)));
    z0_dot = double(subs(simplify(S.z0_dot)));
    
    x(1,:) = [x0 y0 z0 x0_dot y0_dot z0_dot];
    
    time_interval = [0 pi/2/n];
    
    % This is where we integrate the equations of motion.
    [t_out, x_out] = ode45(@(t,x)Satellite(x, F, G, K), time_interval, x(1,:), odeset('RelTol',1e-10,'AbsTol',1e-10));
    
    u{index,1} = -K*transpose(x_out);
    magnitude = [];
    for iteration = 1:length(u{index,1}(1,:))
        magnitude(iteration) = norm(u{index,1}(:,iteration));
    end
    delta_v(index) = trapz(t_out,magnitude);

    miss_distance = norm([x_out(end,1),x_out(end,2),x_out(end,3)])*1e3;
    miss_velocity = norm([x_out(end,4),x_out(end,5),x_out(end,6)])*1e3;

    plot(ks(1:length(delta_v)), delta_v)
    drawnow
    
end
xlabel('k[-]')
ylabel('delta v [km/sec]')
grid on
grid minor
title(sprintf("delta v for k = [%d, %d]", min, maximum))
subtitle("Almog Dobrescu 214254252")
%exportgraphics(fig4, 'grap4.png','Resolution',1200);