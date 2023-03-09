clc
clear
clear all
close all
syms a b xx
global D A B nu b a h
%Пишешь дано
nu=0.3
h=3.5
%Краевые для опредления пораболы
A1=[a*(b/(2*a))^2+b*(-b/(2*a))-0.6-1.03
   a*(10^-2*50/2)^2+b*(10^-2*50/2)-0.6+0.36]
[a,b]=solve(A1==[0;0],a,b)
c=0.6
x=[0:0.01:10^-2*50/2];
%в зависимости от знака пораболы мб придется заметять 1 на 2
y=a(2)*x.^2+b(2)*x-0.6;
y2=a(2)*xx.^2+b(2)*xx-0.6;
N=solve(y2==0,xx)
plot(x,y)
hold on; grid on
%plot(x,-y)
%Длинна ширина
A=50*10^-2
B=48*10^-2
syms  n x1 x2 n1 k m
%0,6 это с, которая идет из уравнения пораболы
%Для понимания, что заменять смотри КП
fun=(10^6*(a(2)*x1^2+b(2)*x1-0.6))*sin(m*pi*x1/(50*10^-2))*sin(n*pi*x2/(48*10^-2))
ifun=4/(A*B)*int(fun,x1,0,A/2)
p=int(ifun,x2,0,B)
ifun2=4/(A*B)*int(fun,x1,N(1),N(2))
p2=int(ifun2,x2,0,B)
%px(p)
h=3.5*10^-2
E=70*10^9
nu=0.3
D=(E*h^3)/(12*(1-nu^2))
f=(-p*sin(m*pi*x1/A)*sin(n*pi*x2/B))/(D*pi^4*((m/A)^2+(n/B)^2)^2)
w=rad(rad(f,n,30),m,30);
z1='w/h'
z2='w/h'
hold on; grid on
bw=w/h
%если хочешь построить график прогиба pr(w,z1,z2)
%если хочешь построить график нагрузки px(p)
%если хочешь построить график момента M11 grm11(w) дальше по аналогии
%если хочешь построить график силы Q1 grQ1(w) дальше по аналогии
%если хочешь построить график напряжений sig1 sig1(w,p) дальше по аналогии
px(p)
function [] = sige(w,p)
l=ss(w,p);
sigg1=l(3);
sigg2=l(2);
sigg3=l(1);
se=sqrt(1/2)*sqrt((sigg1-sigg2)^2+(sigg3-sigg2)^2+(sigg1-sigg3)^2);
pr(se,'sigma эквивалентные','sigma эквивалентные');
end
function [] = pr1(w)
syms x1 x2
l=diff(q1(w),x1)+diff(q2(w),x2)
z1='P полученная из Q1 Q2';
z2='P полученная из Q1 Q2';
pr(l,z1,z2);
end
function [s] = sig1(w,p)
l=ss(w,p);
s=l(3);
z1='sigma1';
z2='sigma1';
pr(l(3),z1,z2);
end
function [s] = sig2(w,p)
l=ss(w,p);
s=l(2);
z1='sigma2';
z2='sigma2';
pr(l(2),z1,z2);
end
function [s] = sig3(w,p)
l=ss(w,p);
s=l(1);
z1='sigma3';
z2='sigma3';
pr(l(1),z1,z2);
end
function [l] = ss(w,p)
global h 
syms l1 l2 l3 ssig1 ssig12 ssig2 ssig3 m n x1 x2
M11=m11(w);
ss1=-6*M11/h^2;
M22=m22(w);
ss22=-6*M22/h^2;
M12=m12(w);
ss12=-6*M12/h^2;
%sss=[ss1 ss12 0
%     ss12 ss22 0
%     0   0    0];
sig=[ssig1 ssig12 0
     ssig12 ssig2 0
     0    0    ssig3]
