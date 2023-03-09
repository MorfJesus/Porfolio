function y=f_form(bet,x) 
n=length(bet);
m=length(x);
y=zeros(n,m);

gamma = 10;
   

for j=1:n
     A=[0 1 0 1 0 0 0 0;
        0 -1 0 1 0 0 0 0;
   sin(0.5*bet(j)) cos(0.5*bet(j)) sinh(0.5*bet(j)) cosh(0.5*bet(j)) -sin(0.5*bet(j)) -cos(0.5*bet(j)) -sinh(0.5*bet(j)) -cosh(0.5*bet(j));...
   cos(0.5*bet(j)) -sin(0.5*bet(j)) cosh(0.5*bet(j)) sinh(0.5*bet(j)) -cos(0.5*bet(j)) sin(0.5*bet(j)) -cosh(0.5*bet(j)) -sinh(0.5*bet(j));...
   -sin(0.5*bet(j)) -cos(0.5*bet(j)) sinh(0.5*bet(j)) cosh(0.5*bet(j)) sin(0.5*bet(j)) cos(0.5*bet(j)) -sinh(0.5*bet(j)) -cosh(0.5*bet(j));...
   -gamma*bet(j).^(-3)*sin(0.5*bet(j))-cos(0.5*bet(j)) -gamma*bet(j).^(-3)*cos(0.5*bet(j))+sin(0.5*bet(j)) -gamma*bet(j)^(-3)*sinh(0.5*bet(j))+cosh(0.5*bet(j)) -gamma*bet(j)^(-3)*cosh(0.5*bet(j))+sinh(0.5*bet(j)) cos(0.5*bet(j)) -sin(0.5*bet(j)) -cosh(0.5*bet(j)) -sinh(0.5*bet(j));...
   0 0 0 0 sin(bet(j)) cos(bet(j)) sinh(bet(j)) cosh(bet(j));...
   0 0 0 0 -sin(bet(j)) -cos(bet(j)) sinh(bet(j)) cosh(bet(j));];
    C=zeros(8,1);
    C(1)=1;
    C(2:8)=A(2:8,2:8)^(-1)*(-A(2:8,1));
    C
    for k=1:m
        if x(k)<0.5
            y(j,k)=C(1)*sin(bet(j)*x(k))+C(2)*cos(bet(j)*x(k))+C(3)*sinh(bet(j)*x(k))+C(4)*cosh(bet(j)*x(k));
        else
            y(j,k)=C(5)*sin(bet(j)*x(k))+C(6)*cos(bet(j)*x(k))+C(7)*sinh(bet(j)*x(k))+C(8)*cosh(bet(j)*x(k));
        end
    end
end
end
