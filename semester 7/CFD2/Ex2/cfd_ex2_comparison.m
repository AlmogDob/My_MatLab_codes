clc; clear; close all;

schemes = {'EXPLICIT_SW', 'IMPLICIT_SW', 'EXPLICIT_ROE'};

N      = 100;
M_inf  = 0.4;
CFL    = 0.5;

result_EXPLICIT_SW  = read_data(N, schemes{1}, M_inf, CFL);
result_IMPLICIT_SW  = read_data(N, schemes{2}, M_inf, CFL);
result_EXPLICIT_ROE = read_data(N, schemes{3}, M_inf, CFL);

fig1 = figure ('Name', '1', 'Position',[100 150 900 500]);

j = 1;
for i = 1:1:min(length(result_EXPLICIT_SW.data), length(result_IMPLICIT_SW.data))
    i
    clf(fig1);
    hold all

    plot(result_EXPLICIT_SW.x, result_EXPLICIT_SW.data{i,1}.norm_u, 'LineWidth', 1, 'Color','k')
    % plot(result_EXPLICIT_SW.x, result_EXPLICIT_SW.data{i,1}.norm_rho, 'LineWidth', 1, 'Color','b')
    % plot(result_EXPLICIT_SW.x, result_EXPLICIT_SW.data{i,1}.norm_p, 'LineWidth', 1, 'Color','r')
    plot(result_IMPLICIT_SW.x, result_IMPLICIT_SW.data{i,1}.norm_u, '--', 'LineWidth', 1, 'Color','k')
    % plot(result_IMPLICIT_SW.x, result_IMPLICIT_SW.data{i,1}.norm_rho, '--', 'LineWidth', 1, 'Color','b')
    % plot(result_IMPLICIT_SW.x, result_IMPLICIT_SW.data{i,1}.norm_p, '--', 'LineWidth', 1, 'Color','r')
    plot(result_EXPLICIT_ROE.x, result_EXPLICIT_ROE.data{i,1}.norm_u, '-.', 'LineWidth', 1, 'Color','k')
    % plot(result_EXPLICIT_ROE.x, result_EXPLICIT_ROE.data{i,1}.norm_rho, '-.', 'LineWidth', 1, 'Color','b')
    % plot(result_EXPLICIT_ROE.x, result_EXPLICIT_ROE.data{i,1}.norm_p, '-.', 'LineWidth', 1, 'Color','r')
    j = j+1;
    
    % if max(result_EXPLICIT_SW.data{i,1}.norm_p, max(result_EXPLICIT_SW.data{i,1}.norm_rho, result_EXPLICIT_ROE.data{i,1}.norm_rho)) < 3.75
    %     ylim([-1.3, 3.75])
    % end

    % ylim([-2, 2])
    % xlim([result_EXPLICIT_SW.x(1)-0.01, result_EXPLICIT_SW.x(end)+0.01])
    
    ylim([1.22, 1.42])
    xlim([0.775, 0.825])

    grid on
    grid minor

    font_size = 15;
    title(sprintf('%s + %s + %s, $N = %d$, $CFL = %g$, $Re_\\infty = %g$, $M_\\infty = %g$', result_EXPLICIT_SW.metadata.scheme{1,1}, result_IMPLICIT_SW.metadata.scheme{1,1}, result_EXPLICIT_ROE.metadata.scheme{1,1}, N, result_EXPLICIT_SW.metadata.CFL, result_EXPLICIT_SW.metadata.Re_inf, result_EXPLICIT_SW.metadata.M_inf) ,'FontSize',font_size,'Interpreter','latex')
    subtitle(sprintf('$\\tilde{t}_{exp} = %6.5f$, $\\tilde{t}_{imp} = %6.5f$, $\\tilde{t}_{roe} = %6.5f$', result_EXPLICIT_SW.iter_data.elapsed_norm_time(i), result_IMPLICIT_SW.iter_data.elapsed_norm_time(i), result_EXPLICIT_ROE.iter_data.elapsed_norm_time(i)),'Interpreter','latex')
    ylabel('ratio [-]','FontSize',font_size, "Interpreter","latex")
    xlabel('x [-]','FontSize',font_size, "Interpreter","latex")
    % legend({'EXP - Velocity ratio', 'EXP - Density ratio', 'EXP - Pressure ratio', 'IMP - Velocity ratio', 'IMP - Density ratio', 'IMP - Pressure ratio', 'ROE - Velocity ratio', 'ROE - Density ratio', 'ROE - Pressure ratio'},'FontSize',font_size-4 ,'Location','eastoutside','Interpreter','latex')
    legend({'EXP - Velocity ratio', 'IMP - Velocity ratio', 'ROE - Velocity ratio'},'FontSize',font_size-4 ,'Location','eastoutside','Interpreter','latex')
    box on

    drawnow
    input('press');
    % if (ellapsed_time >= 10)
    %     break
    % end
    % pause((result.iter_data.norm_delta_time(i))*1/1);
end
% exportgraphics(fig1, 'images/test.png','Resolution',400);