mom
function [] = otkr()
%%
n=4;
E=0.7*10^9
t1=1/2;
t2=1/2;
t3=1/2;
t4=2/2;
x1=[t1 10.7]
y1=[t1 t1]
x2=[t2 t2];
y2=[t2 13-t2];
x3=[t2 20.3];
y3=[13-t3 13-t3];
x4=[t2 20.3];
y4=[6.5 6.5];
%%
figure(1)
gr1(x1,y1);
gr1(x2,y2);
gr1(x3,y3);
gr1(x4,y4);
s1=10.7*1;
s2=(13-1*2)*1;
s3=20.3*1;
s4=(20.3-1)*2;
Xc1=10.7/2;
Xc2=0.5
Xc3=20.3/2;
Xc4=(20.3-1)/2+1
Xc=(Xc1*s1+Xc2*s2+Xc3*s3+Xc4*s4)/(s1+s2+s3+s4)
Yc1=0.5
Yc2=6.5;
Yc3=13-0.5;
Yc4=6.5
Yc=(Yc1*s1+Yc2*s2+Yc3*s3+Yc4*s4)/(s1+s2+s3+s4)
Jx1=(10.7*1^3)/(12);
Jx2=(1*((13-2)^3))/12;
Jx3=(20.3*1^3)/12;
Jx4=((20.3-1)*2^3)/12;
Jx=(Jx1+s1*(Yc1-Yc)^2)+(Jx2+s2*(Yc2-Yc)^2)+(Jx3+s3*(Yc3-Yc)^2)+(Jx4+s4*(Yc4-Yc)^2);
Jy1=(10.7^3*1)/(12);
Jy2=(1^3*((13-2)))/12;
Jy3=(20.3^3*1)/12;
Jy4=((20.3-1)^3*2)/12;
Jy=(Jy1+s1*(Xc1-Xc)^2)+(Jy2+s2*(Xc2-Xc)^2)+(Jy3+s3*(Xc3-Xc)^2)+(Jy4+s4*(Xc4-Xc)^2)
Jxy=s1*(Xc1-Xc)*(Yc1-Yc)+s2*(Xc2-Xc)*(Yc2-Yc)+s3*(Xc3-Xc)*(Yc3-Yc)+s4*(Xc4-Xc)*(Yc4-Yc)
alfa=atan(2*Jxy/(Jy-Jx))/2
Ju=(Jx+Jy)/2-sqrt(((Jx-Jy)^2)/4+Jxy^2)
Jv=(Jx+Jy)/2+sqrt(((Jx-Jy)^2)/4+Jxy^2)
u1=x1;
u2=x2;
u3=x3;
u4=x4;
v1=y1;
v2=y2;
v3=y3;
v4=y4;
[u1(1),v1(1)]=uv(x1(1),y1(1),Xc,Yc,alfa);
[u1(2),v1(2)]=uv(x1(2),y1(2),Xc,Yc,alfa);
[u2(1),v2(1)]=uv(x2(1),y2(1),Xc,Yc,alfa);
[u2(2),v2(2)]=uv(x2(2),y2(2),Xc,Yc,alfa);
[u3(1),v3(1)]=uv(x3(1),y3(1),Xc,Yc,alfa);
[u3(2),v3(2)]=uv(x3(2),y3(2),Xc,Yc,alfa);
[u4(1),v4(1)]=uv(x4(1),y4(1),Xc,Yc,alfa);
[u4(2),v4(2)]=uv(x4(2),y4(2),Xc,Yc,alfa);
%%
figure(2)
n=20;
m=0.25;
z2=num2str(u1(1))
z1=num2str(u1(2))
gr2(x1,y1,u1,0,1,z1,z2,m,n);
z1=num2str(u2(1))
z2=num2str(u2(2))
gr2(x2,y2,u2,1,1,z1,z2,m,n);
z2=' '
z1=num2str(u3(2))
gr2(x3,y3,u3,0,0,z1,z2,m,n);
z2=num2str(u4(1))
z1=num2str(u4(2))
gr2(x4,y4,u4,0,0,z1,z2,m,n);
figure(3)
z2=num2str(v1(1))
z1=' '
gr2(x1,y1,v1,0,1,z1,z2,m,n);
z2=num2str(v2(1))
z1=num2str(v2(2))
gr2(x2,y2,v2,1,1,z1,z2,m,n);
z2=num2str(v3(1))
z1=num2str(v3(2))
gr2(x3,y3,v3,0,0,z1,z2,m,n);
z2=num2str(v4(1))
z1=num2str(v4(2))
gr2(x4,y4,v4,0 ,0,z1,z2,m,n);

