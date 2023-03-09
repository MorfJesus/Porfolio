syms m n a b x y p0 j k
%%{
q1=-(368.*p0)./(35.*a.^2).*x.^2+(184.*p0)./(35.*a).*x+p0./5;
q1 = -q1;
q2=-(16.*(4.*sqrt(141).*p0+59.*p0))./(21.*a.^2).*x.^2+(8.*(2.*sqrt(141).*p0+27.*p0))./(3.*a).*x-(16.*sqrt(141).*p0+187.*p0)./(7);
q2 = -q2;
f1=4.*q1.*sin(pi.*x.*m./a).*sin(pi.*y.*n./b)./(a.*b);
f2=4.*q2.*sin(pi.*x.*m./a).*sin(pi.*y.*n./b)./(a.*b);
Pmn1=int(int(f1,'x',0,(a./4)),'y',0,(b))+int(int(f2,'x',(3*a./4),(a)),'y',0,(b));
chleny = 3;
P1matrix=sym(zeros(chleny));
for j=1:chleny
for k=1:chleny
P1matrix(j,k)=subs(subs(Pmn1.*sin(m.*pi.*x./a).*sin(n.*pi.*y./b), m, j),n,k);
end
end
P1=sum(sum(P1matrix))

fid = fopen('pmn.txt', 'wt'); 
fprintf(fid, '%s', insertBefore(char(P1), "*", "."));
fclose(fid);
type('pmn.txt');
eval(insertBefore(char(P1), "*", "."))
%double(type('pmn.txt'))
%{

a=0.6;
b=0.7.*4./5;
p0=2.5.*10.^6;
u=0:0.001:(a);
v=0:b./240:((b));
[x,y]=meshgrid(u,v);
P=eval(insertBefore(char(P1), "*", "."))
plot3(x,y,P)
grid on;
hold on;
%}%{
%%}
figure()
a=0.6;
b=0.7.*4./5;
p0=2.5.*10.^6;
AREA2 = 0;
hold on
for y=0:0.25.*b:b

x=0:0.001:a;
P =eval(insertBefore(char(P1), "*", "."));
%AREA2 = [AREA2 trapz(x, P)];

plot(x,P);


end

x1=[0:0.01:(a./4)];
q1=-(368.*p0)./(35.*a.^2).*x1.^2+(184.*p0)./(35.*a).*x1+p0./5;
q1 = -q1;
x2=[(3.*a./4):0.01:(a)];
q2=-(16.*(4.*sqrt(141).*p0+59.*p0))./(21.*a.^2).*x2.^2+(8.*(2.*sqrt(141).*p0+27.*p0))./(3.*a).*x2-(16.*sqrt(141).*p0+187.*p0)./(7);
q2 = -q2;
x1 = [x1 x1(end)];
x2 = [x2(1) x2];
q1 = [q1 0];
q2 = [0 q2];
length(x1)
length(q1)
length(q2)
plot(x1,q1, x2, q2, 'DisplayName','P(x)');
xlabel("X")
ylabel("P")
grid on

xlim([0 a])
legend('y=0','y=0.25b','y=0.5b','y=0.75b','y=b', 'P')
%legend

AREA1 = trapz(x1, q1)
%AREA2 = AREA2(2:end)

%%}

figure()
a=0.6;
b=0.7.*4./5;
p0=2.5.*10.^6;
hold on
grid on
for x=0:0.25.*a:a
    %if (x == 0.25*a)
    %    x = 0.2*a;
   % end
    
    y=0:b./600:b;
    P =eval(insertBefore(char(P1), "*", "."));
    plot(y,P);
    %if (x == 0.2*a)
    %    x = 0.25*a;
    %end



end
%x = 0.2*a;
%P =eval(insertBefore(char(P1), "*", "."));
%plot(y,P);
%x2=[0 b];
%y2=[-5*2.8/3.*10^6 -5*2.8/3.*10^6];

