clc;

p = (tf([1 8],1))/ (tf([1 6],1)*tf([1 -3],1)*tf([1 10],1));
c = 100;
system = (p*c)/(1+p*c);



zeros = zero(1+p*c);
image_zeros = imag(zeros);
real_zeros = real(zeros);
ks = linspace(0,200,500);
figure(1)
hold all
for i = 1:length(ks)
    c = ks(i);
    zeros = zero(1+p*c);
    image_zeros = [image_zeros imag(zeros)];
    real_zeros = [real_zeros real(zeros)];
    
end
plot(real_zeros, image_zeros,'*',LineWidth=1,Color='b')
% plot(real_zeros, image_zeros,'*',LineWidth=10,Color='b')

%%
rltool(p)