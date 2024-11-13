function [f2] = f2(t, x2, z2)
% Second function in ODE system
global rho A a file D T 
gama_of_t = @Gama_as_a_function_of_t;
T_of_t = @T_as_a_function_of_t;
m_of_t = @m_as_a_function_of_t;

Dx = -0.5*rho*A*Mach_to_CD(file,((x2^2+z2^2)^0.5)/a)*((x2^2+z2^2)^0.5)*x2;
Tx = T_of_t(t)*cos(deg2rad(gama_of_t(t)));

if (D == false)
    Dx = 0;
end

if (T == false)
    Tx = 0;
end

f2 = (Dx + Tx)/(m_of_t(t));

end
