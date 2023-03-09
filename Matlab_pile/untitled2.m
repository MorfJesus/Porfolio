pi = 3.14159265359;


syms a phi
A=diff(sqrt(2*a^2-2*a^2*cos(phi)), phi)
phi2 = pi/6:0.001:pi/4;
a2 = 2;
A=subs(A, a, a2)
A=double(subs(A, phi, phi2))
trapz(A)
plot(phi2, A)