%%
figure(4)
gr1(x1,y1);
gr1(x2,y2);
gr1(x3,y3);
gr1(x4,y4);
text(Xc,Yc,'C1','FontSize', 15)
S1=[(x2(1)+x2(2))/2,(y2(1)+y2(2))/2]
O1=S1;
plot(S1(1),S1(2),'h','linewidth',1);
text(S1(1),S1(2),'S1,O1','FontSize', 15)
%%
w11=0
w12=(x1(2)-x1(1))*(y4(1)-y1(1))
w21=0
w22=0
w31=0
w32=-(x3(2)-x3(1))*(y3(1)-y4(1))
%%
figure(5)
m=0.05
W1=[w11 w12]
W2=[0 0]
W3=[w31 w32]
W4=[0  0];
z1='-61.2';
z2='0';
gr2(x1,y1,W1,0,1,z1,z2,m,n);
z1='0';
z2='0';
gr2(x2,y2,W2,1,1,z1,z2,m,n);
z1='118';
z2='0';
gr2(x3,y3,W3,0,0,z1,z2,m,n);
z1='0';
z2='0';
gr2(x4,y4,W4,0 ,0,z1,z2,m,n);
Suw11=(x1(2)-x1(1))*(v1(1)*W1(1)+v1(2)*W1(2)+4*((v1(1)+v1(2))/2)*((W1(1)+W1(2))/2))/6
Suw12=(x3(2)-x3(1))*(v3(1)*W3(1)+v3(2)*W3(2)+4*((v3(1)+v3(2))/2)*((W3(1)+W3(2))/2))/6
Suw1=Suw11+Suw12
Svw11=(x1(2)-x1(1))*(u1(1)*W1(1)+u1(2)*W1(2)+4*((u1(1)-u1(2))/2+u1(2))*((W1(1)+W1(2))/2))/6
Svw12=(x3(2)-x3(1))*(u3(1)*W3(1)+u3(2)*W3(2)+4*((u3(1)-u3(2))/2+u3(2))*((W3(1)+W3(2))/2))/6
Svw1=Svw11+Svw12
au1=Suw1/Ju
av1=-Svw1/Jv
ax1=au1*cos(alfa)-av1*sin(alfa)
ay1=au1*sin(alfa)+av1*cos(alfa)
%%
figure(6)
gr1(x1,y1);
gr1(x2,y2);
gr1(x3,y3);
gr1(x4,y4);
text(Xc,Yc,'C1','FontSize', 15)
A=[S1(1)+ax1 S1(2)+ay1]
O=[S1(1)+ax1 S1(2)];
w42=(x4(2)-A(1))*(ay1);
w41=(x4(1)-A(1))*ay1;
w21=w41+(+A(1)-x2(1))*(y4(1)-y2(1));
w22=w41+(y2(2)-y4(1))*(x2(2)-A(1));
w31=w22;
w32=w22-(x3(2)-x3(1))*(y3(2)-A(2));
w12=w21;
w11=w12+(x1(2)-x1(1))*(A(2)-y1(1));
text(A(1),A(2),'A','FontSize', 15)
text(O(1),O(2),'O2','FontSize', 15)
%%
figure(7)
m=0.025
W1=[w12 w11]
W2=[w21 w22]
W3=[w31 w32]
W4=[w41 w42]
z1='-22.90';
z2='20.50';
gr2(x1,y1,W1,0,1,z1,z2,m,n);
z1='-37.30';
z2='20.50';
gr2(x2,y2,W2,1,1,z1,z2,m,n);
z1='20.5';
z2='-37.30';
gr2(x3,y3,W3,0,0,z1,z2,m,n);
z1='-37.30';
z2='116.02';
gr2(x3,y3,W3,0,0,z1,z2,m,n);
z2='20.50';
z1='-63.77';
gr2(x4,y4,W4,0 ,0,z1,z2,m,n);
%%
figure(8)
m=0.01
gr1(x1,y1);
gr1(x2,y2);
gr1(x3,y3);
gr1(x4,y4);
S2=[x1(1) y1(1)]
text(S2(1),S2(2),'S2','FontSize', 15)
%%
figure(9)
w11=0
w12=0
w21=0
w22=0
w31=0;
w32=-(y3(1)-y1(1))*(x3(2)-x3(1));
w41=0
w42=-(x4(2)-x4(1))*(y4(1)-y1(1));
W1=[w12 w11]
W2=[w21 w22]
W3=[w31 w32]
W4=[w41 w42]
Suw21=0
%Suw22=(y2(2)-y2(1))*(v2(1)*W2(1)+v2(2)*W2(2)+4*((v2(2)-v2(1))/2+v2(1))*((W2 (1)+W2(2))/2))/6
Suw22=0
Suw23=(x3(2)-x3(1))*(v3(1)*W3(1)+v3(2)*W3(2)+4*((v3(2)+v3(1))/2)*((W3(2)+W3(1))/2))/6
Suw24=2*(x4(2)-x4(1))*(v4(1)*W4(1)+v4(2)*W4(2)+4*((v4(2)-v4(1))/2+v4(1))*((W4(2)+W4(1))/2))/6
Suw2=Suw21+Suw22+Suw23+Suw24
Svw21=0
Svw22=0
%Svw22=(y2(2)-y2(1))*(u2(1)*W2(1)+u2(2)*W2(2)+4*(((u2(1))+u2(1))/2)*((W2(1)+W2(2))/2))/6
Svw23=(x3(2)-x3(1))*(u3(1)*W3(1)+u3(2)*W3(2)+4*((u3(2)-u3(1))/2+u3(1))*((W3(2)+W3(1))/2))/6
Svw24=2*(x4(2)-x1(1))*(u4(1)*W4(1)+u4(2)*W4(2)+4*((u4(2)-u4(1))/2+u4(1))*((W4(2)+W4(1))/2))/6
Svw2=Svw21+Svw22+Svw23+Svw24
au2=Suw2/Ju
av2=-Svw2/Jv
ax2=au2*cos(alfa)-av2*sin(alfa)
ay2=au2*sin(alfa)+av2*cos(alfa)
z1='';
z2='';
gr2(x1,y1,W1,0,1,z1,z2,m,n);
z1='';
z2='';
gr2(x2,y2,W2,1,1,z1,z2,m,n);
z1='';
z2='';
gr2(x3,y3,W3,0,0,z1,z2,m,n);
z1='';
z2='';
gr2(x3,y3,W3,0,0,z1,z2,m,n);
z2='';
z1='';
gr2(x4,y4,W4,0 ,0,z1,z2,m,n);
%%
figure(10)
S2=[x1(1) y1(1)]
A2=[S2(1)+ax2 S2(2)+ay2];
text(A2(1),A2(2),'A2','FontSize', 15)
text(A(1),A(2),'A1','FontSize', 15)
gr1(x1,y1);
gr1(x2,y2);
gr1(x3,y3);
gr1(x4,y4);
S3=[x3(1) y3(1)]
text(Xc,Yc,'C1','FontSize', 15)
text(S3(1),S3(2),'S3','FontSize', 15)
%%
figure(11)
S3=[x3(1) y3(1)]
w12=(x1(2)-x1(1))*(y3(2)-y1(1))
w11=0
w21=0
w22=0
w31=0;
w32=0;
w41=0
w42=(x4(2)-x4(1))*(y3(1)-y4(1));
W1=[w11 w12]
W2=[w21 w22]
W3=[w31 w32]
W4=[w41 w42]
gr2(x1,y1,W1,0,1,z1,z2,m,n);
z1='';
z2='';
gr2(x2,y2,W2,1,1,z1,z2,m,n);
z1='';
z2='';
gr2(x3,y3,W3,0,0,z1,z2,m,n);
z1='';
z2='';
gr2(x3,y3,W3,0,0,z1,z2,m,n);
z2='';
z1='';
gr2(x4,y4,W4,0 ,0,z1,z2,m,n); 
Suw31=(x1(2)-x1(1))*(v1(1)*W1(1)+v1(2)*W1(2)+4*((v1(2)+v1(1))/2)*((W1(2)+W1(1))/2))/6
Suw34=2*(x4(2)-x4(1))*(v4(1)*W4(1)+v4(2)*W4(2)+4*((v4(2)+v4(1))/2)*((W4(2)+W4(1))/2))/6
Suw3=Suw31+Suw34
Svw31=(x1(2)-x1(1))*(u1(1)*W1(1)+u1(2)*W1(2)+4*((u1(2)-u1(1))/2+u1(1))*((W1(2)+W1(1))/2))/6
Svw34=2*(x4(2)-x4(1))*(u4(1)*W4(1)+u4(2)*W4(2)+4*((u4(2)-u4(1))/2+u4(1))*((W4(2)+W4(1))/2))/6
Svw3=Svw31+Svw34
au3=Suw3/Ju
av3=-Svw3/Jv
ax3=au3*cos(alfa)-av3*sin(alfa)
ay3=au3*sin(alfa)+av3*cos(alfa)
A3=[S3(1)+ax3 S3(2)+ay3]
%%
figure(12)
gr1(x1,y1);
gr1(x2,y2);
gr1(x3,y3);
gr1(x4,y4);
axis([-8 22.5 -2 15])
text(A3(1),A3(2),'A3','FontSize', 10)
%%
S=[x1(1) A(2)];
figure(13)
gr1(x1,y1);
gr1(x2,y2);
gr1(x3,y3);
gr1(x4,y4);
axis([-8 22.5 -2 15])
text(A(1),A(2),'A','FontSize', 10)
text(S(1),S(2),'S','FontSize', 10)
%%
figure(14)
w22=(S(1)-A(1))*(y2(2)-S(2))
w31=w22
w32=w22-(x3(2)-x3(1))*(y3(2)-S(2))
w11=-(S(1)-A(1))*(S(2)-y2(1))
w21=w11
w12=w11+(x1(2)-x1(1))*((S(2)-y1(2)))
w41=((w22-w21)/2+w21)
w42=w41+(x4(2)-x4(1))*(S(2)-y4(2))
W1=[w11 w12]
W2=[w21 w22]
W3=[w31 w32]
W4=[w41 w42]
m=0.028
gr2(x1,y1,W1,0,1,z1,z2,m,n);
z1='';
z2='';
gr2(x2,y2,W2,1,1,z1,z2,m,n);
z1='';
z2='';
gr2(x3,y3,W3,0,0,z1,z2,m,n);
z1='';
z2='';
gr2(x4,y4,W4,0,0,z1,z2,m,n);
z2='';
z1='';
%%
figure(15)
Sw1=(x1(2)-x1(1))*(W1(1)+W1(2)+4*((W1(2)-W1(1))/2+W1(1)))/6
Sw2=(y2(2)-y2(1))*(W2(2)+W2(1)+4*((W2(2)-W2(1))/2+W2(1)))/6
Sw3=(x3(2)-x3(1))*(W3(2)+W3(1)+4*((W3(2)-W3(1))/2+W3(1)))/6
Sw4=2*(x4(2)-x4(1))*(W4(2)+W4(1)+4*((W4(2)-W4(1))/2+W4(1)))/6
Sw=Sw1+Sw2+Sw3+Sw4
C=-Sw/(s1+s2+s3+s4)
C=[C C]
W1=W1+C
W2=W2+C
W3=W3+C
W4=W4+C
m=0.07
gr2(x1,y1,W1,0,1,z1,z2,m,n);
z1='';
z2='';
gr2(x2,y2,W2,1,1,z1,z2,m,n);
z1='';
z2='';
gr2(x3,y3,W3,0,0,z1,z2,m,n);
z1='';
z2='';
gr2(x4,y4,W4,0,0,z1,z2,m,n);
z2='';
z1='';
Sw1=(x1(2)-x1(1))*(W1(1)+W1(2)+4*((W1(2)-W1(1))/2+W1(1)))/6
Sw2=(y2(2)-y2(1))*(W2(2)+W2(1)+4*W4(1))/6
Sw3=(x3(2)-x3(1))*(W3(2)+W3(1)+4*((W3(2)-W3(1))/2+W3(1)))/6
Sw4=2*(x4(2)-x4(1))*(W4(2)+W4(1)+4*((W4(2)-W4(1))/2+W4(1)))/6
Sw22=Sw1+Sw2+Sw3+Sw4
F=s1+s2+s3+s4
Sww1=(x1(2)-x1(1))*(W1(1)^2+W1(2)^2+4*(((W1(2)-W1(1))/2)+W1(1))^2)/6
Sww2=(y2(2)-y2(1))*(W2(2)^2+W2(1)^2+4*W4(1)^2)/6
Sww3=(x3(2)-x3(1))*(W3(2)^2+W3(1)^2+4*(((W3(2)-W3(1))/2)+W3(1))^2)/6
Sww4=2*(x4(2)-x4(1))*(W4(2)^2+W4(1)^2+(4*((W4(2)-W4(1))/2)+W4(1))^2)/6
Sww=Sww1+Sww2+Sww3+Sww4
Jw=Sww
Ww=Jw/58.47
end
function [] = mom()
P=1.7
l=1.4
q=3.5
h=0.007
M1=2*P*h+P*h;

