syms alfa t p w0 a
f = 1*t*exp(-alfa*t);
F = laplace(f, p)
q1(w0, a, alfa, t)=ilaplace(1/(a*(p+alfa)^2*(p^2+w0^2)), p,t)
%q1DOT(w0, a, alfa, t)= diff(q1, t)

%q0=q1(w0, a, alfa, 1/alfa);
%q0DOT=q1DOT(w0, a, alfa, 1/alfa);

%q2(w0, a, alfa, t)=ilaplace((2*p-alpha+p*q0+q0DOT)/(p^2*a*(p^2+w0^2)), p,t)

w0=100;
a=100;
alfa=2*w0;
t=(0:0.0001:0.06);
%q2=q2-(q2(w0, a, alfa, t(100))-q1(w0, a, alfa, t(100)))
hold off
plot(t, q1(w0, a, alfa, t));
grid on
title("alpha = 2*W0")
xlabel("t")
ylabel("q(t)")