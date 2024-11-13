clc;
clear;

a = 7833.6724;
mu = 3.986e5;

e_s = linspace(0,1,1000);
rp = a.*(1-e_s);
ra = a.*(1+e_s);
v_inf_s = linspace(1,10,5); % [km/sec]
colors = ["#0072BD","#D95319","#EDB120","#7E2F8E","#4DBEEE"];

fig1 = figure ("Name","Velocity Delta for Different V_i_n_f for Perigee and Apogee as a Function of Eccentricity",'Position',[700 250 900 500]);
hold all

count = 1;
for i = 1:length(v_inf_s)
    v_inf = v_inf_s(i);
    delta_v_rp = sqrt(2.*mu.*(1./rp - (1-e_s)./(2*rp))) - sqrt(v_inf^2+2*mu./rp);
    plot(e_s, delta_v_rp, "LineWidth", 1.5,"Color",colors(i))
    lg(count) = sprintf("rp, v_i_n_f = %g", v_inf);
    count = count+1;
    
    delta_v_ra = sqrt(2.*mu.*(1./ra - (1+e_s)./(2*ra))) - sqrt(v_inf^2+2*mu./ra);
    plot(e_s, delta_v_ra,'--', "LineWidth", 1.5,"Color",colors(i))
    lg(count) = sprintf("ra, v_i_n_f = %g", v_inf);
    count = count+1;

end

ylabel('Velocity [km/sec]')
xlabel('Eccentricity [-]')
grid on
grid minor
title("Velocity Delta for Different V_i_n_f for Perigee and Apogee as a Function of Eccentricity")
subtitle("Almog Dobrescu 214254252")
legend(lg,'FontSize',11 ,'Location','southwest')
%exportgraphics(fig1, 'grap1.png','Resolution',1200);