%%
k=0.05
x=[0:k:l/2];
n=length(x)
x1=[0:k:l/2]
x2=[l/2:k:l];
x3=[l:k:l*3/2];
x4=[l*3/2:k:2*l];
m1=M1+(q*x.^2)/2-2*P*x;
m2=m1(n)-3/4*P*x-2*P*x+q*(l/2)*x;
m3=m2(n)-(q*x.^2)/2-3/4*P*x-2*P*x+q*(l/2)*x;
m4=m3(n)+(2*P/3)*x-(q*l/2)*x-3/4*P*x-2*P*x+q*(l/2)*x;
%%
figure(16)
Mx=[m1 m2 m3 m4];
X=[x1 x2 x3 x4];
hold on;grid on;
[G,Mx]=inv(X,Mx);
m=1;
mm(X,Mx,m);
marcMx=[m1(1) m2(1) m3(1) m4(1) m4(n)]
marcx=[0 l/2 l 3*l/2 l*2]
y=[0 -10]
ras(marcx,y)
xx=[x1 x2];
M11=xx*1
[G,xx]=inv(M11,xx)
%%
figure(17)
hold on; grid on;
n=length(M11)
n1=length(m3)
line([0 2*l],[0 0]);
mm(xx,M11,m);
marcx=[0 l/2 l 3*l/2 l*2]
y=[0 1.5]
ras(marcx,y)
d1=l*(M11(1)*m3(1)+4*(M11(n)/4)*m3( round(n1/2))+(m3(n1))*M11(n)/2)/(2*6)+l*(M11(n)*m4(1)/2+4*(3*M11(n)/4)*m4( round(n1/2))+(m4(n1))*M11(n))/(2*6)
dd1=l*(M11(1)^2+4*((M11(1)+M11(n))/2)^2+M11(n)^2)/(6)
R1=-d1/dd1
%%
m1=M1+(q*x.^2)/2-2*P*x;
m2=m1(n1)-3/4*P*x-2*P*x+q*(l/2)*x;
m3=m2(n1)-(q*x.^2)/2-3/4*P*x-2*P*x+q*(l/2)*x+R1*x;
m4=m3(n1)+(2*P/3)*x-(q*l/2)*x-3/4*P*x-2*P*x+q*(l/2)*x+R1*x;
Mx=[m1 m2 m3 m4];
X=[x1 x2 x3 x4];
[G,Mx]=inv(X,Mx);
m=1;

