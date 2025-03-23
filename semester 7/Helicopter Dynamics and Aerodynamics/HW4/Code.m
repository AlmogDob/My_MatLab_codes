clc; clear; close all;

Helicopter_Parameters

%% Q1 - Natural modes in hover with Ixz=0
Ic = eye(3,3);

stability_and_control_deriv_matrix = calc_stability_and_control_deriv_hover(1);
Eq_matrix = stability_and_control_deriv_matrix_to_Eq_matrix(stability_and_control_deriv_matrix, Ic);
[E_Vec, E] = eig(Eq_matrix);
E = E*ones(8, 1)
E_Vec = complex_to_mag_and_angle(E_Vec)

fig1 = figure('Name','1','Position',[100 300 900 500]);
colors = cool(2);
plot(E,'o', 'LineWidth', 2, 'Color', colors(2,:))
grid on
xlabel('Re')
ylabel('Im')
xline(0);
yline(0);
grid on
grid minor
title('Q1 - Natural modes in hover with Ixz=0')
% exportgraphics(fig1, 'graph1.png','Resolution',300);



%% Q2 - Natural modes in hover with true Ixz
I_diag = [Ix_bar 0 0; 0 Iy_bar 0; 0 0 Iz_bar];
I_full = [Ix_bar 0 -Ixz_bar; 0 Iy_bar 0; -Ixz_bar 0 Iz_bar];
Ic = I_diag/I_full;

stability_and_control_deriv_matrix = calc_stability_and_control_deriv_hover(2);
Eq_matrix = stability_and_control_deriv_matrix_to_Eq_matrix(stability_and_control_deriv_matrix, Ic);
[E_Vec_true, E_true] = eig(Eq_matrix);
E_true = E_true*ones(8, 1)
E_Vec_true = complex_to_mag_and_angle(E_Vec_true)

Ic = eye(3,3);

stability_and_control_deriv_matrix = calc_stability_and_control_deriv_hover(1);
Eq_matrix = stability_and_control_deriv_matrix_to_Eq_matrix(stability_and_control_deriv_matrix, Ic);
E_zero = eig(Eq_matrix);
[E_Vec_zero, E_zero] = eig(Eq_matrix);
E_zero = E_zero*ones(8, 1);


fig2 = figure('Name','2','Position',[250 300 900 500]);
colors = cool(2);
hold all

plot(E_true,'o', 'LineWidth', 2, 'Color', colors(2,:))
plot(E_zero,'^', 'LineWidth', 2, 'Color', colors(1,:))

grid on
xlabel('Re')
ylabel('Im')
xline(0);
yline(0);
grid on
grid minor
title('Q2 - Natural modes in hover with true Ixz')
legend({'true Ixz', 'zero Ixz'}, 'FontSize',11,'Location','northwest')
% exportgraphics(fig2, 'graph2.png','Resolution',300);

%% Q3 - Natural modes in hover with seperation between lateral, longitudinal, and heave
Ic = eye(3,3);

stability_and_control_deriv_matrix = calc_stability_and_control_deriv_hover(3);
Eq_matrix = stability_and_control_deriv_matrix_to_Eq_matrix(stability_and_control_deriv_matrix, Ic);
[E_Vec_tot, E_tot] = eig(Eq_matrix);
E_tot = E_tot*ones(8, 1);
E_Vec_tot = complex_to_mag_and_angle(E_Vec_tot);

Lateral_Eq_matrix = [Eq_matrix(2,:);Eq_matrix(4,:);Eq_matrix(6,:);Eq_matrix(7,:)];
Lateral_Eq_matrix = [Lateral_Eq_matrix(:,2),Lateral_Eq_matrix(:,4),Lateral_Eq_matrix(:,6),Lateral_Eq_matrix(:,7)];
[E_Vec_lat, E_lat] = eig(Lateral_Eq_matrix);
E_lat = E_lat*ones(4, 1)
E_Vec_lat = complex_to_mag_and_angle(E_Vec_lat)

longitudinal_Eq_matrix = [Eq_matrix(1,:);Eq_matrix(5,:);Eq_matrix(8,:)];
longitudinal_Eq_matrix = [longitudinal_Eq_matrix(:,1),longitudinal_Eq_matrix(:,5),longitudinal_Eq_matrix(:,8)];
[E_Vec_long, E_long] = eig(longitudinal_Eq_matrix);
E_long = E_long*ones(3, 1)
E_Vec_long = complex_to_mag_and_angle(E_Vec_long)

heave_Eq_matrix = [Eq_matrix(3,:)];
heave_Eq_matrix = [heave_Eq_matrix(:,3)];
[E_Vec_heave, E_heave] = eig(heave_Eq_matrix);
E_heave = E_heave
E_Vec_heave = complex_to_mag_and_angle(E_Vec_heave)

fig3 = figure('Name','3','Position',[400 300 900 500]);
colors = cool(3);
hold all

