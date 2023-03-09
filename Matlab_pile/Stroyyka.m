clear

syms M0 Bw0 Md

global G Jk Jw k E l ksi1 ksi2 ksi3 ksi4 V0 dV1 dV2 dV3

Jk = 164.692*10^-8;
Jw = 487840*10^-12;
E = 70*10^9;
G = E/(2*(1+0.3));
k = sqrt((G*Jk)/(E*Jw))
l = 1.2;
ksi1 = 0.5*l*k;
ksi2 = 1*l*k
ksi3 = 1.5*l*k;
ksi4 = 2*l*k;

2.05108/k
m = -481.5;

dM1 = -259.83;

M2 = -314.2;
Bwk = -10.12;


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


U2 = UU2(ksi2, 0, 0)

U3 = UU3(ksi3, 0, 0, m)

R=[U2(1)

U3(3)

U3(4)+G*Jk*U3(2)];

RR=[0

Bwk

M2];

A=R-RR;

[M0,Bw0,Md]=solve(A==0,M0,Bw0,Md);
M0 = double(M0)
Bw0 = double(Bw0)
Md = double(Md)

V0 = double(subs(V0));
dV1 = double(subs(dV1));
dV2 = double(subs(dV2));
dV3 = double(subs(dV3));

step = ksi1/10;

i = 1;
ksiO = 0;
for ksi = 0:step:ksi1
    U1 = UU1(ksi, 0);
    UPhi(i) = U1(1);
    UPhiS(i) = U1(2);
    UB(i) = U1(3);
    UM(i) = U1(4);
    i = i+1;
    ksiO = [ksiO ksi];
end

for ksi = ksi1:step:ksi2
    U2 = UU2(ksi, 0, 0);
    UPhi(i) = U2(1);
    UPhiS(i) = U2(2);
    UB(i) = U2(3);
    UM(i) = U2(4);
    i = i+1;
    ksiO = [ksiO ksi];
end



for ksi = ksi2:step:ksi3
    U3 = UU3(ksi, 0, 0, m);
    UPhi(i) = U3(1);
    UPhiS(i) = U3(2);
    UB(i) = U3(3);
    UM(i) = U3(4);
    i = i+1;
    ksiO = [ksiO ksi];
end

for ksi = ksi3:step:ksi4
    U4 = UU4(ksi, m1, -m1, m2, -m2);
    UPhi(i) = U4(1);
    UPhiS(i) = U4(2);
    UB(i) = U4(3);
    UM(i) = U4(4);
    i = i+1;
    ksiO = [ksiO ksi];
end

ksiO = ksiO(2:end);

Mk = UPhiS*G*Jk;
Mw = UM + Mk;

MyPlot2(UPhi, ksiO, '\phi')
MyPlot2(UPhiS, ksiO, 'd\phi/d\xi')
MyPlot2(UB, ksiO, 'B')
MyPlot2(UM, ksiO, 'Mw')

MyPlot2(Mk, ksiO, 'Mk')
MyPlot2(Mw, ksiO, 'M')


function MyPlot2(U, ksiO, lab)
    figure()
    hold on
    k = 1;
    for i = ksiO
        plot([i i], [U(k) 0], 'black');
        k=k+1;
    end
    plot([0 ksiO(end)], [0 0], 'linewidth', 2, 'color', 'black');

    plot(ksiO, U, 'color', 'black', 'linewidth', 2)
    xlim([0 ksiO(end)])
    hold off
    grid on
    xlabel('\xi')
    ylabel(lab)
end





function U = UU1(ksi, mom1)
global V0
    U = C(ksi)*V0+Uh(ksi, mom1);
end

function U = UU2(ksi, mom1, mom2)
global ksi1 dV1
    U = UU1(ksi, mom1)+C(ksi-ksi1)*dV1+Uh(ksi-ksi1, mom2);
end

function U =  UU3(ksi, mom1, mom2, mom3)
global ksi2 dV2
    U = UU2(ksi, mom1, mom2)+C(ksi-ksi2)*dV2+Uh(ksi-ksi2, mom3);
end

function U = UU4(ksi, mom1, mom2, mom3, mom4)
global ksi3 dV3
    U = UU3(ksi, mom1, mom2, mom3)+C(ksi-ksi3)*dV3+Uh(ksi-ksi3, mom4);
end


function [C] = C(ksi)
global G Jk Jw k E
C=[ 1 sinh(ksi)         -(cosh(ksi)-1)./(G.*Jk)   -(sinh(ksi)-ksi)./(k.*G.*Jk)

    0 cosh(ksi)         -(sinh(ksi))./(G.*Jk)      (-cosh(ksi)+1)./(k.*G.*Jk)

    0 -G.*Jk.*sinh(ksi)   cosh(ksi)                     sinh(ksi)./k

    0 -G.*Jk.*k.*cosh(ksi) k.*sinh(ksi)                 cosh(ksi)];

end

function [Uh] = Uh(ksi,m)
global G Jk k
Uh=[m.*(1-cosh(ksi)+(ksi.^2)./2)./(G.*Jk.*k.^2)

    m.*(-sinh(ksi)+ksi)/(G.*Jk.*k.^2)

    -m.*(-cosh(ksi)+1)./k.^2

    m.*sinh(ksi)./k];

end

%{
function [C] = C(ksi)
global G Jk Jw k E
C=[ 1 sinh(ksi)         -(cosh(ksi)-1)./(k.^2.*E.*Jw)   -(sinh(ksi)-ksi)./(k.*G.*Jk)

    0 cosh(ksi)         -(sinh(ksi))./(k.^2*E.*Jw)      (-cosh(ksi)+1)./(k.*G.*Jk)

    0 -G.*Jk.*sinh(ksi)   cosh(ksi)                     sinh(ksi)./k

    0 -G.*Jk.*k.*cosh(ksi) k.*sinh(ksi)                 cosh(ksi)];

end
%}