ff=l*(M11(1)*m3(1)+4*(M11(n)/4)*m3( round(n1/2))+(m3(n1))*M11(n)/2)/(2*6)+l*(M11(n)*m4(1)/2+4*(3*M11(n)/4)*m4( round(n1/2))+(m4(n1))*M11(n))/(2*6)
figure(18)
hold on; grid on;
mm(X,Mx,m);
marcMx=[m1(1) m2(1) m3(1) m4(1) m4(n1)]
marcx=[0 l/2 l 3*l/2 l*2]
y=[0 -3]
ras(marcx,y);
%%
h3=0.115
h2=0.07969
x=[0:k:l/2];
M2=2*P*h2-2*P*h3
m1=M2+x*0;
m2=m1(n1)+x*0;
m3=m2(n1)-(q*x.^2)/2
m4=m3(n1)+(q*x.^2)/2-((q*l/2))*(x)
My=[m1 m2 m3 m4]
X=[x1 x2 x3 x4];
%%
figure(19)
hold on;grid on;
[G,My]=inv(X,My);
m=1;
xlabel('z')
ylabel('Mp')
mm(X,My,m);
marcMx=[m1(1) m2(1) m3(1) m4(1) m4(n1)]
marcx=[0 l/2 l 3*l/2 l*2]
y=[0 -2]
ras(marcx,y)
%%
d2=l*(M11(1)*m3(1)+4*(M11(n)/4)*m3( round(n1/2))+(m3(n1))*M11(n)/2)/(2*6)+l*(M11(n)*m4(1)/2+4*(3*M11(n)/4)*m4( round(n1/2))+(m4(n1))*M11(n))/(2*6)
dd2=l*(M11(1)^2+4*((M11(1)+M11(n))/2)^2+M11(n)^2)/(6)
R2=-d2/dd2
%%
figure(20)
m2=m1+x*0;
m3=m2(n1)-(q*x.^2)/2+R2*x
m4=m3(n1)+(q*x.^2)/2-((q*l/2))*(x)+R2*x
My=[m1 m2 m3 m4]
hold on;grid on;
xlabel('z')
ylabel('My')
[G,My]=inv(X,My);
m=1;
mm(X,My,m);
marcMx=[m1(1) m2(n1) m3(n1) m4(n1) m4(n1)]
marcx=[0 l/2 l 3*l/2 l*2]
y=[0.6 -0.6]
ras(marcx,y)
f=l*(M11(1)*m3(1)+4*(M11(n)/4)*m3( round(n1/2))+(m3(n1))*M11(n)/2)/(2*6)+l*(M11(n)*m4(1)/2+4*(3*M11(n)/4)*m4( round(n1/2))+(m4(n1))*M11(n))/(2*6)

%%
 Mu=Mx*cos(alfa)+My*sin(alfa);
 Mv=-Mx*sin(alfa)+My*cos(alfa);
 n=length(Mu)
 figure(21)
