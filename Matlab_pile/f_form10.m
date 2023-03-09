function y=f_form10(beta,x,k1,k2)
n=length(beta);
m=length(x);
y=zeros(n,m);
for j=1:n
     C=zeros(8,1);
     B=f_B10(beta(j),k1,k2);
  
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