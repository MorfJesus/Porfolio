clear
close all
syms M0 Bw0 Md
%% Матрица U при ksi=2

global G Jk Jw k E

Jk = 68.8;
Jw = 46041;
E = 0.7*10^9;
G = 2.7*10^10;
k = sqrt((G*Jk)/(E*Jw))

M = 280*10^-3;
m1 = 27.5*10^-3;
m2 = 3.2*10^-3;
m3 = 250*10^-3;

dM1 = -93*10^-3;
dM2 = 0.078;
M3 = -280*10^-3;

Bwk = 0.41;

ksi1 = 0.7*k;
ksi2 = 0.7*2*k;
ksi3 = 0.7*3*k;
ksi4 = 0.7*4*k;

V0 = [0
    0
    Bw0
    M0];

dV1 = [0
    0
    0
    dM1];

dV2 = [0
    0
    0
    Md];

dV3 = [0
    0
    0
    dM2];

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

[M0,Bw0,Md]=solve(A==0,M0,Bw0,Md);
M0 = double(M0)
Bw0 = double(Bw0)
Md = double(Md)

%Jk = 87.2*10^-8;
%Jw = 79602.4^10-12;

V0 = [0
    0
    Bw0
    M0];

dV1 = [0
    0
    0
    dM1];

dV2 = [0
    0
    0
    Md];

dV3 = [0
    0
    0
    dM2];

c(ksi1)*V0+uh((ksi1),(m1));
c(ksi2)*V0+uh(ksi2,m1)+c((ksi2-ksi1))*dV1+uh((ksi2-ksi1),(-m1));
U4=c(ksi4)*V0+uh(ksi4,m1)+c((ksi4-ksi1))*dV1+uh((ksi4-ksi1),(-m1))+c((ksi4-ksi2))*dV2+uh((ksi4-ksi2),(m2))+c((ksi4-ksi3))*dV3+uh((ksi4-ksi3),(-m2));

%Функция для задания матрици С


%Функция для задания матрици частного решения



%U1 = c(ksi).*V0+uh((ksi),(m1));

%U2 = c(ksi).*V0+uh((ksi),(m1)) + c(ksi-ksi1).*dV1 + uh((ksi-ksi1), -m1);
%U3 = c(ksi).*V0+uh((ksi),(m1)) + c(ksi-ksi1).*dV1 + uh((ksi-ksi1), -m1) + c(ksi-ksi2).*dV2 + uh((ksi-ksi2), m2);
%U4 = c(ksi).*V0+uh((ksi),(m1)) + c(ksi-ksi1).*dV1 + uh((ksi-ksi1), -m1) + c(ksi-ksi2).*dV2 + uh((ksi-ksi2), m2) + c(ksi-ksi3).*dV3 + uh((ksi-ksi3), -m2);

V0 = [0
    0
    Bw0
    M0];

dV1 = [0
    0
    0
    dM1];

dV2 = [0
    0
    0
    Md];

dV3 = [0
    0
    0
    dM2];

%
%
%
%U4 = c(ksi).*V0+uh((ksi),(m1)) + c(ksi-ksi1).*dV1 + uh((ksi-ksi1), -m1) + c(ksi-ksi2).*dV2 + uh((ksi-ksi2), m2) + c(ksi-ksi3).*dV3 + uh((ksi-ksi3), -m2);

step = k*0.7/10;
ksiO = 0;
for ksi = 0:step:ksi1
U1 = c(ksi)*V0+uh((ksi),(m1));
UPhi(floor(ksi*(1/step) +1)) = U1(1);
UPhiS(floor(ksi*(1/step) +1)) = U1(2);
UB(floor(ksi*(1/step) +1)) = U1(3);
UM(floor(ksi*(1/step) +1)) = U1(4);
ksiO = [ksiO ksi];
end
ksiO = ksiO(2:end);
for ksi = ksi1:step:ksi2
U2 = c(ksi)*V0+uh((ksi),(m1)) + c(ksi-ksi1)*dV1 + uh((ksi-ksi1), -m2-m1);
UPhi(floor(ksi*(1/step) +2)) = U2(1);
UPhiS(floor(ksi*(1/step) +2)) = U2(2);
UB(floor(ksi*(1/step) +2)) = U2(3);
UM(floor(ksi*(1/step) +2)) = U2(4);
ksiO = [ksiO ksi];
end

for ksi = ksi2:step:ksi3
U3 = c(ksi)*V0+uh((ksi),(m1)) + c(ksi-ksi1)*dV1 + uh((ksi-ksi1), -m2-m1) + c(ksi-ksi2)*dV2 + uh((ksi-ksi2), m2);
%c(ksi4)*V0+uh(ksi4,m1)+c((ksi4-ksi1))*dV1+uh((ksi4-ksi1),(-m1))+c((ksi4-ksi2))*dV2+uh((ksi4-ksi2),(m2))+c((ksi4-ksi3))*dV3+uh((ksi4-ksi3),(-m2));
UPhi(floor(ksi*(1/step) +3)) = U3(1);
UPhiS(floor(ksi*(1/step) +3)) = U3(2);
UB(floor(ksi*(1/step) +3)) = U3(3);
UM(floor(ksi*(1/step) +3)) = U3(4);
ksiO = [ksiO ksi];
end

for ksi = ksi3:step:ksi4
U4=c(ksi)*V0+uh((ksi),(m1)) + c(ksi-ksi1)*dV1 + uh((ksi-ksi1), -m2-m1) + c(ksi-ksi2)*dV2 + uh((ksi-ksi2), m2)+c((ksi-ksi3))*dV3+uh((ksi-ksi3),(m3));
UPhi(floor(ksi*(1/step) +4)) = U4(1);
UPhiS(floor(ksi*(1/step) +4)) = U4(2);
UB(floor(ksi*(1/step) +4)) = U4(3);
UM(floor(ksi*(1/step) +4)) = U4(4);
ksiO = [ksiO ksi];
end
length(ksiO)
length(UM)
Mk = G*Jk*k*UPhiS;
MyPlot2(UPhi, ksiO)
MyPlot2(UPhiS, ksiO)
MyPlot2(UB, ksiO)
MyPlot2(UM, ksiO)
%MyPlot2(Mk, ksiO)
%MyPlot2(Mk-M, ksiO)

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

%{
UPhiS
%UP(4);
ksi = 0:step:ksi4-step;
ksi4=ksi4-step;

for i=1:floor((0.04)/step)
    UB(i) = 212.625*((i-1)*step)^2+Bw0;
end 

Mk = G*Jk*k*UPhiS;
Mw = diff(-Mk)./diff(ksi);
Mw = [Mw(1) Mw(1:end)];
%MyPlot(Mw, ksi4, step)
Mw = diff(Mw)./diff(ksi);
Mw = [Mw(1:end) Mw(end)+(Mw(end)-Mw(end-1))];
MyPlot(Mk, ksi4, step)
MyPlot(Mw, ksi4, step)
%MyPlot(UPhi, ksi4, step)
MyPlot(UPhi, ksi4, step)
MyPlot(UPhiS, ksi4, step)
MyPlot(UB, ksi4, step)

%}

function MyPlot(U, ksi4, step)
figure()
hold on
for i = 1:length(U)
    plot([(i-1)*step (i-1)*step], [U(i) 0], 'black');
end
plot([0 ksi4], [0 0], 'linewidth', 2, 'color', 'black');
ksi = 0:step:ksi4;
length(ksi)
plot(ksi, U, 'color', 'black', 'linewidth', 2)
hold off
grid on
end