f=p*sin(m*pi*x1/50)*sin(n*pi*x2/48);
sr = rad(f,m,30);
ps=rad(sr,n,30);
lam=eig(sig);
l=subs(lam,ssig1,ss1);
l=subs(l,ssig12,ss12);
l=subs(l,ssig2,ss22);
l=subs(l,ssig3,-ps);
l;
f=2
end
function [] = s11(w)
global h
M11=m11(w);
ss1=-6*M11/h^2;
z1='sigma11';
z2='sigma11';
pr(ss1,z1,z2)
end
function [] = s22(w)
global h
M22=m22(w);
ss2=-6*M22/h^2;
z1='sigma22';
z2='sigma22';
pr(ss2,z1,z2)
end
function [] = s12(w)
global h
M12=m12(w);
ss12=-6*M12/h^2;
z1='sigma12'
z2='sigma12'
pr(ss12,z1,z2)
end
function [] = grm22(w)
M22=m22(w)
z1='M22'
z2='M22'
pr(M22,z1,z2)
end
function [] = grm11(w)
M11=m11(w);
z1='M11'
z2='M11'
pr(M11,z1,z2)
end
function [] = grm12(w)
M12=m12(w)
z1='M12'
z2='M12'
pr(M12,z1,z2)
end
function [] = grQ1(w)
Q1=q1(w);
z1='Q1';
z2='Q1';
pr(Q1,z1,z2)
end
function [] = grQ2(w)
Q2=q2(w);
z1='Q2';
z2='Q2';
pr(Q2,z1,z2)
end
function [Q1] = q1(w)
global D nu
syms x1 x2
Q1=(diff(m11(w),x1)+diff(m12(w),x2));
end
function [Q2] = q2(w)
global D nu
syms x1 x2
Q2=(diff(m22(w),x2)+diff(m12(w),x1));
end
function [M11] = m11(w)
global D nu
syms x1 x2
M11=D*(diff(w,x1,2)+nu*diff(w,x2,2));
end
function [M12] = m12(w)
global D nu
syms x1 x2
M12=D*(diff(diff(w,x1),x2))*(1-nu);
end
function [M22] = m22(w)
global D nu
syms x1 x2
M22=D*(diff(w,x2,2)+nu*diff(w,x1,2));
end
function [] = pr(w,z1,z2)
global D A B nu a b
syms x1 x2
k=0
i=1
h=0.05
figure(2)
hold on; grid on
xlabel('x1 м')
ylabel(z1)
x11=[0:h:A];
x22=0;
n=length(x11)
p1=gr(w,x1,x2,x11,x22,n,1);
x22=12*10^-2;
n=length(x11)
p2=gr(w,x1,x2,x11,x22,n,2);
x22=24*10^-2;
n=length(x11)
p3=gr(w,x1,x2,x11,x22,n,3);
x22=36*10^-2;
p4=gr(w,x1,x2,x11,x22,n,4);
x22=48*10^-2;
p5=gr(w,x1,x2,x11,x22,n,5);
P=[p1 p2 p3 p4 p5];
legend(P,'x2=0','x2=12','x2=24','x2=36','x2=48')
%%
figure(3)
h=0.01
hold on; grid on
xlabel('x2 м')
ylabel(z2)
x11=0;
x22=[0:h:B];
n=length(x22)
p1=gr2(w,x1,x2,x11,x22,n,1);
x11=19*10^-2
x22=[0:h:B];
p2=gr2(w,x1,x2,x11,x22,n,2);
x11=A/2;
x22=[0:h:B];
p3=gr2(w,x1,x2,x11,x22,n,3);
x11=38*10^-2
x22=[0:h:B];
p4=gr2(w,x1,x2,x11,x22,n,4);
x11=50*10^-2;
x22=[0:h:B];
p5=gr2(w,x1,x2,x11,x22,n,5);
P=[p1 p2 p3 p4 p5];
legend(P,'x1=0','x1=19','x1=25','x1=38','x1=50')
end
function [] = px(p)
syms m n x1 x2
global  A B
f=-p*sin(m*pi*x1/A)*sin(n*pi*x2/B);
sr =rad(f,m,30);
ps=rad(sr,n,30);
pr(ps,'sigma3','sigma3')
end
function [w] = sr1(h)
syms n m
global D
n=1;
while n<h
w=w+p*sin(m*pi*x1/50)*sin(n*pi*x2/48)/(D*pi^4*((m/A)^2+(n/B)^2)^2);
n=n+1;
end

end
function [s] = rad(f,m,n)
i=1;
s=0;
while i<n
s=s+(subs(f,m,i));
i=i+1;
end
end
function [p] = gr(w,x1,x2,x11,x22,n,f)
i=1;
if(f==1)
q='b';    
end
if(f==2)
q='g';    
end
if(f==3)
q='k';        
end
if(f==4)
q='r';    
end
if(f==5)
q='m'; 
end
while i<n  
ps1=subs(w,'x2',x22);
zz=subs(ps1,'x1',x11(i));
ps2=subs(w,'x2',x22);
zz1=subs(ps2,'x1',x11(i+1));
p=line([x11(i) x11(i+1)],[zz zz1],'Color',q);    
i=i+1;
end
end
function [p] = gr2(w,x1,x2,x11,x22,n,f)
i=1;
if(f==1)
q='b';    
end
if(f==2)
q='g';    
end
if(f==3)
q='k';        
end
if(f==4)
q='r';  
end
if(f==5)
q='m'; 
end
while   i<n  
    ps1=subs(w,'x2',x22(i));
    zz=subs(ps1,'x1',x11);
    ps2=subs(w,'x2',x22(i+1));
    zz1=subs(ps2,'x1',x11);
    p=line([x22(i) x22(i+1)],[zz zz1],'Color',q) ; 
    i=i+1;
end

end

