function y=f_B3(a,g)

B11=[0 1 0 1;
    a 0 1 0;
    sin(g*a) cos(g*a) g 1;
    a*cos(g*a) -a*sin(g*a) 1 0];
B12=[0 0 0 0;
    0 0 0 0;
    -sin(g*a) -cos(g*a) -g -1;
    -a*cos(g*a) a*sin(g*a) -1 0];
B21=[-sin(g*a) -cos(g*a) 0 0;
    -a^3*cos(g*a)-5*sin(g*a) a^3*sin(g*a)-5*cos(g*a) -5*g*a -5;
    0 0 0 0
    0 0 0 0];
B22=[sin(g*a) cos(g*a) 0 0;
    a^3*cos(g*a) -a^3*sin(g*a) 0 0;
    sin(a) cos(a) 1 1;
    -sin(a) -cos(a) 0 0];
B=[B11 B12;
    B21 B22]
  
 y=det(B);
