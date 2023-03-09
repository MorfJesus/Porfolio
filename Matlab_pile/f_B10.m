function y=f_B10(x,k1,k2)
   B11=[0 1 0 1;
       1 0 1 0;
       sin(x) cos(x) sinh(x) cosh(x);
       cos(x) -sin(x) cosh(x) sinh(x)];
   B12=[0 0 0 0;
       0 0 0 0;
       -sin(x) -cos(x) -sinh(x) -cosh(x);
       -cos(x) sin(x) -cosh(x) -sinh(x)];
   b11=[-sin(x) -cos(x);
       (k1*x-2*k2/x^3)*sin(x)-cos(x) ...
       (k1*x-2*k2/x^3)*cos(x)+sin(x)];
   b12=[sinh(x) cosh(x);
       (k1*x-2*k2/x^3)*sinh(x)+cosh(x) ...
       (k1*x-2*k2/x^3)*cosh(x)+sinh(x)];
   b21=[0 0;
       0 0];
   b22=b21;
   B21=[b11 b12;
       b21 b22];
       B22=[sin(x) cos(x) -sinh(x) -cosh(x);
           cos(x) -sin(x) -cosh(x) -sinh(x);
           -sin(2*x) -cos(2*x) sinh(2*x) cosh(2*x);
           -cos(2*x) sin(2*x) cosh(2*x) sinh(2*x)];
y=[B11 B12;B21 B22];
end