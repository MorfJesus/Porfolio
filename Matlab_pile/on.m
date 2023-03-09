g = 9.8;
m = 0.45;
mg = m*g
l0 = 0.5
P0 = m*g*0.07;
c2 = 0.35;
x = (0:0.01:0.5);
y1 = 2*sqrt(1/(m^2*g^2*c2^2)+x/(2*(c2-3*mg)*mg*c2^2))*mg
y2 = 2*sqrt(1/(m^2*g^2*c2^2)-x/(2*(c2-3*mg)*mg*c2^2))*mg
plot(x, y1, x, y2)
grid on
omega = sqrt(-(c2-3*mg)/(17*m*l0^2/12))