%plot(x2,y2)
legend('x=0','x=0.25a','x=0.5a','x=0.75a','x=a', 'P')
xlim([0 b])

%}
syms m n a b x y p0 j k D
q1=-(368.*p0)./(35.*a.^2).*x.^2+(184.*p0)./(35.*a).*x+p0./5;
q1 = -q1;
q2=-(16.*(4.*sqrt(141).*p0+59.*p0))./(21.*a.^2).*x.^2+(8.*(2.*sqrt(141).*p0+27.*p0))./(3.*a).*x-(16.*sqrt(141).*p0+187.*p0)./(7);
q2 = -q2;
f1=4.*q1.*sin(pi.*x.*m./a).*sin(pi.*y.*n./b)./((a.*b).^2.*D.*pi.^4.*(m.^2./a.^2+n.^2./b.^2).^2);
f2=4.*q2.*sin(pi.*x.*m./a).*sin(pi.*y.*n./b)./((a.*b).^2.*D.*pi.^4.*(m.^2./a.^2+n.^2./b.^2).^2);
w1=int(f1,'x',0,(a./4))+int(f2,'x',(3*a./4),(a));
Wmn1=int(w1,'y',0,(b));
W1matrix=sym(zeros(chleny));
for j=1:chleny
    for k=1:chleny
    W1matrix(j,k)=subs(subs(Wmn1.*sin(m.*pi.*x./a).*sin(n.*pi.*y./b), m, j),n,k);  
    end
