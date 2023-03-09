syms C1 C2 C3 C4 C5 C6 C7 C8 x
syms B
phi1 = C1*sin(B*x)+C2*cos(B*x)+C3*sinh(B*x)+C4*cosh(B*x);
phi2 = C5*sin(B*x)+C6*cos(B*x)+C7*sinh(B*x)+C8*cosh(B*x);

n = 4;

gamma = 10;

eqns = [subs(phi1, x, 0) == 0
    subs(diff(phi1, x, 2), x, 0)==0
    subs(phi1, x, 0.5) == subs(phi2, x, 0.5)
    subs(diff(phi1, x, 1), x, 0.5) == subs(diff(phi2, x, 1), x, 0.5)
    subs(diff(phi1, x, 2), x, 0.5) == subs(diff(phi2, x, 2), x, 0.5)
    subs(diff(phi1, x, 3), x, 0.5)-gamma*subs(phi1, x, 0.5)-subs(diff(phi2, x, 3), x, 0.5) == 0
    subs(phi2, x, 1) == 0
    subs(diff(phi2, x, 2), x, 1)==0]

vars = [C1, C2, C3, C4, C5, C6, C7, C8]


[A, b] = equationsToMatrix(eqns, vars)
step = 0.01;
bet = 0:step:15;
L = length(bet);
detA = zeros(1, L);

%{
beta = zeros(1,4);
j = 1;
for i=1:L
    detA(i)=det(double(subs(A, B, bet(i))));
    i
end

for i=2:L-1
    if (sign(detA(i))~=sign(detA(i+1)))
        beta(j)=bet(i)+step/2
        j=j+1;
    end
end
%}

beta = [3.2950,    6.2850,    9.4350,   12.5650]

om = beta.^2;


CC = cell(4, 1)
R_eqns = cell(4, 1)
for i=1:4
R_eqns{i} = subs(eqns, B, beta(i))

A = equationsToMatrix(R_eqns{i}, vars)
C=zeros(8,1);
    C(1)=1;
    C(2:8)=A(2:8,2:8)^(-1)*(-A(2:8,1));
CC{i} = C;
end

dx = 0.001;

Y = cell(4,1);
R_Y = cell(4,1);
X1 = 0:dx:0.5;
X2 = 0.5:dx:1;
m = length(X1);
X = [X1, X2];

figure(1)
hold on

for i=1:4
    %Y1 = zeros(1, m);
    %Y2 = zeros(1, m);
    %for k=1:m
        %Y1(k) = CC{i}(1)*sin(beta(i)*X1(k))+CC{i}(2)*cos(beta(i)*X1(k))+CC{i}(3)*sinh(beta(i)*X1(k))+CC{i}(4)*cosh(beta(i)*X1(k));
        %Y2(k) = CC{i}(5)*sin(beta(i)*X2(k))+CC{i}(6)*cos(beta(i)*X2(k))+CC{i}(7)*sinh(beta(i)*X2(k))+CC{i}(8)*cosh(beta(i)*X2(k));
        
        Y1 = CC{i}(1)*sin(beta(i)*x)+CC{i}(2)*cos(beta(i)*x)+CC{i}(3)*sinh(beta(i)*x)+CC{i}(4)*cosh(beta(i)*x);
        Y2 = CC{i}(5)*sin(beta(i)*x)+CC{i}(6)*cos(beta(i)*x)+CC{i}(7)*sinh(beta(i)*x)+CC{i}(8)*cosh(beta(i)*x);

    %end
    Y{i} = double([subs(Y1, x, X1), subs(Y2, x, X2)]);
    plot(X,Y{i})
end
grid on
hold off
Y1(end)

YY = [Y{1}; Y{2};Y{3};Y{4}]

