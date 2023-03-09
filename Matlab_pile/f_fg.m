function [f,g,v1,v3]=f_fg(beta,k1)
A=f_S(beta,1)';
A12=[A(1) A(2)/beta A(3)/beta^2 A(4)/beta^3;
    beta*A(4) A(1) A(2)/beta A(3)/beta^2;
    beta^2*A(3) beta*A(4) A(1) A(2)/beta;
    beta^3*A(2) beta^2*A(3) beta*A(4) A(1)];
A23=eye(4);
A23(4,1)=k1*beta;
A34=A12;
m=[0;0;1;0];
n=[0;0;0;1];
f=A34*A23*A12*m;
g=A34*A23*A12*n;
v1=[0;0;1;-f(3)/g(3)];
v3=A23*A12*v1;