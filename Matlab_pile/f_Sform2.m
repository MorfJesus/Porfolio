function y=f_Sform2(beta,x)
y(1,:)=(1/2)*(cosh(beta*x)+cos(beta*x));
y(2,:)=(1/2)*(sinh(beta*x)+sin(beta*x));
y(3,:)=(1/2)*(cosh(beta*x)-cos(beta*x));
y(4,:)=(1/2)*(sinh(beta*x)-sin(beta*x));
end