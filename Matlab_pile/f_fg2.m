function [f,g,v1,v3]=f_fg2(beta, k1, k2)
A=f_Sform2(beta,1)';
A12=[A(1) A(2)/beta A(3)/beta^2 A(4)/beta^3;
    beta*A(4) A(1) A(2)/beta A(3)/beta^2;
    beta^2*A(3) beta*A(4) A(1) A(2)/beta;
    beta^3*A(2) beta^2*A(3) beta*A(4) A(1)];
A23=eye(4);
A23(4,1)=1/beta-k2;
A34=A12;
m=[0;0;1;0];
n=[0;0;0;1];
f=A34*A23*A12*m;
g=A34*A23*A12*n;
v1=[0;0;1;-f(3)/g(3)];
v3=A23*A12*v1;
end

function y=f_Sform2(beta,x)
y(1,:)=(1/2)*(cosh(beta*x)+cos(beta*x));
y(2,:)=(1/2)*(sinh(beta*x)+sin(beta*x));
y(3,:)=(1/2)*(cosh(beta*x)-cos(beta*x));
y(4,:)=(1/2)*(sinh(beta*x)-sin(beta*x));
end