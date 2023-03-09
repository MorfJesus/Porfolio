syms t m r R0 phi0 omega M R g C1 C2
a = (m*r^2)/2 + m* ((2/3*r^2)+R0^2-4/3*r*R0*cos(pi-phi0*sin(omega*t)))+M*(R0^2+R^2)/4+M*(R0/2)^2;
c = (M+m)*g*R/2;
m = 0.1
r = 0.3
R0 = 0.5
phi0 = 0.2
omega = 30
M = 2
R = 0.7
g = 10
a = (m*r^2)/2 + m* ((2/3*r^2)+R0^2-4/3*r*R0*cos(pi-phi0*sin(omega*t)))+M*(R0^2+R^2)/4+M*(R0/2)^2;
c = (M+m)*g*R/2;
phi = 0.1*a/c*sin(c/a*t)
figure(1)
ezplot(phi, [0, 0.9])
grid on
figure(2)
ezplot(diff(phi), [0, 0.9])
grid on
figure(3)
ezplot(diff(diff(phi)), [0, 0.9])
grid on