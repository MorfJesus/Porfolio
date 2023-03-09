function y=f_beta1(x) 
A=[0 1 0 1 0 0 0 0
   0 -1 0 1 0 0 0 0
   sin(0.5.*x) cos(0.5.*x) sinh(0.5.*x) cosh(0.5.*x) -sin(0.5.*x) -cos(0.5.*x) -sinh(0.5.*x) -cosh(0.5.*x)
   cos(0.5.*x) -sin(0.5.*x) cosh(0.5.*x) sinh(0.5.*x) -cos(0.5.*x) sin(0.5.*x) -cosh(0.5.*x) -sinh(0.5.*x)
   -sin(0.5.*x) -cos(0.5.*x) sinh(0.5.*x) cosh(0.5.*x) sin(0.5.*x) cos(0.5.*x) -sinh(0.5.*x) -cosh(0.5.*x)
   -10.*sin(0.5.*x)-x.^3.*cos(0.5.*x) -10.*cos(0.5.*x)+x.^3.*sin(0.5.*x) -10.*sinh(0.5.*x)+x.^3.*cosh(0.5.*x) -10.*cosh(0.5.*x)+x.^3.*sinh(0.5.*x) x.^3.*cos(0.5.*x) -x.^3.*sin(0.5.*x) -x.^3.*cosh(0.5.*x) -x.^3.*sinh(0.5.*x)
   0 0 0 0 sin(x) cos(x) sinh(x) cosh(x)
   0 0 0 0 -sin(x) -cos(x) sinh(x) cosh(x)];
   y=det(A);
end