clc
close all
clear
%% data
L = 0.5;
M_inf = 1.9;
Pb_second_part = 2.77;

gamma = 1.4; %do not change unless you left earth

%% a & b
if M_inf > 1
    sup_flag = 1;
else
    sup_flag = 0;
    error('I never tried subsonic flow, If you do, please tell Gal to activating me')
end
if sup_flag
    [~, ~, ~, ~, ~, ~, fanno] = flowfanno(gamma, M_inf);
    if fanno <= L
        shock_flag = 1;
        [M_i_s2, ~, ~, ~, ~, ~, ~] = flowfanno(gamma, L, 'fannosub');
        [M_i_s, ~, ~, ~, ~, ~, ~] = flownormalshock(gamma, M_i_s2, 'down');
    else
        shock_flag = 0;
    end
end
if shock_flag
    if M_inf <= M_i_s
        shock_in = 0;
        M_out_max = 1;
        [M_in_max, ~, ~, ~, ~, ~, ~] = flowfanno(gamma, L, 'fannosub');
        [~, ~, ~, ~, ~, P0, ~] = flowfanno(gamma, L, 'fannosub');
    else
        M_out_max = 1;
        M_in_max = M_inf;
        shock_in = 1;
    end
else
    M_in_max = M_inf;
    [M_out_max, ~, ~, ~, ~, ~, ~] = flowfanno(gamma, fanno-L, 'fannosup');
end
a = M_out_max;
b = M_in_max;

%% c
[~ , ~, Pa_P0 , ~, ~] = flowisentropic(gamma, M_inf);
if shock_flag == 1 && shock_in == 0 %shock wave before
    [~ , ~, Pb_P0e , ~, ~] = flowisentropic(gamma, M_out_max);
    [~ , ~, Pa_P0 , ~, ~] = flowisentropic(gamma, M_inf);
    [~,~,~,~,~,P0_shock,~] = flownormalshock(gamma, M_inf);
    Pe_max = Pb_P0e*P0_shock/(P0*Pa_P0);
elseif ~shock_flag || (shock_flag == 1 && shock_in == 1) %shock wave inside or without shock wave
    [~,~,~,~,down,P0_shock,~] = flownormalshock(gamma, M_inf);
    [~, ~, ~, ~, ~, ~, fanno] = flowfanno(gamma, down);
    M_out = flowfanno(gamma, fanno-L, 'fannosub');
    [~ , ~, Pb_P0e , ~, ~] = flowisentropic(gamma, M_out);
    P0e_P0i = find_P0e_P0i(fanno, L, 'sub');
    Pe_max = Pb_P0e*P0e_P0i*P0_shock/(Pa_P0);
end
c = Pe_max;
%% d
if sup_flag == 0
    shock_flag = 0;
elseif shock_flag == 0 || shock_in == 1 %shock wave inside
     [~,~,~,~,M_after_shock1,P0_shock1,~] = flownormalshock(gamma, M_inf);
     [~, ~, ~, ~, ~, ~, fanno1] = flowfanno(gamma, M_after_shock1);
     if fanno1 <= L
        M_out_max1 = 1;
        [M_in_max1, ~, ~, ~, ~, ~, ~] = flowfanno(gamma, L, 'fannosub');
        [~, ~, ~, ~, ~, P01, ~] = flowfanno(gamma, L, 'fannosub');
    else
        M_in_max1 = M_after_shock1;
        [~ , ~, ~ , ~, area1] = flowisentropic(gamma, M_in_max1);
        f_M_in_max1 = 1/area1;
        [~, ~, ~, ~, ~, P01, ~] = flowfanno(gamma, L, 'fannosub');
        f_M_out_max1 = f_M_in_max1*P01;
        [M_out_max1 , ~, ~ , ~, ~] = flowisentropic(gamma, 1/f_M_out_max1, 'sub');
     end
     [~ , ~, Pb_P0e1 , ~, ~] = flowisentropic(gamma, M_out_max1);
     [~ , ~, Pa_P01 , ~, ~] = flowisentropic(gamma, M_inf);
     Pe_max1 = Pb_P0e1*P0_shock1/(P01*Pa_P01);
     if Pb_second_part > Pe_max1
         shock_flag = 1;
     else
         shock_flag = 0;
     end
end
d = shock_flag;
%% e
if shock_flag || shock_in
    Pe = Pb_second_part;
    metoam_flag = 1;
else
    if Pb_second_part >= Pe_max
        Pe = Pb_second_part;
        metoam_flag = 1;
    else
        Pe = Pb_P0e/(P0*Pa_P0);
        metoam_flag = 0;
    end
end
e = Pe;

%% f - iterative gusses for Mi and Me
M_chocked = flowfanno(gamma, L, 'fannosub');
M = linspace(0.1, M_chocked, 1000);
    [~, ~, ~, ~, ~, ~, fanno] = flowfanno(gamma, M);
    P0e_P0i = find_P0e_P0i(fanno, L, 'sub');
    if shock_flag
        [~,~,~,~,~,P0_shock,~] = flownormalshock(gamma, M_inf);
        Pe_P0 = Pb_second_part*Pa_P0./(P0_shock*P0e_P0i);
        for i =1:length(Pe_P0)
            if Pe_P0(i) > 1
                Pe_P0(i) = 0.99;
            end
        end
        [Me , ~, ~ , ~, ~] = flowisentropic(gamma, Pe_P0, 'pres');
    else
        Pe_P0 = Pb_second_part*Pa_P0./(P0e_P0i);
        [Me , ~, ~ , ~, ~] = flowisentropic(gamma, Pe_P0, 'pres');
    end
    [~ , ~, ~ , ~, area] = flowisentropic(gamma, Me);
    f_M_out = 1./area;
    f_M_in = f_M_out.*P0e_P0i;
    for i = 1:length(f_M_in)
        if f_M_in(i) >= 1
            f_M_in(i) = 0.999;
        end
        [Minn , ~, ~ , ~, ~] = flowisentropic(gamma, 1/f_M_in(i), 'sub');
        Min(i) = Minn;
    end
    [check, index] = min(abs(Min-M));
    M_in = Min(index);
    M_out = Me(index);
    f = M_out;
    g = M_in;
     
%% print
disp(['question 1: ', num2str(a)])
disp(['question 2: ', num2str(b)])
disp(['question 3: ', num2str(c)])
disp(['question 4: ', num2str(d)])
disp(['question 5: ', num2str(e)])
disp(['question 6: ', num2str(f)])
disp(['question 7: ', num2str(g)])
%%
function P0e_P0i = find_P0e_P0i(fanno, L, type)
    gamma=1.4;
    if type == "sup"
        [~, ~, ~, ~, ~, P01, ~] = flowfanno(gamma, fanno, 'fannosub');
        [~, ~, ~, ~, ~, P02, ~] = flowfanno(gamma, fanno-L, 'fannosub');
        P0e_P0i = P02/P01;
    else
        for i = 1:length(fanno)
            fan = fanno(i);
            [~, ~, ~, ~, ~, P01, ~] = flowfanno(gamma, fan, 'fannosub');
            [~, ~, ~, ~, ~, P02, ~] = flowfanno(gamma, abs(fan-L), 'fannosub');
            P0e_P0i(i) = P02/P01;
        end
    end
end

