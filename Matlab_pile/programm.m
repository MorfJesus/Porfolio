clear

g=0:1:1000;

a0=6;

for j=1:length(g)

a(j)=fzero('f_B2',a0,[],g(j));

a0=a(j)

end

a=a/pi;

figure(1)

plot(g,a.^2)

grid on


