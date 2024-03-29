function y=f_B(x,k1)
   B11=[0 1 0 1;
       1 0 1 0;
       sin(x) cos(x) sinh(x) cosh(x);
       cos(x) -sin(x) cosh(x) sinh(x)];
   B12=[0 0 0 0;
       0 0 0 0;
       -sin(x) -cos(x) -sinh(x) -cosh(x);
       -cos(x) sin(x) -cosh(x) -sinh(x)];
   b11=[-sin(x) -cos(x);
       -cos(x)+k1*x*sin(x) sin(x)+k1*x*cos(x)];
   b12=[sinh(x) cosh(x);
       -cosh(x)+k1*x*sinh(x) -sinh(x)+k1*x*cosh(x)];
   b21=[0 0;
       0 0];
   b22=b21;
   B21=[b11 b12;
       b21 b22];
       B22=[sin(x) cos(x) -sinh(x) -cosh(x);
           cos(x) -sin(x) -cosh(x) -sinh(x);
           -x^2*sin(2*x) -x^2*cos(2*x) x^2*sinh(2*x) x^2*cosh(2*x);
           -x^3*cos(2*x) x^3*sin(2*x) x^3*cosh(2*x) x^3*sinh(2*x)];
y=[B11 B12;B21 B22];