a = 2;
b = a/2;
omega = -2*pi:0.01:2*pi;

Sv = (a^2+b^2+a*b*(exp(-i*omega)+exp(i*omega)))/(2*pi);

plot(omega, Sv)
grid on

XL = [-2*pi, 2*pi];
YL = ylim;

line([0 0], [-1000 1000],'Color','black'); 
line([-1000 1000], [0 0],'Color','black');

YL(1) = YL(2)*-0.1;

xlim(XL)
ylim(YL)
