%{
a=[-3 3 1 1 1];
b=[-2 -2 -2 -2 -2];
c=[-2 2 2 3 3];
d=[-2 -2 -2 1 -1];
D=(-d-a).^2+4*(-a.*d+b)
lamb1=-(-d-a)+sqrt(D)./(2)
lamb2=-(-d-a)-sqrt(D)./(2)
sqrt(D)
%}
a=[-3 3 1 1 1];
b=[-2 -2 -2 -2 -2];
c=[-2 2 2 3 3];
d=[-2 -2 -2 1 -1];
a=-3;
b=-2;
c=-2;
d=-2;
syms x(t) y(t)
D= diff(x);
eqns = [diff(x,t) == a.*x+b.*y, diff(y,t) == c.*x+d.*y];
cond = [x(0)==0, D(0)==0];
S = dsolve(eqns, cond)