%close all
syms m n a b x y p0 j k
%%{
q1=-(85.*p0)./(12.*a.^2).*x.^2+(17.*p0)./(3.*a).*x+2*p0./3;
q1 = -q1;
q2=-(85.*p0)./(12.*a.^2).*x.^2+(85.*p0)./(6.*a).*x-31*p0./4;
q2 = -q2;
f1=4.*q1.*sin(pi.*x.*m./a).*sin(pi.*y.*n./b)./(a.*b);
f2=4.*q2.*sin(pi.*x.*m./a).*sin(pi.*y.*n./b)./(a.*b);
Pmn1=int(int(f1,'x',0,(2*a./5)),'y',0,(b))+int(int(f2,'x',(3*a./5),(a)),'y',0,(b));
chleny = 15;
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

%}
syms m n a b x y p0 j k D
q1=-(85.*p0)./(12.*a.^2).*x.^2+(17.*p0)./(3.*a).*x+2*p0./3;
q1 = -q1;
q2=-(85.*p0)./(12.*a.^2).*x.^2+(85.*p0)./(6.*a).*x-31*p0./4;
q2 = -q2;
f1=4.*q1.*sin(pi.*x.*m./a).*sin(pi.*y.*n./b)./((a.*b).^2.*D.*pi.^4.*(m.^2./a.^2+n.^2./b.^2).^2);
f2=4.*q2.*sin(pi.*x.*m./a).*sin(pi.*y.*n./b)./((a.*b).^2.*D.*pi.^4.*(m.^2./a.^2+n.^2./b.^2).^2);
w1=int(f1,'x',0,(2*a./5))+int(f2,'x',(3*a./5),(a));
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
%%{
%%{
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

a=0.7;
b=0.6;
p0=2.8*10.^6;
h=3*4.5/4*10^-2;
E=70*(10.^9);
nu=0.3;
D=E*(h.^3)./(12*(1-nu.^2));





%%{
%%{
a=0.7;
b=0.6;
p0=2.8*10.^6;
h=3*4.5/4*10^-2;
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

hold on
plot(x,P1);
plot(x,P2);
FUCK1 = trapz(x, P1)
FUCK2 = trapz(x, P2)

end
xlabel('ось X')
ylabel('Функция P полученая из условия равновесия пластины')
legend('y=0','y=0.25b','y=0.5b','y=0.75b','y=b')
grid on;
%}

%%{
%}
%}

