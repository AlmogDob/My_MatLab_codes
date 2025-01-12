clc; clear;

a1_over_a2 = linspace(0.001, 1, 15);%[0.001:0.1:1];
M1 = linspace(0.001, 1, 15);%[0.001:0.1:1];
gamma = 1.4;
R = 287;


fig1 = figure("Name","Mach Number and Stagnation Pressure Ration at Exit",'Position',[100 300 900 500]);
syms M2

for i = 1:length(a1_over_a2)
    i
    M2s = [];
    p02_over_01 = [];
    for k = 1:length(M1)
        eq = (1+gamma*M2^2)/(sqrt(gamma/R)*M2*(1+(gamma-1)/2*M2^2)^(1/2)) == (gamma*M1(k)^2+1/a1_over_a2(i))*1/(sqrt(gamma/R)*M1(k)*(1+(gamma-1)/2*M1(k)^2)^(1/2));
        temp = solve(eq, M2);
        for j = 1:length(temp)
            temp1 = double(temp(j, 1));
            if temp1 >= 0 && imag(temp1) == 0 
                M2s(end+1) = temp1;
                p02_over_01(end+1) = a1_over_a2(i)*(sqrt(gamma/R)*M1(k)*(1+(gamma-1)/2*M1(k)^2)^(1/2))/(sqrt(gamma/R)*(temp1)*(1+(gamma-1)/2*(temp1)^2)^(1/2))*((1+0.4/2*M1(k)^2)/(1+0.4/2*temp1^2))^(-1.4/0.4);
                break;
            end
        end
    end
    
    hold on   
    yyaxis left
    ylabel("$\displaystyle\frac{P_{02}}{P_{01}}$", "FontSize", 16, "Interpreter","latex")
    plot(M1, p02_over_01, "LineWidth", 1.5)
    ylim([0.5,1])
    yyaxis right
    ylabel("M2", "FontSize", 16, "Interpreter","latex")
    ylim([0,1])
    plot(M1, M2s, "LineWidth", 1.5)
    grid on
    grid minor
    xlabel("M1", "FontSize", 16, "Interpreter","latex")
    title("Mach Number and Stagnation Pressure Ration at Exit", "FontSize", 16, "Interpreter","latex")
    subtitle("Almog Dobrescu 214254252", "FontSize", 16, "Interpreter","latex")
end

% exportgraphics(fig1, 'grap1.png','Resolution',600);