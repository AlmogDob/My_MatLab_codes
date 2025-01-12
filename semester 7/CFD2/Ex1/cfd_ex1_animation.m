clc; clear; close all;

order = 1;
% limiter = "van_Albada";
% limiter = "superbee";
limiter = "van_Leer";
% limiter = "minmod";
% limiter = "no_limiter";
CFL = 0.2;
u1 = -1;
if order == 1
    data = readmatrix(sprintf("results\\CFL%g\\u1_%g\\Roe_first_CFL%g\\output_u.txt",CFL,u1,CFL));
    meta_data = readtable(sprintf("results\\CFL%g\\u1_%g\\Roe_first_CFL%g\\mata_data.txt",CFL,u1,CFL));
    data_of_iter = readtable(sprintf("results\\CFL%g\\u1_%g\\Roe_first_CFL%g\\output_iter.txt",CFL,u1,CFL));
end
if order == 2
    data = readmatrix(sprintf("results\\CFL%g\\u1_%g\\Roe_second_%s_CFL%g\\output_u.txt",CFL,u1,limiter, CFL));
    meta_data = readtable(sprintf("results\\CFL%g\\u1_%g\\Roe_second_%s_CFL%g\\mata_data.txt",CFL,u1,limiter, CFL));
    data_of_iter = readtable(sprintf("results\\CFL%g\\u1_%g\\Roe_second_%s_CFL%g\\output_iter.txt",CFL,u1,limiter, CFL));
end
x = [meta_data.x_min, linspace(meta_data.x_min, meta_data.x_max, meta_data.N), meta_data.x_max];
ellapsed_time = 0;

fig1 = figure ('Position',[100 150 700 500]);
for i = 1:length(data(2:end,1)) 
    ellapsed_time = ellapsed_time + data_of_iter.delta_time(i);
    plot(x(2:end-1), linspace(1,meta_data.u1,length(x(2:end-1))), "Color","k");
    hold on
    % plot(x(2:end-1), data(i, 2:end-1), "LineWidth",2, "Color","b");
    % hold off
    plot(x, data(i, :), "LineWidth",2, "Color","b");
    hold off
    title(sprintf("t = %2.5f, iter = %d , CFL = %g , norm residual = %.10f", ellapsed_time, i, meta_data.CFL, data_of_iter.norm(i)))

    drawnow
    % input("press");
    % if (ellapsed_time >= 0.8)
    %     break
    % end
    pause((data_of_iter.delta_time(i))*1/(1));
end
%%
fig2 = figure ('Position',[100 150 700 500]);
semilogy(data_of_iter.No, data_of_iter.norm)

