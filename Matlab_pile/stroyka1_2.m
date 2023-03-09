M1 = 160.33*10^-3;
M2 = -162.9*10^-3;
P = 1.6;
q = 2;
x = 0:0.1:2.4;

Jx = 5140*10^-8;
Jy = 22037*10^-8;
%{%}
x1 = x(1:13)
mom1 = M1-3/4*P.*x1-q.*(x1.^2)/2;

x2 = x(13:19)
mom2 = M1-3/4*P.*x2-q*1.2.*(x2+0.6-1.2);
x3 = x(19:end)
mom3 = M1-3/4*P.*x3-q*1.2.*(x3+1.2-1.8)+4/3*P.*(x3-1.8);
mom = [mom1 mom2 mom3];
mom = fliplr(mom);
x1 = 0:0.1:0.6;
x2 = 0.6:0.1:1.2;
x3 = 1.2:0.1:2.4;
mom1 = fliplr(mom1);
mom2 = fliplr(mom2);
mom3 = fliplr(mom3);
X = [x1 x2 x3]
MOMP = [mom3 mom2 mom1]
%plot(X, MOM)

MyPlot2(MOMP, X)
xlim([0, x(end)])
xlabel("z")
ylabel("Mp")


MOM1 = 1.2-X;
MOM1(14:end) = 0.*X(14:end);
MyPlot2(MOM1, X)
xlim([0, x(end)])
xlabel("z")
ylabel("M1")
X(1)
X(7)
X(14)
X(21)
X(27)
X(11)


deltP = S_int2(MOM1, MOMP, Jx)
delt1 = S_int2(MOM1, MOM1, Jx)
R = -deltP/delt1

MOMX = MOM1.*R+MOMP;
MyPlot2(MOMX, X)
xlim([0, x(end)])
xlabel("z")
ylabel("Mx")


x1 = x(1:13)
mom1 = M2+q.*(x1.^2)/2;

x2 = x(13:19)
mom2 = M2+q*1.2.*(x2+0.6-1.2);
x3 = x(19:end)
mom3 = M2+q*1.2.*(x3+1.2-1.8)-3/5*P.*(x3-1.8);
mom = [mom1 mom2 mom3];
mom = fliplr(mom);
x1 = 0:0.1:0.6;
x2 = 0.6:0.1:1.2;
x3 = 1.2:0.1:2.4;
mom1 = fliplr(mom1);
mom2 = fliplr(mom2);
mom3 = fliplr(mom3);
X = [x1 x2 x3]
MOMP = [mom3 mom2 mom1]
%plot(X, MOM)

MyPlot2(MOMP, X)
xlim([0, x(end)])
xlabel("z")
ylabel("Mp")


MOM1 = 1.2-X;
MOM1(14:end) = 0.*X(14:end);
MyPlot2(MOM1, X)
xlim([0, x(end)])
xlabel("z")
ylabel("M1")


deltP = S_int2(MOM1, MOMP, Jx)
delt1 = S_int2(MOM1, MOM1, Jx)
R = -deltP/delt1

MOMY = MOM1.*R+MOMP;
MyPlot2(MOMY, X)
xlim([0, x(end)])
xlabel("z")
ylabel("My")
alpha = 0.07616
MOMU = MOMX*cos(alpha)+MOMY*sin(alpha);
MOMV = -MOMX*sin(alpha)+MOMY*cos(alpha);
MyPlot2(MOMU, X)
xlim([0, x(end)])
xlabel("z")
ylabel("Mu")
MyPlot2(MOMV, X)
xlim([0, x(end)])
xlabel("z")
ylabel("Mv")
function res = S_int2(MOM1, MOM2, J)
    E=70*10^9;
    res = 6*0.6/(E*J)*(MOM1(1)*MOM2(1)+4*MOM1(4)*MOM2(4)+MOM1(7)*MOM2(7));
    res = res + 6*0.6/(E*J)*(MOM1(7)*MOM2(7)+4*MOM1(11)*MOM2(11)+MOM1(14)*MOM2(14));
    res = res + 6*1.2/(E*J)*(MOM1(14)*MOM2(14)+4*MOM1(21)*MOM2(21)+MOM1(27)*MOM2(27));
end


function MyPlot2(U, ksiO)
figure()
hold on
k = 1;
for i = ksiO
    plot([i i], [U(k) 0], 'black');
    k=k+1;
end
plot([0 ksiO(end)], [0 0], 'linewidth', 2, 'color', 'black');
%ksi = 0:step:ksi4;
%length(ksi)
plot(ksiO, U, 'color', 'black', 'linewidth', 2)
hold off
grid on
end