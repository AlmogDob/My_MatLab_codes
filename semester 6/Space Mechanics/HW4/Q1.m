%% Q1
clc;
clear;

a = 7833.6724;
mu = 3.986e5;

r1_vec = [-3500; 7600; 0];
r2_vec = [2742.6585; -5955.4859; 3785.5];
r1 = norm(r1_vec);
r2 = norm(r2_vec);

e_vec = -1/(2*a) .* (r1_vec + (r2_vec-r1_vec)./norm(r2_vec-r1_vec).*(2*a-norm(r1_vec)));
e = norm(e_vec);

h_vec_norm = cross(r1_vec, r2_vec)/norm(cross(r1_vec, r2_vec));
h = sqrt(mu*a*(1-e^2));
h_vec = h * h_vec_norm;
p = h^2/mu;

n_vec = cross([0;0;1], h_vec);
n = norm(n_vec);

omega = mod(atan2(sign(e_vec(3))*sqrt(1-(dot(n_vec, e_vec)/n/e)^2), dot(n_vec, e_vec)/n/e)*180/pi, 360);
Omega = mod(atan2(n_vec(2)/n, n_vec(1)/n)*180/pi,360);

eta = acos(dot(r1_vec, r2_vec)/(norm(r1_vec)*norm(r2_vec)));

v1_vec = h/(r1*r2*sin(eta))*(r2_vec-r1_vec+r2/p*(1-cos(eta))*r1_vec);
v2_vec = h/(r1*r2*sin(eta))*(r2_vec-r1_vec-r1/p*(1-cos(eta))*r2_vec);
v1 = norm(v1_vec);
v2 = norm(v2_vec);

epsilon1 = v1^2/2 - mu/r1;
epsilon2 = v2^2/2 - mu/r2;

h1_vec_check = cross(r1_vec, v1_vec);
h2_vec_check = cross(r2_vec, v2_vec);

f1 = atan2(sign(dot(r1_vec, v1_vec))*sqrt(1-(dot(r1_vec,e_vec)/(r1*e))^2), dot(r1_vec,e_vec)/(r1*e));
f2 = mod(atan2(sign(dot(r2_vec, v2_vec))*sqrt(1-(dot(r2_vec,e_vec)/(r2*e))^2), dot(r2_vec,e_vec)/(r2*e)),2*pi);

E1 = mod(atan2(sqrt(1-e^2)*sin(f1)/(1+e*cos(1)),(e+cos(f1))/(1+e*cos(f1))),2*pi);
E2 = mod(atan2(sqrt(1-e^2)*sin(f2)/(1+e*cos(2)),(e+cos(f2))/(1+e*cos(f2))),2*pi);

M1 = E1-e*sin(E1);
M2 = E2-e*sin(E2);

delta_t = (M2-M1)/sqrt(mu/a^3);