clear
k1=4; %коэффициент при массе
b=0:0.01:9;
for k=1:length(b)
    y(k)=f_detB(b(k),k1)/10^4;
end
figure(2); p1=plot(b,y);grid on;hold on
ylim([-5 5]);xlim([0 9]);
set(p1,'Color','black','LineWidth',1.5)
beta=zeros(1,5);
for j=1:5
      beta(j)=fzero('f_detB',(pi/8)*(4*j+1),[],k1);
end
disp([3.927/2 7.069/2 13*pi/8 17*pi/8 21*pi/8])
disp(beta)
figure(2)
plot(beta,[0 0 0 0 0],'*')
grid on
text(beta(1),0.1,'\beta_1')
text(beta(2)+0.1,0.1,'\beta_2')
text(beta(3)+0.1,0.1,'\beta_3')
text(beta(4)+0.1,0.1,'\beta_4')
text(beta(5)+0.1,0.1,'\beta_5')

%------------------------------
x=0:0.001:2;
F=f_form(beta,x,k1);
figure(3)
plot(x,F)
grid on


function y=f_delta(beta,k1)
[a,b]=f_fg(beta,k1);
y=det(a(1)*b(3)-a(3)*b(1));
end

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
end

function y=f_detB(b,k1)

B=f_B(b,k1);

y=det(B);
end

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
end

function y=f_form(beta,x,k1)
n=length(beta);
m=length(x);
y=zeros(n,m);
for j=1:n
     C=zeros(8,1);
     B=f_B(beta(j),k1);
  
     C(1)=1;
     C(2:8)=B(2:8,2:8)^-1*(-B(2:8,1));
    for k=1:m
        if x(k)<1
           y(j,k)=C(1)*sin(beta(j)*x(k))+C(2)*cos(beta(j)*x(k))+C(3)*sinh(beta(j)*x(k))+C(4)*cosh(beta(j)*x(k));
        else
           y(j,k)=C(5)*sin(beta(j)*x(k))+C(6)*cos(beta(j)*x(k))+C(7)*sinh(beta(j)*x(k))+C(8)*cosh(beta(j)*x(k));
        end
    end
end
end