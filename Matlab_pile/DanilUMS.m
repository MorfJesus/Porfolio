clear 
g=0:0.01:1;
a0=6;
for j=1:length(g)
    a(j)=fzero('f_B3',a0,[],g(j));
    a0=a(j)
end
a=a/pi;

figure(1)
plot(g,a.^2)
ylabel('p')
xlabel('gamma')
title('Зависимость значения критической силы от расстояния до упругой опоры')
grid on

