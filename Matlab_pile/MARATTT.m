syms m n a b x y p0 j k
%%{
q2=-9*p0/(2*a).*x+4*p0;
%q1 = -q1;
q1=3*p0.*x/a-p0/2;
%q2 = -q2;
f1=4.*q1.*sin(pi.*x.*m./a).*sin(pi.*y.*n./b)./(a.*b);
f2=4.*q2.*sin(pi.*x.*m./a).*sin(pi.*y.*n./b)./(a.*b);
Pmn1=int(int(f1,'x',0,(a./2)),'y',0,(b))+int(int(f2,'x',(2*a/3),(a)),'y',0,(b));
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
%double(type('pmn.txt'))


a=0.8;
b=0.5;
p0=2.8.*10.^6;
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
a=0.8;
b=0.5;
p0=2.8.*10.^6;
AREA2 = 0;
hold on
for y=0:0.25.*b:b

x=0:0.001:a;
P =eval(insertBefore(char(P1), "*", "."));
%AREA2 = [AREA2 trapz(x, P)];

plot(x,P);


end


%q1 = -q1;

x2=[2*a/3:0.01:(a)];
q2=-9*p0/(2*a).*x2+4*p0;
%q2 = -q2;
x1=[0:0.01:(a./2)];
q1=3*p0.*x1./a-p0/2;

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
a=0.8;
b=0.5;
p0=2.8.*10.^6;
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