%% data
T0_change = 25; % T0 change in [%]
M_inf = 2;

gamma = 1.4; %do not change unless you left earth

T0_increase = 1/(1+T0_change/100);
clc
%% a & b
if M_inf > 1
    sup_flag = 1;
else
    sup_flag = 0;
    error('I never tried subsonic flow, If you do, please tell Gal to activating me')
end
if sup_flag
    [~, ~, ~, ~, ~, T0, ~] = flowrayleigh(gamma, M_inf);
    if T0 >= T0_increase
        shock_flag = 1;
        [M_i_s2, ~, ~, ~, ~, ~, ~] = flowrayleigh(gamma, T0_increase, 'totaltsub');
        [M_i_s, ~, ~, ~, ~, ~, ~] = flownormalshock(gamma, M_i_s2, 'down');
    else
        shock_flag = 0;
    end
end
if shock_flag
    if M_inf <= M_i_s
        shock_in = 0;
        M_out_max = 1;
        [M_in_max, ~, ~, ~, ~, ~, ~] = flowrayleigh(gamma, T0_increase, 'totaltsub');
        [~, ~, ~, ~, ~, ~, P0] = flowrayleigh(gamma, T0_increase, 'totaltsub');
    else
        M_out_max = 1;
        M_in_max = M_inf;
        shock_in = 1;
    end
else
    shock_in = 0;
    M_in_max = M_inf;
    [M_out_max, ~, ~, ~, ~, ~, ~] = flowrayleigh(gamma, T0/T0_increase, 'totaltsup');
end
b = M_out_max;
a = M_in_max;
%% c
[~ , ~, Pa_P0 , ~, ~] = flowisentropic(gamma, M_inf);
if shock_flag == 1 && shock_in == 0 %shock wave before
    [~ , ~, Pb_P0e , ~, ~] = flowisentropic(gamma, M_out_max);
    [~ , ~, Pa_P0 , ~, ~] = flowisentropic(gamma, M_inf);
    [~,~,~,~,~,P0_shock,~] = flownormalshock(gamma, M_inf);
    Pe_max = Pb_P0e*P0_shock/(P0*Pa_P0);
elseif ~shock_flag || (shock_flag == 1 && shock_in == 1) %shock wave inside or without shock wave
    [~,~,~,~,down,P0_shock,~] = flownormalshock(gamma, M_inf);
    [~, ~, ~, ~, ~, ray, ~] = flowrayleigh(gamma, down);
    M_out = flowrayleigh(gamma, (ray/T0_increase), 'totaltsub');
    [~ , ~, Pb_P0e , ~, ~] = flowisentropic(gamma, M_out);
    P0e_P0i = find_P0e_P0i(ray, T0_increase, 'sup');
    Pe_max = Pb_P0e*P0e_P0i*P0_shock/(Pa_P0);
end
c = Pe_max;

%% d
d = 0;

%% e
[~ , ~, ~ , ~, area1] = flowisentropic(gamma, M_in_max);
A_min = 1/area1;
e = A_min;


%% print
disp(['question 1: ', num2str(a)])
disp(['question 2: ', num2str(b)])
disp(['question 3: ', num2str(c)])
disp(['question 4: ', num2str(d)])
disp(['question 5: ', num2str(e)])

%%
function P0e_P0i = find_P0e_P0i(fanno, L, type)
    gamma=1.4;
    if type == "sup"
        [~, ~, ~, ~, ~, ~, P01] = flowrayleigh(gamma, fanno, 'totaltsub');
        [~, ~, ~, ~, ~, ~, P02] = flowrayleigh(gamma, (fanno/L), 'totaltsub');
        P0e_P0i = P02/P01;
    else
        for i = 1:length(fanno)
            fan = fanno(i);
            [~, ~, ~, ~, ~, ~, P01] = flowrayleigh(gamma, fan, 'totaltsup');
            [~, ~, ~, ~, ~, ~, P02] = flowrayleigh(gamma, (fan/L), 'totaltsup');
            P0e_P0i(i) = P02/P01;
        end
    end
end

