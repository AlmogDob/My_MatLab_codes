clc;

%% Q1.1. + Q1.2.
p = tf([1 5],1)*tf([1 60],1) / (tf([1 2],1)*tf([1 0.5],1)*tf([1 6],1));

p_gal = p*tf(1,[1 0]);

syms w
s = i*w;

eqn = abs((s+60)*(s+5)/(s*(s+6)*(s+2)*(s+0.5))) == 1;

wc = double(solve(eqn));

poly = [1 40.25 153 -3589 -90000];
roots(poly);

atan2(wc,6)*180/pi

poly2 = [0.1325 5.333 19.405 -3620.23 -90e3];
roots(poly2)

C_ld_1 = tf([0.5296 1],[0.07017 1 0]);

fig1 = figure ("Name","Q1.1 - Bode1",'Position',[100 350 900 500]);

bode(minreal(C_ld_1*p,1e-6))

grid on
grid minor
title("Bode Diagram  | Almog Dobrescu 214254252")
% legend({},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig1, 'Q1.1grap1.png','Resolution',1200);

poly3 = [0.0599 2.411 8.2246 -3622.8436 -90e3];
roots(poly3)

C_ld_1 = tf([0.6828 1],[0.0409 1 0]);

fig2 = figure ("Name","Q1.1 - Bode2",'Position',[250 350 900 500]);

bode(minreal(C_ld_1*p,1e-6))

grid on
grid minor
title("Bode Diagram  | Almog Dobrescu 214254252")
% legend({},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig2, 'Q1.1grap2.png','Resolution',1200);

%% Q1.3.
p = tf([1 5],1)*tf([1 60],1) / (tf([1 2],1)*tf([1 0.5],1)*tf([1 6],1));

p = minreal(C_ld_1*p,1e-6);

numeraitor = 278.6896*tf([1  3600],1)*tf([1 25],1)*tf([1 2.146225],1);
denumenator = 0.1325*tf([1 0],1)*tf([1 597.8025],1)*tf([1 36],1)*tf([1 4],1)*tf([1 0.25],1);
final = denumenator - numeraitor;
zero(final);

C_ld_2 = tf([0.2744 1],[0.0364 1]);

fig3 = figure ("Name","Q1.3 - Bode",'Position',[400 350 900 500]);

bode(minreal(C_ld_2*p,1e-6))

grid on
grid minor
title("Bode Diagram  | Almog Dobrescu 214254252")
% legend({},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig3, 'Q1.3grap1.png','Resolution',1200);

%% Q2.1.
format long
p_gal = 25*tf(1,[0.2 1 0])*tf(1,[0.005 1])

fig4 = figure ("Name","Q2.1 - Bode",'Position',[550 350 900 500]);

bode(minreal(p_gal,1e-6))

grid on
grid minor
title("Bode Diagram  | Almog Dobrescu 214254252")
legend({'p_gal'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig4, 'Q2.1grap1.png','Resolution',1200);

%% Q2.2.

[GM, PM] = margin(p_gal);
delta_PM = 1.30281*(35-PM);
alpha = double((1-sin(deg2rad(delta_PM)))/(1+sin(deg2rad(delta_PM))));

syms w
s = w;
eqnQ22 = 25^2/(s^2*(1+(0.2*s)^2)*(1+(0.005*s)^2))== alpha;
% s = i*w;
% eqnQ22 = abs(25/(0.001*s^3 + 0.205*s^2 + s)) == alpha;
solutions = double(solve(eqnQ22))

for i = 1:length(solutions)
    if imag(solutions(i)) == 0
        if real(solutions(i)) > 0
            w_bar = real(solutions(i));
        end
    end
end

tao = 1/(w_bar*sqrt(alpha));

C_ld = tf([tao 1],[tao*alpha 1])

[new_GM, new_PM] = margin(minreal(C_ld*p_gal,1e-6))

fig5 = figure ("Name","Q2.2 - Bode",'Position',[700 350 900 500]);

bode(minreal(p_gal*C_ld,1e-6))

grid on
grid minor
title("Bode Diagram  | Almog Dobrescu 214254252")
legend({'p_gal*C_ld'},'FontSize',11 ,'Location','northeast')
%exportgraphics(fig5, 'Q2.2grap1.png','Resolution',1200);