%R_A = diag(dx*trapz((YY').^2));
R_A = diag(dx*trapz(YY*YY'));
R_C = diag(dx*trapz(YY'.*beta.^4.*YY'));
"GEGG"
Q = dx*trapz(YY,2);
qst =R_C^-1*Q;
wst = abs(qst'*YY(:,m));
ksi = 0.5;

theta0 = 0;
thetaf = 200;

epse = 0.05;
epsi = 0.005;

N = 2001;

dtheta=(thetaf-theta0)/(N-1);

f=zeros(n,N);
ff=zeros(n,N);
psi=zeros(n,N);
theta=zeros(1,N);
w = zeros(1, N);

for k=1:N
    theta(k)=theta0+(k-1)*dtheta;
    D=(1+1i*epsi*theta(k))*R_C+(2i*epse*theta(k)-theta(k)^2)*R_A;
    f(:,k)=D^-1*Q;
    ff(:,k)=abs(f(:,k));
    %ff(:,k)=ff(:,k)/wst;
    w(k)=abs(ff(:,k)'*YY(:,m))/wst;   %АЧХ для перемещений в точке ksi
end

for m=1:n
     for k=1:N
        theta(k)=theta0+(k-1)*dtheta;
         if theta(k)<=om(m)
            psi(m,k)=-atan(imag(f(m,k)/real(f(m,k))));
         else
            psi(m,k)=-atan(imag(f(m,k)/real(f(m,k))))+pi;
         end
     end    
 end

 figure(4)
semilogy(theta,ff,'Color','black','LineWidth',1.5)
hold on;grid on
plot(om,[0.001,0.001,0.001,0.001],'*','Color','black')
for j=1:n
    plot([om(j) om(j)],[10^-3 10^2],'Color','black')
end

title('Зависимость обощенных координат от частоты при \xi=0,5','Fontname',...
    'Times New Roman','fontsize', 12)
ylabel('f_k','Fontname','Times New Roman','fontsize', 14,...
    'FontAngle','italic')
xlabel('\theta','Fontname','Times New Roman','fontsize', 14) 
text(om(1)+3,1.5*10^-3,'\omega_1','fontsize', 14,...
    'Fontname','Times New Roman')
text(om(2)+2,1.5*10^-3,'\omega_2','fontsize', 14,...
    'Fontname','Times New Roman')
text(om(3)+2,1.5*10^-3,'\omega_3','fontsize', 14,...
    'Fontname','Times New Roman')
text(om(4)+2,1.5*10^-3,'\omega_4','fontsize', 14,...
    'Fontname','Times New Roman')

[f1,t1]=max(ff(1,:));
[f2,t2]=max(ff(2,:));
[f3,t3]=max(ff(3,:));
[f4,t4]=max(ff(4,:));

text(theta(t1),f1+2,'|f_1|','fontsize', 14,'Fontname','Times New Roman',...
    'FontAngle','italic')
text(theta(t2),f2+2,'|f_2|','fontsize', 14,'Fontname','Times New Roman',...
    'FontAngle','italic')
text(theta(t3),f3+5,'|f_3|','fontsize', 14,'Fontname','Times New Roman',...
    'FontAngle','italic')
text(theta(t4),f4+0.1,'|f_4|','fontsize', 14,'Fontname','Times New Roman',...
    'FontAngle','italic')


figure(5)
semilogy(theta,w,'Color','black','LineWidth',1.5)
hold on;grid on
plot(om,[0.001,0.001,0.001,0.001],'*','Color','black')

for j=1:n
    plot([om(j) om(j)],[0 3.5],'Color','black')
end
title('Зависимость перемещения от частоты при \xi=0,5','Fontname',...
    'Times New Roman','fontsize', 12)
ylabel('w_0(0,5)','Fontname','Times New Roman','fontsize', 14,...
    'FontAngle','italic')
xlabel('\theta','Fontname','Times New Roman','fontsize', 14)
text(om(1)+3,1.5*10^-3,'\omega_1','fontsize', 14,...
    'Fontname','Times New Roman')
text(om(2)+2,1.5*10^-3,'\omega_2','fontsize', 14,...
    'Fontname','Times New Roman')
text(om(3)+2,1.5*10^-3,'\omega_3','fontsize', 14,...
    'Fontname','Times New Roman')
text(om(4)+2,1.5*10^-3,'\omega_4','fontsize', 14,...
    'Fontname','Times New Roman')


%[res1, res2, res3, res4, res5, res6, res7, res8] = solve(eqns, vars)
%{
ST = 0.1;
beta = zeros(4, 1);
for i=1:4
    beta(i) = vpasolve(det(A) == 0.0001, B, [ST, Inf])
    ST = beta(i)+0.1;
end
X0 = zeros(1,8)
%}