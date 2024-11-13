clc;

nu = 0:0.001:2*pi;

a1 = 1;
e1 = 0;
p1 = a1 * (1 - e1^2);
r_nu1 = p1 ./ (1 + e1 .* cos(nu));

x1 = r_nu1.*cos(nu);
y1 = r_nu1.*sin(nu);

%-----------------------------------------%

a2 = 1;
e2 = 0.75;
p2 = a2 * (1 - e2^2);
r_nu2 = p2 ./ (1 + e2 .* cos(nu));

x2 = r_nu2.*cos(nu);
y2 = r_nu2.*sin(nu);

%-----------------------------------------%

a3 = -0.5;
e3 = 2;
p3 = a3 * (1 - e3^2);
r_nu3 = p3 ./ (1 + e3 .* cos(nu));

x3 = r_nu3.*cos(nu);
y3 = r_nu3.*sin(nu);


fig1 = figure ("Name","Different Pathes for Conical Cross-Section",'Position',[100 350 900 500]);
hold all
grid on
grid minor
axis equal
ylim([-2,2])

plot (x1, y1 ,'LineWidth',2,'Color',"#7E2F8E")
plot (x2, y2 ,'LineWidth',2,'Color',"#0072BD")
plot (x3, y3 ,'.','LineWidth',2,'Color',"#77AC30")

title ("Different Pathes for Conical Cross-Section");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("y(𝜈) [יחידת אורך]")
xlabel("x(𝜈) [יחידת אורך]")
grid on
grid minor
legend({'a = 1 | e = 0', 'a = 1 | e = 0.75', 'a = -0.5 | e = 2'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig1, 'grap1.png','Resolution',1200);

%------------------------------------------------------------------------%

fig2 = figure ("Name","r as a function of 𝜈",'Position',[300 350 900 500]);
hold all
grid on
grid minor
axis equal
ylim([-3,3])

plot (nu, r_nu1 ,'LineWidth',2,'Color',"#7E2F8E")
plot (nu, r_nu2 ,'LineWidth',2,'Color',"#0072BD")
plot (nu, r_nu3 ,'.','LineWidth',2,'Color',"#77AC30")

title ("r as a function of 𝜈");
subtitle("Almog Dobrescu 214254252 & Ronel Nawy 325021152")
ylabel("r(𝜈) [יחידת אורך]")
xlabel("𝜈 [rad]")
grid on
grid minor
legend({'a = 1 | e = 0', 'a = 1 | e = 0.75', 'a = -0.5 | e = 2'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig2, 'grap2.png','Resolution',1200);

input("press any key")
close('all')