hold on;grid on;
xlabel('z')
ylabel('Mu')
mm(X,Mu,m);
marcMu=[Mu(1) Mu(round(n*2/5)) Mu(round(n*3/5)) Mu(round(n*4/5)) Mu(n)]
marcx=[0 l/2 l 3*l/2 l*2]
y=[0 -2]
marcMv=[Mv(1) Mv(round(n*2/5)) Mv(round(n*3/5)) Mv(round(n*4/5)) Mv(n)]
ras(marcx,y)
figure(22)
hold on;grid on;
xlabel('z')
ylabel('Mv')
mm(X,Mv,m);
ras(marcx,y)
end
function [] = MNP()
global k Jw G Jk E
syms M0 Bw0 Md 
Jk=(1/3)*(10.7*(1)^3+20.3*(1)^3+20.3*(2)^3+13*(1)^3)
Jk=Jk*10^-8
Jw=4.6041*10^4*10^(-8)
E=70*10^9
nu=0.3
G=E/(2*(1+nu))
k=sqrt(G*Jk/(E*Jw))
l=1.4
ksi1=k*l/2
ksi2=k*l
ksi3=3*k*l/2
ksi4=2*k*l
%%
Bwk=2*P*(W4(1)+W4(2))*10^-4
m1=0.003*q
m2=-(0.263+0.003+0.002)*q
m3=(0.06)*q
M1=P*(2/3)*(0.263)
M2=-P*(3/4)*(0.167)
M3=-2*P*(0.236)

V0=[0
    0
    Bw0
    M0]
dV1=[0
     0
     0
     M1]
dV2=[0
     0
     0
     Md]
 
dV3=[0
    0
    0
    M2]
%% Матрица U при ksi=2  v
U2=c(ksi2)*V0+uh(ksi2,m1)+c((ksi2-ksi1))*dV1+uh((ksi2-ksi1),(m2-m1))
%% Матрица U при ksi=4
U4=c(ksi4)*V0+uh(ksi4,m1)+c((ksi4-ksi1))*dV1+uh((ksi4-ksi1),(m2-m1))+c((ksi4-ksi2))*dV2+uh((ksi4-ksi2),(0-m2))+c((ksi4-ksi3))*dV3+uh((ksi4-ksi3),(m3))
R=[U2(1)
   U4(3)
   U4(4)]
RR=[0
    Bwk
    M3]
A=R-RR
%% Решим полученную систему при помощи функции solve
[M0,Bw0,Md]=solve(A==0,M0,Bw0,Md)
V0=[0
    0
    Bw0
    M0]
dV1=[0
     0
     0
     M1]
dV2=[0
     0
     0
     Md]
 
dV3=[0
    0
    0
    M2]
ksi=[0:0.0001:ksi4];
Bw=ksi;
fi=ksi;
M=ksi;
Mk=ksi;
Mw=ksi;
dfi=ksi;
nn=length(ksi);
i=1;
%%
while i<=nn
   
 if((ksi(i)<ksi1))
   
  U=c(ksi(i))*V0+uh(ksi(i),m1);
  fi(i)=U(1);
  dfi(i)=U(2);
  Bw(i)=U(3);
  M(i)=U(4);
  Mk(i)=G*Jk*dfi(i);
  Mw(i)=M(i)-Mk(i);
 end
 if((ksi(i)>ksi1)&&(ksi(i)<ksi2))
  U=c(ksi(i))*V0+uh(ksi(i),m1)+c(ksi(i)-ksi1)*dV1+uh((ksi(i)-ksi1),(m2-m1));
  fi(i)=U(1);
  dfi(i)=U(2);
  Bw(i)=U(3);
  M(i)=U(4);
  Mk(i)=G*Jk*dfi(i);
  Mw(i)=M(i)-Mk(i);
 end
 if((ksi(i)>ksi2)&&(ksi(i)<ksi3))
  U=c(ksi(i))*V0+uh(ksi(i),m1)+c(ksi(i)-ksi1)*dV1+uh((ksi(i)-ksi1),(m2-m1))+c(ksi(i)-ksi2)*dV2+uh((ksi(i)-ksi2),(-m2));
  fi(i)=U(1);
  dfi(i)=U(2);
  Bw(i)=U(3);
  M(i)=U(4);
   Mk(i)=G*Jk*dfi(i);
  Mw(i)=M(i)-Mk(i);
 end
 if((ksi(i)>ksi3)&&(ksi(i)<=ksi4))
  U=c(ksi(i))*V0+uh(ksi(i),m1)+c(ksi(i)-ksi1)*dV1+uh((ksi(i)-ksi1),(m2-m1))+c(ksi(i)-ksi2)*dV2+uh((ksi(i)-ksi2),(-m2))+c(ksi(i)-ksi3)*dV3+uh((ksi(i)-ksi3),(m3));
  fi(i)=U(1);
  dfi(i)=U(2);
  Bw(i)=U(3);
  M(i)=U(4);
   Mk(i)=G*Jk*dfi(i);
  Mw(i)=M(i)-Mk(i);
 end
 i=i+1;
end
%%
figure(23)
hold on; grid on;
mm(ksi,fi,m);

figure(24)
hold on; grid on;
mm(ksi,dfi,m);
figure(25)
hold on; grid on;
mm(ksi,Bw,m);
figure(26)
hold on; grid on;
mm(ksi,Mk,m);
figure(27)
hold on; grid on;
mm(ksi,Mw,m)
figure(28);
hold on; grid on;
mm(ksi,M,m);

