clear all;
close all;
clc;
% dirs = {'RAKETIT_3_DATA_AL0.xlsx', 'RAKETIT_3_DATA_AL10.xlsx', 'RAKETIT_3_DATA_AL20.xlsx'}
%%
DataAl0=readtable('RAKETIT_3_DATA_AL0.xlsx');
DataAl10=readtable('RAKETIT_3_DATA_AL10.xlsx');
DataAl20=readtable('RAKETIT_3_DATA_AL20.xlsx');
o_f=[5:0.2:10];
Tc_Al0=DataAl0.t;
Tc_Al10=DataAl10.t;
Tc_Al20=DataAl20.t;
gamma_Al0=DataAl0.gam;
gamma_Al10=DataAl10.gam;
gamma_Al20=DataAl20.gam;
%%
names=DataAl20.Properties.VariableNames;
Species={};
x_i_Al0=[];
A_Al0=DataAl0.Variables;
A_Al10=DataAl10.Variables;
A_Al20=DataAl20.Variables;
count=1;
for n=3:length(names)
    Species{count}=names{n};
    x_i_Al0(count,:)=A_Al0(:,n)';
    x_i_Al10(count,:)=A_Al10(:,n)';
    x_i_Al20(count,:)=A_Al20(:,n)';
    count=count+1;
end
%%
Mw_i=1e-3*[2*1+16,12+2*16,14*2,1+35.5,12+16,35.5,16+1,2*1,16*2,27*2+16*3];
Pc=30*101325; %[pa]

for n=1:length(o_f)
    Gamma_Al0(n)=gamma_Al0(n)^0.5*(2/(gamma_Al0(n)+1))^((gamma_Al0(n)+1)/(2*(gamma_Al0(n)-1)));
    Mw_bar_Al0(n)=sum(Mw_i*x_i_Al0(:,n))/sum(x_i_Al0(:,n));
   C_star_Al0(n)=1/Gamma_Al0(n)*(8.314*Tc_Al0(n)/Mw_bar_Al0(n))^0.5; 
   CF_Al0(n)=Gamma_Al0(n)*((2*gamma_Al0(n)/(gamma_Al0(n)-1))*(1-(1/30)^((gamma_Al0(n)-1)/gamma_Al0(n))))^0.5;
   Isp_Al0(n)=CF_Al0(n)*C_star_Al0(n)/9.81;
   F_ma_Al0(n)=C_star_Al0(n)*CF_Al0(n);
   Gamma_Al10(n)=gamma_Al10(n)^0.5*(2/(gamma_Al10(n)+1))^((gamma_Al10(n)+1)/(2*(gamma_Al10(n)-1)));
    Mw_bar_Al10(n)=sum(Mw_i*x_i_Al10(:,n))/sum(x_i_Al10(:,n));
   C_star_Al10(n)=1/Gamma_Al10(n)*(8.314*Tc_Al10(n)/Mw_bar_Al10(n))^0.5; 
   CF_Al10(n)=Gamma_Al10(n)*((2*gamma_Al10(n)/(gamma_Al10(n)-1))*(1-(1/30)^((gamma_Al10(n)-1)/gamma_Al10(n))))^0.5;
   Isp_Al10(n)=CF_Al10(n)*C_star_Al10(n)/9.81;
   Gamma_Al20(n)=gamma_Al20(n)^0.5*(2/(gamma_Al20(n)+1))^((gamma_Al20(n)+1)/(2*(gamma_Al20(n)-1)));
    Mw_bar_Al20(n)=sum(Mw_i*x_i_Al20(:,n))/sum(x_i_Al20(:,n));
   C_star_Al20(n)=1/Gamma_Al20(n)*(8.314*Tc_Al20(n)/Mw_bar_Al20(n))^0.5; 
   CF_Al20(n)=Gamma_Al20(n)*((2*gamma_Al20(n)/(gamma_Al20(n)-1))*(1-(1/30)^((gamma_Al20(n)-1)/gamma_Al20(n))))^0.5;
   Isp_Al20(n)=CF_Al20(n)*C_star_Al20(n)/9.81;
end
%%
figure(1)
plot(o_f,Tc_Al0)
hold on
plot(o_f,Tc_Al10)
plot(o_f,Tc_Al20)
grid on
xlabel 'O/F ratio'
ylabel 'Temperature [k]'
title 'HW3.2.1 Tc vs. O/F for different percentage of Al'
subtitle 'Dor Katz - 318301355'
legend ('Al=0%','Al=10%','Al=20%')
%%
figure(2)
plot(o_f,C_star_Al0)
hold on
plot(o_f,C_star_Al10)
plot(o_f,C_star_Al20)
grid on
xlabel 'O/F ratio'
ylabel 'Characteristic Velocity [m/sec]'
title 'HW3.2.1 C* vs. O/F for different percentage of Al'
subtitle 'Dor Katz - 318301355'
legend ('Al=0%','Al=10%','Al=20%')
%%
figure(3)
plot(o_f,Isp_Al0)
hold on
plot(o_f,Isp_Al10)
plot(o_f,Isp_Al20)
grid on
xlabel 'O/F ratio'
ylabel 'Specific Impulse [sec]'
title 'HW3.2.1 Isp vs. O/F for different percentage of Al'
subtitle 'Dor Katz - 318301355'
legend ('Al=0%','Al=10%','Al=20%')
%%
figure(4)
plot(o_f,F_ma_Al0)
grid on
hold on
xlabel 'O/F ratio'
ylabel 'Specific Force [N*sec/kg]'
title 'HW3.2.2 Finding Optimal O/F From Max Specific Force'
subtitle 'Dor Katz - 318301355'
%%
figure(5)
hold on
for n=1:length(Species)-1
    plot(o_f,x_i_Al0(n,:))
end
grid on
legend(Species(1:end-1))
xlabel 'O/F ratio'
ylabel 'Product Precenteg Xi'
title 'HW3.2.3 Product Precenteg Xi vs. O/F For Al=0%'
subtitle 'Dor Katz - 318301355'

%%
for n=1:length(o_f)
    x_sum(n)=sum(x_i_Al0(:,n))
end
figure(6)
plot(o_f,x_sum)
grid on
xlabel 'O/F ratio'
ylabel 'Product Precenteg Sum check'
title 'HW3.2.3 Check that all importend Product Were Include For Al=0%'
subtitle 'Dor Katz - 318301355'
%%
figure(7)
hold on
plot(o_f,x_i_Al0(5,:))
plot(o_f,x_i_Al0(2,:))
plot(o_f,x_i_Al0(1,:))
plot(o_f,x_i_Al0(3,:))
grid on
leg=[Species(5),Species(2),Species(1),Species(3)];
legend(leg)
xlabel 'O/F ratio'
ylabel 'Product Precenteg Xi'
title 'HW3.2.4 CO,CO2,H2O,N2 vs. O/F For Al=0%'
subtitle 'Dor Katz - 318301355'