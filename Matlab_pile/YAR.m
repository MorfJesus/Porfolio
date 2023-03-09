syms M0 Bw0 Md
%% Матрица U при ksi=2

global G Jk Jw k E

k = 0.024;
G = 2.7*10^10;
Jk = 68.8*10^-8;
Jw = 46041*10^-12;
E = 7.02*10^10;
Bwk = 0.41;

m1 = 0.0275*10^3;
m2 = 0.0032*10^3;
m3 = 0.25*10^3;

M1 = -0.093*10^3;
M2 = 0.078*10^3;
M3 = -0.28*10^3;

ksi1 = 1;
ksi2 = 2;
ksi3 = 3;
ksi4 = 4;

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
    dM3];

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
M0 = double(M0)/10^3
Bw0 = double(Bw0)/10^3
Md = double(Md)/10^3

%Функция для задания матрици С


%Функция для задания матрици частного решения