%%
M0 =100261034565150078166100198586130653239018486827965443/50904961057501578380068947608259541194799017636224000
 
 
Bw0 =-2843509178746676709420392278703971873026184516453/3181560066093848648754309225516221324674938602264
 
 
Md =-4449981641146391258819581224460674205305916939738340699/2036198442300063135202757904330381647791960705448960000
end
function [] = zakr()
t1=1/2;
t2=1/2;
t3=1/2;
t4=2/2;
t5=1/1;
x1=[t1 10.7]
y1=[t1 t1]
x2=[t2 t2];
y2=[t2 13-t2];
x3=[t2 20.3-0.5];
y3=[13-t3 13-t3];
x4=[t2 20.3-0.5];
y4=[6.5 6.5];
x5=[x4(2) x4(2)];
y5=[y3(2) y4(2)];
%%
figure(29)
gr1(x1,y1);
gr1(x2,y2);
gr1(x3,y3);
gr1(x4,y4);
gr1(x5,y5);
%%
s1=10.7*1;
s2=(13-1*2)*1;
s3=20.3*1;
s4=(20.3-1)*2;
s5=(4.5)*1;
F=s1+s2+s3+s4+s5
Xc1=10.7/2;
Xc2=0.5;
Xc3=20.3/2;
Xc4=(20.3-1)/2+1;
Xc5=(19.8);
Xc=(Xc1*s1+Xc2*s2+Xc3*s3+Xc4*s4+Xc5*s5)/(s1+s2+s3+s4+s5)
Yc1=0.5
Yc2=6.5;
Yc3=13-0.5;
Yc4=6.5;
Yc5=9.75;
Yc=(Yc1*s1+Yc2*s2+Yc3*s3+Yc4*s4+Yc5*s5)/(s1+s2+s3+s4+s5)
Jx1=(10.7*1^3)/(12);
Jx2=(1*((13-2)^3))/12;
Jx3=(20.3*1^3)/12;
Jx4=((20.3-1)*2^3)/12;
Jx5=((1)*4.5^3)/12;
Jx=(Jx1+s1*(Yc1-Yc)^2)+(Jx2+s2*(Yc2-Yc)^2)+(Jx3+s3*(Yc3-Yc)^2)+(Jx4+s4*(Yc4-Yc)^2)+(Jx5+s5*(Yc5-Yc)^2)
Jy1=(10.7^3*1)/(12);
Jy2=(1^3*((13-2)))/12;
Jy3=(20.3^3*1)/12;
Jy4=((20.3-1)^3*2)/12;
Jy5=(1^3*((4.5)))/12;
Jy=(Jy1+s1*(Xc1-Xc)^2)+(Jy2+s2*(Xc2-Xc)^2)+(Jy3+s3*(Xc3-Xc)^2)+(Jy4+s4*(Xc4-Xc)^2)+(Jy5+s5*(Xc5-Xc)^2)
Jxy=s1*(Xc1-Xc)*(Yc1-Yc)+s2*(Xc2-Xc)*(Yc2-Yc)+s3*(Xc3-Xc)*(Yc3-Yc)+s4*(Xc4-Xc)*(Yc4-Yc)+s5*(Xc5-Xc)*(Yc5-Yc)
alfa=atan(2*Jxy/(Jy-Jx))/2
agrad=180*alfa/pi
Ju=(Jx+Jy)/2-sqrt(((Jx-Jy)^2)/4+Jxy^2)
Jv=(Jx+Jy)/2+sqrt(((Jx-Jy)^2)/4+Jxy^2)
%%
figure(30)
hold on;grid on
text(Xc,Yc,'C','linewidth',15)
gr1(x1,y1);
gr1(x2,y2);
gr1(x3,y3);
gr1(x4,y4);
gr1(x5,y5);

%%
u1=x1;
u2=x2;
u3=x3;
u4=x4;
u5=x5;
v1=y1;
v2=y2;
v3=y3;
v4=y4;
v5=y5;
[u1(1),v1(1)]=uv(x1(1),y1(1),Xc,Yc,alfa)
[u1(2),v1(2)]=uv(x1(2),y1(2),Xc,Yc,alfa)
[u2(1),v2(1)]=uv(x2(1),y2(1),Xc,Yc,alfa)
[u2(2),v2(2)]=uv(x2(2),y2(2),Xc,Yc,alfa)
[u3(1),v3(1)]=uv(x3(1),y3(1),Xc,Yc,alfa)
[u3(2),v3(2)]=uv(x3(2),y3(2),Xc,Yc,alfa)
[u4(1),v4(1)]=uv(x4(1),y4(1),Xc,Yc,alfa)
[u4(2),v4(2)]=uv(x4(2),y4(2),Xc,Yc,alfa)
[u5(1),v5(1)]=uv(x5(1),y5(1),Xc,Yc,alfa)
[u5(2),v5(2)]=uv(x5(2),y5(2),Xc,Yc,alfa)
%%
figure(31)
n=20;
m=0.25;
z2=num2str(abs(u1(1)));
z1=num2str(abs(u1(2)));
gr2(x1,y1,u1,0,1,z1,z2,m,n);
%z2=num2str(abs(u2(1)))
%z1=num2str(abs(u2(2)))
z2=' '
z1=' '
gr2(x2,y2,u2,1,1,z1,z2,m,n);
z2=num2str(abs(u3(1)));
z1=num2str(abs(u3(2)));
gr2(x3,y3,u3,0,0,z1,z2,m,n);
z2=num2str(abs(u4(1)));
z1=num2str(abs(u4(2)));
gr2(x4,y4,u4,0,1,z1,z2,m,n);
z1=' ';
z2=' ';
gr2(x5,y5,u5,1 ,0,z1,z2,m,n);
figure(32)
z2=num2str(abs(v1(1)));
z1=num2str(abs(v1(2)));
gr2(x1,y1,v1,0,1,z1,z2,m,n);
z2=' '
z1=' '
%z2=num2str(abs(v2(1)))
%z1=num2str(abs(v2(2)))
gr2(x2,y2,v2,1,1,z1,z2,m,n);
z2=num2str(abs(v3(1)));
z1=num2str(abs(v3(2)));
gr2(x3,y3,v3,0,0,z1,z2,m,n);
z2=num2str(abs(v4(1)));
z1=num2str(abs(v4(2)));
gr2(x4,y4,v4,0 ,1,z1,z2,m,n);
z1=' ';
z2=' ';
gr2(x5,y5,v5,1 ,0,z1,z2,m,n);