end
W1=sum(sum(W1matrix));
fid = fopen('wmn.txt', 'wt'); 
fprintf(fid, '%s', insertBefore(char(W1), "*", "."));
fclose(fid);
type('wmn.txt');
%}
%{
%{
a=0.6;
b=0.7.*4./5;
p0=2.5;
h=3.5*10^-2;
E=70.*(10.^9);
nu=0.3;
D=E.*h.^3./(12.*(1-nu.^2))
figure()
for y=0:0.25.*b:b
x=0:0.001:a;
W =eval(insertBefore(char(W1), "*", "."))
plot(x,W./h);
hold on
end
xlabel('X')
ylabel('W (безразмерный прогиб w./h)')
legend('y=0','y=0.25b','y=0.5b','y=0.75b','y=b')
grid on;


a=0.6;
b=0.7*4/5;
p0=2.5;
h=3.5*10^-2;
E=70.*(10.^9);
nu=0.3;
D=E.*h.^3./(12.*(1-nu.^2))
figure()
for x=0:0.25*a:a
    y=0:b/600:b;
    W =eval(insertBefore(char(W1), "*", "."));
    plot(y,W./h);
    hold on
end
%x = 0.25*a;

xlabel('Y')
ylabel('W (безразмерный прогиб w./h)')
legend('x=0','x=0.25a','x=0.5a','x=0.75a','x=a', 'x=0.2a')
grid on;
%
%%{
%}
%}
syms m n a b x y p0 j k D nu
W=eval(insertBefore(char(W1), "*", "."));
w2xy=diff(diff(W,'x',1),'y',1);
w2x=diff(W,'x', 2);
w2y=diff(W,'y', 2);
M11Z=D.*(w2x+nu.*w2y);
M22Z=D.*(w2y+nu.*w2x);
M12Z=D.*(1-nu).*w2xy;
Q1Z=diff(M11Z,'x',1)+diff(M12Z,'y',1);
Q2Z=diff(M12Z,'x',1)+diff(M22Z,'y',1);
PZ = diff(Q1Z,'x',1)+diff(Q2Z,'y',1);
fid = fopen('M11.txt', 'wt'); % открыли файл для записи
fprintf(fid, '%s', insertBefore(char(M11Z), "*", "."));
fclose(fid);
type('M11.txt');
 
fid = fopen('M22.txt', 'wt'); % открыли файл для записи
fprintf(fid, '%s', insertBefore(char(M22Z), "*", "."));
fclose(fid);
type('M22.txt');
 
fid = fopen('M12.txt', 'wt'); % открыли файл для записи
fprintf(fid, '%s', insertBefore(char(M12Z), "*", "."));
fclose(fid);
type('M12.txt');
 
fid = fopen('Q1.txt', 'wt'); % открыли файл для записи
fprintf(fid, '%s', insertBefore(char(Q1Z), "*", "."));
fclose(fid);
type('Q1.txt');
 
fid = fopen('Q2.txt', 'wt'); % открыли файл для записи
fprintf(fid, '%s', insertBefore(char(Q2Z), "*", "."));
fclose(fid);
type('Q2.txt');

M11=eval(insertBefore(char(M11Z), "*", "."));
M12=eval(insertBefore(char(M12Z), "*", "."));
M22=eval(insertBefore(char(M22Z), "*", "."));

a=0.6;
b=0.7.*4./5;
p0=2.5*10.^6;
h=3.5*10^-2;
E=70*(10.^9);
nu=0.3;
D=E*(h.^3)./(12*(1-nu.^2));




syms LMBD
u3=0:0.01:a;
v3=0:b./56:b;
[x,y]=meshgrid(u3,v3);
P=eval(insertBefore(char(P1), "*", "."));


SIG11Z = -6*eval(insertBefore(char(M11Z), "*", "."))/h^2;
SIG12Z = -6*eval(insertBefore(char(M12Z), "*", "."))/h^2;
SIG22Z = -6*eval(insertBefore(char(M22Z), "*", "."))/h^2;
SIG33Z = -P;
[S1, S2]=size(SIG22Z);
SIG1 = zeros(S1, S2);
SIG2 = zeros(S1, S2);
SIG3 = zeros(S1, S2);
SIGEQV = zeros(S1, S2);


for i=1:S1
    for j=1:S2
        sig11 = SIG11Z(i, j);
        sig12 = SIG12Z(i, j);
        sig22 = SIG22Z(i, j);
        sig33 = -P(i, j);
        MAT=[sig11-LMBD  sig12     0
        sig12   sig22-LMBD    0
        0       0          sig33-LMBD];
        eqn = det(MAT)==0;
        S=solve(eqn, LMBD, 'Real', true);
        SIG1(i, j)=double(S(1));
        SIG2(i, j)=double(S(2));
        SIG3(i, j)=double(S(3));
        SIGEQV(i, j) = 1/sqrt(2)*sqrt((SIG1(i, j)-SIG2(i, j))^2+(SIG3(i, j)-SIG2(i, j))^2+(SIG1(i, j)-SIG3(i, j))^2);
    end
    i
end

figure()
plot3(x,y,SIG11Z)
grid on
figure()
plot3(x,y,SIG12Z)
grid on
figure()
plot3(x,y,SIG22Z)
grid on
figure()
plot3(x,y,SIG33Z)
grid on
figure()
plot3(x,y,SIG1)
grid on
figure()
plot3(x,y,SIG2)
grid on
figure()
plot3(x,y,SIG3)
grid on
figure()
plot3(x,y,SIGEQV)
max(max(SIGEQV))
[CC, II] = max(SIGEQV(:))
CC
SIGEQV(II)
grid on








%{
%{
a=0.6;
b=0.7.*4./5;
p0=2.5*10.^6;
h=3.5*10^-2;
E=70*(10.^9);
nu=0.3;
D=E*(h.^3)./(12*(1-nu.^2));
%P

figure()
for y=0:0.25*b:b
x=0:0.001:a;
P1=eval(insertBefore(char(PZ), "*", "."));
PZ2 = diff(Q1Z,'x',1)+diff(Q2Z,'y',1);
P2=eval(insertBefore(char(PZ2), "*", "."));

plot(x,P1);
plot(x,P2);
FUCK1 = trapz(x, P1)
FUCK2 = trapz(x, P2)
hold on
end
xlabel('ось X')
ylabel('Функция P полученая из условия равновесия пластины')
legend('y=0','y=0.25b','y=0.5b','y=0.75b','y=b')
grid on;
%}


%{
u3=0:0.01:a;
v3=0:b./56:b;
[x,y]=meshgrid(u3,v3);
M11=eval(insertBefore(char(M11Z), "*", "."));
%}


%{

%}

%{
figure()
a=0.6;
b=0.7.*4./5;
p0=2.5.*10.^6;
h=3.5*10^-2;
E=70.*(10.^9);
nu=0.3;
D=E.*h.^3./(12.*(1-nu.^2));
u3=0:0.001:a;
v3=0:b./600:b;
[x,y]=meshgrid(u3,v3);
M11=eval(insertBefore(char(M11Z), "*", "."));
plot3(x,y,M11)
grid on
max(max(M11))
%}




%{
figure()
a=0.6;
b=0.7.*4./5;
p0=2.5.*10.^6;
h=3.5*10^-2;
E=70.*(10.^9);
nu=0.3;
D=E.*h.^3./(12.*(1-nu.^2));
u3=0:0.001:a;
v3=0:b./600:b;
[x,y]=meshgrid(u3,v3);
M11=eval(insertBefore(char(M11Z), "*", "."));
plot3(x,y,M11)
grid on
max(max(M11))





figure()
a=0.6;
b=0.7.*4./5;
p0=2.5*10.^6;
h=3.5*10^-2;
E=70*(10.^9);
nu=0.3;
D=E*h.^3./(12*(1-nu.^2));
u3=0:0.001:a;
v3=0:b./600:b;
[x,y]=meshgrid(u3,v3);
M12=eval(insertBefore(char(M12Z), "*", "."));
plot3(x,y,M12)
grid on
max(max(M12))








figure()
a=0.6;
b=0.7.*4./5;
p0=2.5*10.^6;
h=3.5*10^-2;
E=70*(10.^9);
nu=0.3;
D=E*h.^3./(12*(1-nu.^2));
u3=0:0.001:a;
v3=0:b./600:b;
[x,y]=meshgrid(u3,v3);
M22=eval(insertBefore(char(M22Z), "*", "."));
plot3(x,y,M22)
grid on
max(max(M22))







figure()
a=0.6;
b=0.7.*4./5;
p0=2.5*10.^6;
h=3.5*10^-2;
E=70*(10.^9);
nu=0.3;
D=E*h.^3./(12*(1-nu.^2));
u3=0:0.001:a;
v3=0:b./600:b;
[x,y]=meshgrid(u3,v3);
Q1=eval(insertBefore(char(Q1Z), "*", "."));
plot3(x,y,Q1)
grid on
max(max(Q1))











figure()
a=0.6;
b=0.7.*4./5;
p0=2.5*10.^6;
h=3.5*10^-2;
nu=0.3;
E=70*(10.^9);
D=E*h.^3./(12*(1-nu.^2));
u3=0:0.001:a;
v3=0:b./600:b;
[x,y]=meshgrid(u3,v3);
Q2=eval(insertBefore(char(Q2Z), "*", "."));
plot3(x,y,Q2)
grid on
max(max(Q2))
%
%%%%%%%%%%%%%







a=0.6;
b=0.7.*4./5;
p0=2.5*10.^6;
h=3.5*10^-2;
E=70*(10.^9);
nu=0.3;
D=E*(h.^3)./(12*(1-nu.^2));
%M11
figure()
for x=0:0.25*a:a
y=0:b./600:b;
M11=eval(insertBefore(char(M11Z), "*", "."));
plot(y,M11);
hold on
end
xlabel('ось Y')
ylabel('M11 (H)')
legend('x=0','x=0.25a','x=0.5a','x=0.75a','x=a')
grid on;
xlim([0 b])
figure()
for y=0:0.25*b:b
x=0:0.001:a;
M11=eval(insertBefore(char(M11Z), "*", "."));
plot(x,M11);
hold on
end
xlabel('ось X')
ylabel('M11(H)')
legend('y=0','y=0.25b','y=0.5b','y=0.75b','y=b')
grid on;


a=0.6;
b=0.7.*4./5;
p0=2.5*10.^6;
h=3.5*10^-2;
E=70*(10.^9);
nu=0.3;
D=E*(h.^3)./(12*(1-nu.^2));
%M12
figure()
for x=0:0.25*a:a
y=0:b./600:b;
M12=eval(insertBefore(char(M12Z), "*", "."));
plot(y,M12);
hold on
end
xlabel('ось Y')
ylabel('M12 (H)')
legend('x=0','x=0.25a','x=0.5a','x=0.75a','x=a')
grid on;
xlim([0 b])
figure()
for y=0:0.25*b:b
x=0:0.001:a;
M12=eval(insertBefore(char(M12Z), "*", "."));
plot(x,M12);
hold on
end
xlabel('ось X')
ylabel('M12(H)')
legend('y=0','y=0.25b','y=0.5b','y=0.75b','y=b')
grid on;



a=0.6;
b=0.7.*4./5;
p0=2.5*10.^6;
h=3.5*10^-2;
E=70*(10.^9);
nu=0.3;
D=E*(h.^3)./(12*(1-nu.^2));
%M22
figure()
for x=0:0.25*a:a
y=0:b./600:b;
M22=eval(insertBefore(char(M22Z), "*", "."));
plot(y,M22);
hold on
end
xlabel('Y')
ylabel('M22 (H)')
legend('x=0','x=0.25a','x=0.5a','x=0.75a','x=a')
grid on;
xlim([0 b])
figure()
for y=0:0.25*b:b
x=0:0.001:a;
M22=eval(insertBefore(char(M22Z), "*", "."));
plot(x,M22);
hold on
end
xlabel('X')
ylabel('M22(H)')
legend('y=0','y=0.25b','y=0.5b','y=0.75b','y=b')
grid on;




a=0.6;
b=3*0.8/4;
p0=2.5*10^6;
h=3.5;
E=70*(10^9);
nu=0.3;
D=E*(h^3)/(12*(1-nu^2));
%Q1
figure()
for x=0:0.25*a:a
y=0:b/600:b;
Q1=eval(insertBefore(char(Q1Z), "*", "."));
plot(y,Q1);
hold on
end
xlabel('Y')
ylabel('Q1 (H/м)')
legend('x=0','x=0.25a','x=0.5a','x=0.75a','x=a')
grid on;
xlim([0 b])
figure()
for y=0:0.25*b:b
x=0:0.001:a;
Q1=eval(insertBefore(char(Q1Z), "*", "."));
plot(x,Q1);
hold on
end
xlabel('X')
ylabel('Q1(H/м)')
legend('y=0','y=0.25b','y=0.5b','y=0.75b','y=b')
grid on;




a=0.6;
b=3*0.8/4;
p0=2.5*10^6;
h=3.5;
E=70*(10^9);
nu=0.3;
D=E*(h^3)/(12*(1-nu^2));
%Q2
figure()
for x=0:0.25*a:a
y=0:b/600:b;
Q2=eval(insertBefore(char(Q2Z), "*", "."));
plot(y,Q2);
hold on
end
xlabel('Y')
ylabel('Q2 (H/м)')
legend('x=0','x=0.25a','x=0.5a','x=0.75a','x=a')
grid on;
xlim([0 b])
figure()
for y=0:0.25*b:b
x=0:0.001:a;
Q2=eval(insertBefore(char(Q2Z), "*", "."));
plot(x,Q2);
hold on
end
xlabel('X')
ylabel('Q2(H/м)')
legend('y=0','y=0.25b','y=0.5b','y=0.75b','y=b')
grid on;
%%{
%}
%}

