p0 = 1;
sig = 1.5;
p = -3:0.001:5;

%P = 1/(sqrt(2*pi)*sig)*exp(-((p-p0).^2)./(2*sig^2));
%
%plot(p, P)
%grid on

%syms p c a mt sig p0 pi c1 c2
syms p c a mt
c1 = 1
c2 = 2
p0 = 1
sig = 1.5
F = int(1/(sqrt(2*pi)*sig)*exp((-(p-p0)^2)/(2*sig^2)), p, -inf, a*(c-mt))
F = int(1/(c2-c1)*F, c, abs(c1), abs(c2))
F = diff(F, a)
F2 = subs(F, a, 5);
F2 = subs(F2, mt, 100)