%%
figure(33)
gr1(x1,y1);
gr1(x2,y2);
gr1(x3,y3);
gr1(x4,y4);
gr1(x5,y5);
S1=[(x2(1)+x2(2))/2,(y2(1)+y2(2))/2];
O1=S1;
text(S1(1),S1(2),'S1,O1','FontSize', 15)
%%
S=[y4(1) x4(1)]
x21=[x2(1) x2(2)/2]
x22=[x2(2) x2(2)]
y21=[y2(1) y2(2)/2]
y22=[y4(1) y2(2)]
w41=0
w42=0
w52=0
w51=(x4(2)-x4(1))*(y3(2)-y4(1))
w32=w51
w31=w32+(x3(2)-x3(1))*(y3(1)-y4(2))
w222=w31
w221=w222
w122=0
w112=0
w111=0
w11=0
w12=(x1(2)-x1(1))*(y4(1)-y1(1))
%%
figure(34)
m=0.025
W1=[w11 w12]
W2=[0 0]
W22=[w221 w222]
W3=[w31 w32]
W4=[0  0];
W5=[w51 w52]
z2=num2str(abs(W1(1)));
z1=num2str(abs(W1(2)));
gr2(x1,y1,W1,0,1,z1,z2,m,n);
z1=' ';
z2=' ';
gr2(x2,y2,W2,1,1,z1,z2,m,n);
z1=' ';
z2=' ';
gr2(x22,y22,W22,1,1,z1,z2,m,n);
z2=num2str(abs(W3(1)))
z1=num2str(abs(W3(2)))
gr2(x3,y3,W3,0,0,z1,z2,m,n);
z1=' ';
z2=' ';
gr2(x4,y4,W4,0 ,0,z1,z2,m,n);
z2=num2str(abs(W5(1)));
z1=num2str(abs(W5(2)));
gr2(x5,y5,W5,1 ,0,z1,z2,m,n);
%%
Svw13=(x3(2)-x3(1))*(u3(1)*W3(1)+u3(2)*W3(2)+4*(tr(u3))*(os(W3)))/6
Svw14=2*(x4(2)-x1(1))*(u4(1)*W4(1)+u4(2)*W4(2)+4*(tr(u4))*(os(W4)))/6
Svw15=(y3(2)-y4(2))*(W5(1)*u5(1)+W5(2)*u5(2)+4*(os(W5))*(os(u5)))/6
Svw11=(x1(2)-x1(1))*(u1(1)*W1(1)+u1(2)*W1(2)+4*(tr(u1))*(os(W1)))/6
Svw122=(y22(2)-y22(1))*(W22(2)*u2(2)+W22(1)*((u2(2)+u2(1))/2)+4*(W22(1))*(((u2(2)+u2(1))/2)/2))/6
Svw1=Svw11+Svw122+Svw13+Svw14+Svw15
%%
Suw12=0
Suw13=(x3(2)-x3(1))*(v3(1)*W3(1)+v3(2)*W3(2)+4*(os(W3))*(os(v3)))/6
Suw14=2*(x4(2)-x4(1))*(v4(1)*W4(1)+v4(2)*W4(2)+4*((tr(v4))*((W4(2)+W4(1))/2)))/6
Suw15=2*(y3(2)-y4(1))*(v5(1)*W5(1)+v5(2)*W5(2)+4*(tr(v5))*((W5(2)+W5(1))/2))/6
Suw122=(y22(2)-y22(1))*(W22(2)*v2(2)+W22(2)*tr(v2)+4*W22(2)*tr(v2))/6
Suw111=(x1(2)-x1(1))*(v1(1)*W1(1)+v1(2)*W1(2)+4*(os(v1))*((W1(2)+W1(1))/2))/6
Suw11=Suw122+Suw12+Suw13+Suw14+Suw15+Suw111

%%
au1=Suw11/Ju
av1=-Svw1/Jv
ax1=au1*cos(alfa)-av1*sin(alfa)
ay1=au1*sin(alfa)+av1*cos(alfa)
S=[x4(1) y4(1)]
A1=[ax1+S(1) ay1+S(2)]
figure(35)
hold on; grid on
text(A1(1),A1(2),'A','FontSize', 15)
%%
S2=[x3(1) y3(1)]
x21=[x2(1) x2(2)/2]
x22=[x2(2) x2(2)]
y21=[y2(1) y2(2)/2]
y22=[y2(2)/2 y2(2)]
w22=0
w21=0
w41=0
w42=(x4(2)-x4(1))*(y3(1)-y4(2))
w52=w42
w51=w52+(x4(2)-x4(1))*(y3(1)-y4(2))
w32=w51
w31=w32
w11=w22
w12=(y2(2)-y2(1))*(x1(2)-x1(1))
%%
figure(40)
W1=[w11 w12]
W2=[w21 w22]
W3=[w31 w32]
W4=[w41  w42];
W5=[w51 w52]
z2=num2str(abs(W1(1)));
z1=num2str(abs(W1(2)));
gr2(x1,y1,W1,0,1,z1,z2,m,n);
z1=' ';
z2=' ';
gr2(x2,y2,W2,1,1,z1,z2,m,n);
z2=num2str(abs(W3(1)));
z1=num2str(abs(W3(2)));
gr2(x3,y3,W3,0,0,z1,z2,m,n);
z2=num2str(abs(W4(1)));
z1=num2str(abs(W4(2)));
gr2(x4,y4,W4,0 ,1,z1,z2,m,n);
gr2(x5,y5,W5,1 ,0,z1,z2,m,n);
%%
Svw11=(x1(2)-x1(1))*(u1(1)*W1(1)+u1(2)*W1(2)+4*(tr(u1))*((W1(2)+W1(1))/2))/6
Svw13=(x3(2)-x3(1))*(u3(1)*W3(1)+u3(2)*W3(2)+4*(tr(u3))*((W3(2)+W3(1))/2))/6
Svw14=2*(x4(2)-x1(1))*(u4(1)*W4(1)+u4(2)*W4(2)+4*(tr(u4))*((W4(2)+W4(1))/2))/6
Svw15=(y3(2)-y4(2))*(W5(1)*u5(1)+W5(2)*u5(2)+4*((W5(1)+W5(2))/2)*((u5(1)+u5(2))/2))/6
Svw1=Svw11+Svw13+Svw14+Svw15
%%
Suw12=0
Suw13=(x3(2)-x3(1))*(v3(1)*W3(1)+v3(2)*W3(2)+4*((v3(2)+v3(1))/2)*((W3(2)+W3(1))/2))/6
Suw14=2*(x4(2)-x4(1))*(v4(1)*W4(1)+v4(2)*W4(2)+4*((v4(2)-v4(1))/2+v4(1))*((W4(2)+W4(1))/2))/6
Suw15=(y3(2)-y4(1))*(v5(1)*W5(1)+v5(2)*W5(2)+4*((v5(2)-v5(1))/2+v5(1))*((W5(2)+W5(1))/2))/6
Suw111=(x1(2)-x1(1))*(v1(1)*W1(1)+v1(2)*W1(2)+4*((v1(2)+v1(1))/2)*((W1(2)+W1(1))/2))/6
Suw11=+Suw12+Suw13+Suw14+Suw15+Suw111

