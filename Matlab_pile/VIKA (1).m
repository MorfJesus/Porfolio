clear

syms M0 Bw0 Md dM2
%% Матрица U при ksi=2

global G Jk Jw k E

Jk = 87.2;
Jw = 79602.4;
E = 70*10^9;
G = E/(2*(1+0.3));
k = sqrt(G*Jk/(E*Jw));

m1 = 535*10^-3;
m2 = 154.4*10^-3;

dM1 = 31.36*10^-3;
%dM2 = 0;
dM3 = -96.18*10^-3;
M = -32.87*10^-3;
Bwk = 51.43*10^(-1)*10^-3;

ksi1 = k*1
ksi2 = k*2
ksi3 = k*3
ksi4 = k*4

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
    dM2];

dV3 = [0
    0
    0
    dM3];

U2=c(ksi2)*V0+uh(ksi2,m1)+c((ksi2-ksi1))*dV1+uh((ksi2-ksi1),(-m1))

%% Матрица U при ksi=4

U4=c(ksi4)*V0+uh(ksi4,m1)+c((ksi4-ksi1))*dV1+uh((ksi4-ksi1),(-m1))+c((ksi4-ksi2))*dV2+uh((ksi4-ksi2),(m2))+c((ksi4-ksi3))*dV3+uh((ksi4-ksi3),(-m2))

R=[U2(1)

U4(3)

U4(4)]

RR=[0

Bwk

M]

A=R-RR


%% Решим полученную систему при помощи функции solve

[M0,Bw0,dM2]=solve(A==0,M0,Bw0,dM2);
M0 = double(M0)
Bw0 = double(Bw0)
dM2 = double(dM2)

%{
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
    dM2];

dV3 = [0
    0
    0
    dM3];

c(ksi1)*V0+uh((ksi1),(m1))
c(ksi2)*V0+uh(ksi2,m1)+c((ksi2-ksi1))*dV1+uh((ksi2-ksi1),(-m1))
U4=c(ksi4)*V0+uh(ksi4,m1)+c((ksi4-ksi1))*dV1+uh((ksi4-ksi1),(-m1))+c((ksi4-ksi2))*dV2+uh((ksi4-ksi2),(m2))+c((ksi4-ksi3))*dV3+uh((ksi4-ksi3),(-m2))

%Функция для задания матрици С


%Функция для задания матрици частного решения

%ksi = 0:step:ksi4;


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
    dM2];

dV3 = [0
    0
    0
    dM3];

%
%
%
%U4 = c(ksi).*V0+uh((ksi),(m1)) + c(ksi-ksi1).*dV1 + uh((ksi-ksi1), -m1) + c(ksi-ksi2).*dV2 + uh((ksi-ksi2), m2) + c(ksi-ksi3).*dV3 + uh((ksi-ksi3), -m2);

step = 0.001;

for ksi = 0:step:ksi1
    
U1 = c(ksi)*V0+uh((ksi),(m1));
UPhi(floor(ksi*(1/step) +1)) = U1(1);
UPhiS(floor(ksi*(1/step) +1)) = U1(2) ;
UB(floor(ksi*(1/step) +1)) = U1(3);
UM(floor(ksi*(1/step) +1)) = U1(4);

end
%{
for ksi = 0:step:ksi1
    UM(floor(ksi*(1/step) +1)) = UMN(1)+(UMN(floor(ksi1*(1/step) +1))-UMN(1))*(ksi/ksi1);
end
%}
for ksi = ksi1:step:ksi2
U2 = c(ksi)*V0+uh((ksi),(m1)) + c(ksi-ksi1)*dV1 + uh((ksi-ksi1), -m1);
UPhi(floor(ksi*(1/step) +1)) = U2(1);
UPhiS(floor(ksi*(1/step) +1)) = U2(2) ;
UB(floor(ksi*(1/step) +1)) = U2(3);
UM(floor(ksi*(1/step) +1)) = U2(4);
end
%{
for ksi = ksi1:step:ksi2
    UM(floor(ksi*(1/step) +1)) = UMN(floor(ksi1*(1/step) +1));
end
%}
for ksi = ksi2:step:ksi3
U3 = c(ksi)*V0+uh((ksi),(m1)) + c(ksi-ksi1)*dV1 + uh((ksi-ksi1), -m1) + c(ksi-ksi2)*dV2 + uh((ksi-ksi2), m2);
%c(ksi4)*V0+uh(ksi4,m1)+c((ksi4-ksi1))*dV1+uh((ksi4-ksi1),(-m1))+c((ksi4-ksi2))*dV2+uh((ksi4-ksi2),(m2))+c((ksi4-ksi3))*dV3+uh((ksi4-ksi3),(-m2));
UPhi(floor(ksi*(1/step) +1)) = U3(1);
UPhiS(floor(ksi*(1/step) +1)) = U3(2) ;
UB(floor(ksi*(1/step) +1)) = U3(3);
UM(floor(ksi*(1/step) +1)) = U3(4);
end
%{
for ksi = ksi2:step:ksi3
    ksi
    UM(floor(ksi*(1/step) +1)) = UMN(floor(ksi2*(1/step) +1))-28.6526+(UMN(floor(ksi3*(1/step) +1))+16.45-UMN(floor(ksi2*(1/step) +1)))*((ksi-ksi2)/(ksi3-ksi2));
end
%}
for ksi = ksi3:step:ksi4
U4=c(ksi)*V0+uh((ksi),(m1)) + c(ksi-ksi1)*dV1 + uh((ksi-ksi1), -m1) + c(ksi-ksi2)*dV2 + uh((ksi-ksi2), m2)+c((ksi-ksi3))*dV3+uh((ksi-ksi3),(-m2));
UPhi(floor(ksi*(1/step) +1)) = U4(1);
UPhiS(floor(ksi*(1/step) +1)) = U4(2) ;
UB(floor(ksi*(1/step) +1)) = U4(3);
UM(floor(ksi*(1/step) +1)) = U4(4);
end
%{
for ksi = ksi3:step:ksi4
    UM(floor(ksi*(1/step) +1)) = UMN(floor(ksi3*(1/step) +1));
end
%}
%UP(4);
ksi = 0:step:ksi4-step;
ksi4 = ksi4 - step
length(UPhi)
length(ksi)
Mk = G*Jk*k*UPhiS;
%Mk = [Mk(1) Mk(1:end)];
Mw = UM;
%MyPlot(Mw, ksi4, step)
%Mw = diff(Mw)./diff(ksi);
%Mw = [Mw(1:end) Mw(end)+(Mw(end)-Mw(end-1))];
MyPlot(Mk, ksi4, step)
MyPlot(Mw, ksi4, step)
MyPlot(UPhi, ksi4, step)
%MyPlot(UPhi, ksi4, step)
MyPlot(UPhiS, ksi4, step)
MyPlot(UB, ksi4, step)
MyPlot(UM, ksi4, step)


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

%}