plot(E_tot,'o', 'LineWidth', 2, 'Color', 'k')
plot(E_lat,'square', 'LineWidth', 4, 'Color', colors(1,:))
plot(E_long,'^', 'LineWidth', 4, 'Color', colors(2,:))
plot(complex(E_heave,0),'x', 'LineWidth', 4, 'Color', colors(3,:))

grid on
xlabel('Re')
ylabel('Im')
xline(0);
yline(0);
grid on
grid minor
title('Q3 - Natural modes in hover with seperation between lateral, longitudinal, and heave')
legend({'full', 'lateral', 'longitudinal', 'heave'}, 'FontSize',11,'Location','northwest')
% exportgraphics(fig3, 'graph3.png','Resolution',300);

%% Q4 - Natural modes in hover with no offset and twice the offset
Ic = eye(3,3);

stability_and_control_deriv_matrix = calc_stability_and_control_deriv_hover(4);
Eq_matrix = stability_and_control_deriv_matrix_to_Eq_matrix(stability_and_control_deriv_matrix, Ic);
[E_Vec_normal_offset, E_normal_offset] = eig(Eq_matrix);
E_normal_offset = E_normal_offset*ones(8, 1)
E_Vec_normal_offset = complex_to_mag_and_angle(E_Vec_normal_offset)

stability_and_control_deriv_matrix = calc_stability_and_control_deriv_hover(4.1);
Eq_matrix = stability_and_control_deriv_matrix_to_Eq_matrix(stability_and_control_deriv_matrix, Ic);
[E_Vec_no_offset, E_no_offset] = eig(Eq_matrix);
E_no_offset = E_no_offset*ones(8, 1)
E_Vec_no_offset = complex_to_mag_and_angle(E_Vec_no_offset)

stability_and_control_deriv_matrix = calc_stability_and_control_deriv_hover(4.2);
Eq_matrix = stability_and_control_deriv_matrix_to_Eq_matrix(stability_and_control_deriv_matrix, Ic);
[E_Vec_twice_offset, E_twice_offset] = eig(Eq_matrix);
E_twice_offset = E_twice_offset*ones(8, 1)
E_Vec_twice_offset = complex_to_mag_and_angle(E_Vec_twice_offset)

fig4 = figure('Name','4','Position',[550 300 900 500]);
colors = cool(3)*.9;
hold all

plot(E_no_offset,'square', 'LineWidth', 3, 'Color', colors(1,:))
plot(E_normal_offset,'o', 'LineWidth', 2, 'Color', colors(2,:))
plot(E_twice_offset,'^', 'LineWidth', 1, 'Color', colors(3,:))

grid on
xlabel('Re')
ylabel('Im')
xline(0);
yline(0);
grid on
grid minor
title('Q4 - Natural modes in hover with no offset and twice the offset')
legend({'no offset', 'normal', 'twice offset'}, 'FontSize',11,'Location','northwest')
% exportgraphics(fig4, 'graph4.png','Resolution',300);

%% Q5 - Natural modes in hover with tail rotor at CG level
Ic = eye(3,3);

stability_and_control_deriv_matrix = calc_stability_and_control_deriv_hover(1);
Eq_matrix = stability_and_control_deriv_matrix_to_Eq_matrix(stability_and_control_deriv_matrix, Ic);
[E_Vec_normal_offset, E_normal_offset] = eig(Eq_matrix);
E_normal_offset = E_normal_offset*ones(8, 1)
E_Vec_normal_offset = complex_to_mag_and_angle(E_Vec_normal_offset)

stability_and_control_deriv_matrix = calc_stability_and_control_deriv_hover(5);
Eq_matrix = stability_and_control_deriv_matrix_to_Eq_matrix(stability_and_control_deriv_matrix, Ic);
[E_Vec_low_tail_offset, E_low_tail_offset] = eig(Eq_matrix);
E_low_tail_offset = E_low_tail_offset*ones(8, 1)
E_Vec_low_tail_offset = complex_to_mag_and_angle(E_Vec_low_tail_offset)

fig5 = figure('Name','5','Position',[700 300 900 500]);
colors = cool(3)*.9;
hold all

plot(E_normal_offset,'o', 'LineWidth', 3, 'Color', colors(2,:))
plot(E_low_tail_offset,'^', 'LineWidth', 1.5, 'Color', colors(1,:))

grid on
xlabel('Re')
ylabel('Im')
xline(0);
yline(0);
grid on
grid minor
title('Q5 - Natural modes in hover with tail rotor at CG level')
legend({'normal', 'tail rotor at CG level'}, 'FontSize',11,'Location','northwest')
% exportgraphics(fig5, 'graph5.png','Resolution',300);


% exportgraphics(fig5, 'graph5.png','Resolution',300);exportgraphics(fig4, 'graph4.png','Resolution',300);exportgraphics(fig3, 'graph3.png','Resolution',300);exportgraphics(fig2, 'graph2.png','Resolution',300);exportgraphics(fig1, 'graph1.png','Resolution',300);
