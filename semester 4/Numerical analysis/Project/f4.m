function [f4] = f4(t, x2, z2)
% Fourth function in ODE system
global file g rho A  a D T 
T_of_t = @T_as_a_function_of_t;
gama_of_t = @Gama_as_a_function_of_t;
m_of_t = @m_as_a_function_of_t;

Dz = -0.5*rho*A*Mach_to_CD(file,((x2^2+z2^2)^0.5)/a)*((x2^2+z2^2)^0.5)*z2;
Tz = T_of_t(t)*sin(deg2rad(gama_of_t(t)));

if (D == false)
    Dz = 0;
end

if (T == false)
    Tz = 0;
end

f4 = (Dz + Tz - m_of_t(t)*g)/(m_of_t(t));
end