%%
au1=Suw11/Ju
av1=-Svw1/Jv
ax2=au1*cos(alfa)-av1*sin(alfa)
ay2=au1*sin(alfa)+av1*cos(alfa)
A=[ax2+S2(1) ay2+S2(2)]
%%
figure(41)
gr1(x1,y1);
gr1(x2,y2);
gr1(x3,y3);
gr1(x4,y4);
gr1(x5,y5);
axis([-8 22.5 -2 18])
text(A(1),A(2),'A','FontSize', 10)
text(A1(1),A1(2),'A1','FontSize', 10)
end
function [C] = c(ksi)
global G Jk Jw k E
C=[ 1 sinh(ksi) -(cosh(ksi)-1)/(k^2*E*Jw) (-sinh(ksi)+ksi)/(k*G*Jk)
    0 cosh(ksi) -(sinh(ksi))/(k^2*E*Jw) (-cosh(ksi)+1)/(k*G*Jk)
    0 -G*Jk*sinh(ksi) cosh(ksi) sinh(ksi)/k
    0 -G*Jk*k*cosh(ksi) k*sinh(ksi) cosh(ksi)];
end
function [sr] = tr(u)
sr=(u(2)-u(1))/2+u(1);
end
function [sr] = os(u)
sr=(u(1)+u(2))/2;
end
function [Uh] = uh(ksi,m)
  global G Jk k
  Uh=[m*(1-cosh(ksi)+((ksi)^2)/2)/(G*Jk*k^2)
      m*(-sinh(ksi)+ksi)/(G*Jk*k^2)
      -m*(-cosh(ksi)+1)/k^2
      m*sinh(ksi)/k];
end
function x = gr1(x,y)
  line([x(1) x(2)],[y(1) y(2)]);
  hold on;grid on
end
function x = gr2(x,y,u,i,j,g1,g2,m,n)
u=u*m;
line([x(1) x(2)],[y(1) y(2)],'LineWidth',4);
if(j==1)
u=-u;
end
if(i==1)  
 line([(x(1)+u(1)) (x(2)+u(2))],[(y(1)) (y(2))]);
 k=1;
 l=1;
 z1=y(1);
 z2=x(1)+u(1);
 if(z2<x(1))
  
 end
 text(z1,z2,g2,'FontSize', 12)
 while k<=n;
 z1=x(1)+u(1)+k*(((u(2))-(u(1))))/n;
 z2=y(1)+(k*((y(2))-(y(1)))/(n));
 
 line([z1 x(1)],[z2 z2]);
 k=k+1;
 end

end
if(i==0)
 line([(x(1)) x(2)],[(y(1)+u(1)) (y(2))+u(2)]);
 k=1;
 z1=x(1);
 z2=y(1)+u(1);
 line([z1 z1],[y(1) z2])
 text(z1,z2,g2,'FontSize', 12)
 l=1;
 
 while k<=n;
 z1=x(1)+abs(k*((x(2)-x(1))/(n)));
 
 z2=y(1)+u(1)+k*(u(2)-u(1))/n;
 if(l==0)
     z2=-(y(1)+u(1)+k*abs(((u(1))-(u(2))))/n);
 end
 line([z1 z1],[y(1) z2]);
 k=k+1;
 end
 text(z1,z2,g1,'FontSize', 12)
end    

  hold on;grid on

end
function [U,V] = uv(x,y,Xc,Yc,alfa)
  U=(x-Xc)*cos(alfa)+(y-Yc)*sin(alfa);
  V=-(x-Xc)*sin(alfa)+(y-Yc)*cos(alfa);
end
function w = W(S,O,r)

 w=(S(1)-r(1))*(S(2)-r(2));
end
function S = simp(w,u,l)
S=l*(w(1)*u(1)+4*((u(1)+u(2))/2-u(2))*((w(1)+w(2))/2-w(1))+w(2)*u(2));
end
function [x,y] = inv(x,y)
n=length(x)
i=1;
x1=x;
y1=y;
while i<=n/2
 x(i)=x(n-i+1);
 x(n-i+1)=x1(i);
 y(i)=y(n-i+1);  
 y(n-i+1)=y1(i);
 i=i+1;
end
end
function x = mm(x,M,m)
n=length(x);
i=1;
x;
M;
while i<n
z1=[x(i) x(i+1)];
z2=-[M(i) M(i+1)];
z3=[0 0];
b='';
m=1;
l=1;
gr2(z1,z3,z2,0,1,b,b,m,l);
i=i+1;
end
end
function  x= ras(x,y)
n=length(x);
i=1;
while i<=n
line([(x(i)) x(i)],[y(1) y(2)],'Color','k','LineWidth',2);
   i=i+1;
end
end

