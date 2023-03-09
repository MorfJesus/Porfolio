x = -2*pi:0.01:2*pi;

Ku = exp(-abs(x)).*(1+abs(x));
Su = 1./(2*pi)*(4./(x.^4+2.*x.^2+1));
Sv = 8/pi*((4+x.^2+x.^4)./(x.^2+4).^3);

plot(x, Sv)
grid on

XL = [-2*pi, 2*pi];
YL = ylim;

line([0 0], [-1000 1000],'Color','black'); 
line([-1000 1000], [0 0],'Color','black');

YL(1) = YL(2)*-0.1;

xlim(XL)
ylim(YL)
