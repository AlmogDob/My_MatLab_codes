clc
clear
close all

%% data
Ae_to_At = 1.8;
Ai_to_At = 1.2;
M_inf = 1.9;
Pb_second_part = 4.88;


gamma = 1.4; %do not change unless you left earth
    
%% a
[mach , ~, ~, ~, ~] = flowisentropic(gamma, Ai_to_At, 'sub');
[mach,~,~,~,~,~,~] = flownormalshock(gamma, mach, 'down');
if mach <= M_inf
    shock_flag = 0;
else
    shock_flag = 1;
end
a = shock_flag;

%% b
if shock_flag == 1
    throat_flag = 1;
elseif mach == M_inf
    throat_flag = 1;
else
    throat_flag = 0;
end
b = throat_flag;
%% c d e f
if shock_flag == 0
    [~ , ~, ~ , ~, Areat] = flowisentropic(gamma, M_inf);
    f_M_i = 1/Areat;
    f_M_throat = f_M_i*Ai_to_At;
    [M_throat , ~, ~ , ~, ~] = flowisentropic(gamma, 1/f_M_throat, 'sup');
    % The mach min would be when the shock wave is in the throat
    [~,~,~,~,M_throat_sub, P0_shock,~] = flownormalshock(gamma, M_throat);
    [~ , ~, ~ , ~, Areat] = flowisentropic(gamma, M_throat_sub);
    f_M_throat = 1/Areat;
    f_Me = f_M_throat/Ae_to_At;
    [M_e , ~, P_sub , ~, ~] = flowisentropic(gamma, 1/f_Me, 'sub');
    c = M_e;
    [~, ~, P_before_shock, ~, ~] = flowisentropic(gamma, M_inf);
    d = P_sub*P0_shock/P_before_shock;
    %if there is no shock at all:
    [~ , ~, ~ , ~, Areat] = flowisentropic(gamma, M_throat);
    f_M_throat = 1/Areat;
    f_Me = f_M_throat/Ae_to_At;
    [M_e , ~, P_sup , ~, ~] = flowisentropic(gamma, 1/f_Me, 'sup');
    e = M_e;
    %if there is shock in the exit:
    [~,~,P_exit,~,~, ~,~] = flownormalshock(gamma, M_e);
    f = P_sup*P_exit/P_before_shock;

else
[mach , ~, P_sub , ~, ~] = flowisentropic(gamma, Ae_to_At, 'sub');
c = mach;
[~,~,~,~,~,P0_shock,~] = flownormalshock(gamma, M_inf);
[~, T, P_before_shock, rho, area] = flowisentropic(gamma, M_inf);
d = P_sub*P0_shock/P_before_shock;

[mach , ~, P_sup , ~, ~] = flowisentropic(gamma, Ae_to_At, 'sup');
e = mach;
%for f it point 3
[~,~,P,~,downstream_mach,P0,P1] = flownormalshock(gamma, e);
f = P_sup*P0_shock*P/P_before_shock;
end

%% g h
g = shock_flag;
if shock_flag
    if  Pb_second_part <= d
        throat_flag = 1;
    else
        throat_flag = 0;
    end
else
    throat_flag = 0;
end
h = throat_flag;

%% k l m n
if shock_flag
if ~throat_flag
    pb_to_p0 = Pb_second_part*P_before_shock/P0_shock;
    [mach , ~, ~ , ~, area] = flowisentropic(gamma, pb_to_p0, 'pres');
    k = mach;
    l = Pb_second_part;
    f1i = (Ae_to_At/Ai_to_At)/area;
    [mach , ~, p , ~,~] = flowisentropic(gamma, 1/f1i, 'sub');
    m = mach;
    n = p*P0_shock/P_before_shock;
else
    if Pb_second_part > f
        Pt = 0.52828*P0_shock/P_before_shock;
        f2 = (1/Ae_to_At)*(Pt/Pb_second_part);
        machs_2 = roots([(gamma-1)/(gamma+1), 2/(gamma+1), -f2^2]);
        k = sqrt(machs_2(2));
        l = Pb_second_part;
        [mach , ~, p , ~,~] = flowisentropic(gamma, Ai_to_At, 'sub');
        m = mach;
        n = p*P0_shock/P_before_shock;
    else
        k = e;
        l = P_sup*P0_shock/P_before_shock;
        [mach , ~, p , ~,~] = flowisentropic(gamma, Ai_to_At, 'sub');
        m = mach;
        n = p*P0_shock/P_before_shock;
    end
end
else
    if Pb_second_part > f
        f2_Mi = M_inf*sqrt((2/(gamma+1))*(1+(gamma-1)*M_inf^2/2));
        f2 = (Ai_to_At/Ae_to_At)*(1/Pb_second_part)*f2_Mi;
        machs_2 = roots([(gamma-1)/(gamma+1), 2/(gamma+1), -f2^2]);
        k = sqrt(machs_2(2));
        l = Pb_second_part;
        m = M_inf;
        n = 1;
    else
         [~ , ~, ~ , ~, Areat] = flowisentropic(gamma, M_inf);
         f_Mi = 1/Areat;
        f_Me = (Ai_to_At/Ae_to_At)*f_Mi;
        [M_e , ~, P_sup , ~, ~] = flowisentropic(gamma, 1/f_Me, 'sup');
        k = M_e;
        l = P_sup/P_before_shock;
        m = M_inf;
        n = 1;
    end
end  
disp(['question 1: ', num2str(a)])
disp(['question 2: ', num2str(b)])
disp(['question 3: ', num2str(c)])
disp(['question 4: ', num2str(d)])
disp(['question 5: ', num2str(e)])
disp(['question 6: ', num2str(f)])
disp(['question 7: ', num2str(g)])
disp(['question 8: ', num2str(h)])
disp(['question 9: ', num2str(k)])
disp(['question 10: ', num2str(l)])
disp(['question 11: ', num2str(m)])
disp(['question 12: ', num2str(n)])
