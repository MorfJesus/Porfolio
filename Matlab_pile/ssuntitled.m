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

function y=f_B2(a,g)

B11=[0 1 0 1;

a 0 1 0;

sin(0.5*a) cos(0.5*a) 0.5 1;

0 0 0 0];

B12=[0 0 0 0;

0 0 0 0;

0 0 0 0;

sin(0.5*a) cos(0.5*a) 0.5 1];

B21=[a*cos(0.5*a) -a*sin(0.5*a) 1 0;

-sin(0.5*a) -cos(0.5*a) 0 0;

0 0 0 0;

0 0 0 0];

B22=[-a*cos(0.5*a) a*sin(0.5*a) -1 0;

sin(0.5*a) cos(0.5*a) 0 0;

-sin(a) -cos(a) 0 0;

-g*sin(a) -g*cos(a) a^2-g -g];

B=[B11 B12;

B21 B22];

y=det(B);

end