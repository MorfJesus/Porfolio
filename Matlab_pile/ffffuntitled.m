clear
p = 7.8*10^3;
L = 9;
L1 = 3;
E = 2*10^11;
I = 572*10^-8;
EI = E*I;
A = 17.4*10^(-4);
C = [12*EI/(L1^3)  0
     0  0];
zerosM = [0 0
         0 0];
K11 = [12*EI/L1^3 6*EI/L1^2
       6*EI/L1^2  4*EI/L1];
K12 = [-12*EI/L1^3 6*EI/L1^2
       -6*EI/L1^2  2*EI/L1];
K21 = [-12*EI/L1^3 -6*EI/L1^2
       6*EI/L1^2  2*EI/L1];
K22 = [12*EI/L1^3 -6*EI/L1^2
       -6*EI/L1^2  4*EI/L1];
M11 = [156      22*L1
       22*L1    4*L1^2];
M12 = [54      -13*L1
       13*L1   -3*L1^2];
M21 = [54      13*L1
       -13*L1   -3*L1^2];
M22 = [156      -22*L1
       -22*L1    4*L1^2];
M = p*A*L1/420*[M11    M12     zerosM   zerosM       zerosM   zerosM   zerosM
     M21    M22+M11 M12     zerosM       zerosM   zerosM   zerosM
     zerosM  M21     M22+M11 M12         zerosM   zerosM   zerosM
     zerosM  zerosM   M21     M22+M11   M12     zerosM   zerosM
     zerosM  zerosM   zerosM   M21         M22+M11 M12     zerosM
     zerosM  zerosM   zerosM   zerosM       M21     M22+M11 M12
     zerosM  zerosM   zerosM   zerosM       zerosM   M21     M22]
K = [K11    K12     zerosM   zerosM       zerosM   zerosM   zerosM
     K21    K22+K11 K12     zerosM       zerosM   zerosM   zerosM
     zerosM  K21     K22+K11 K12         zerosM   zerosM   zerosM
     zerosM  zerosM   K21     K22+K11   K12     zerosM   zerosM
     zerosM  zerosM   zerosM   K21         K22+K11 K12     zerosM
     zerosM  zerosM   zerosM   zerosM       K21     K22+K11 K12
     zerosM  zerosM   zerosM   zerosM       zerosM   K21     K22]
K([1],:)=[];
K(:,[1])=[]; 
M([1],:)=[];
M(:,[1])=[]; 
K;
M;
length(K)
[V, D] = eig(K, M);
V1 = [0 V(1:13, 1)']
V2 = [0 V(1:13, 2)']
V3 = [0 V(1:13, 3)']
omega1 = sqrt(D(1, 1)) 
omega2 = sqrt(D(2, 2)) 
omega3 = sqrt(D(3, 3))

X = (0:0.01:L1);
N1=1-3*X.^2/L1^2+2*X.^3/L1^3;
N2=X-2*X.^2/L1+X.^3/L1^2;
N3=3*X.^2/L1^2-2*X.^3/L1^3;
N4=-X.^2/L1+X.^3/L1^2;

W1 = N1*V1(1)+N2*V1(2)+N3*V1(3)+N4*V1(4);
W2 = N1*V1(3)+N2*V1(4)+N3*V1(5)+N4*V1(6);
W3 = N1*V1(5)+N2*V1(6)+N3*V1(7)+N4*V1(8);
W4 = N1*V1(7)+N2*V1(8)+N3*V1(9)+N4*V1(10);
W5 = N1*V1(9)+N2*V1(10)+N3*V1(11)+N4*V1(12);
W6 = N1*V1(11)+N2*V1(12)+N3*V1(13)+N4*V1(14);
figure(1)
plot(X, W1, X+L1, W2, X+2*L1, W3, X+3*L1, W4, X+4*L1, W5, X+5*L1, W6)
title("Форма изгибных колебаний первой частоты колебания");
grid on
xlim([0, 6*L1])
ylim([-0.15, 0.15])

W1 = N1*V2(1)+N2*V2(2)+N3*V2(3)+N4*V2(4);
W2 = N1*V2(3)+N2*V2(4)+N3*V2(5)+N4*V2(6);
W3 = N1*V2(5)+N2*V2(6)+N3*V2(7)+N4*V2(8);
W4 = N1*V2(7)+N2*V2(8)+N3*V2(9)+N4*V2(10);
W5 = N1*V2(9)+N2*V2(10)+N3*V2(11)+N4*V2(12);
W6 = N1*V2(11)+N2*V2(12)+N3*V2(13)+N4*V2(14);
figure(2)
plot(X, W1, X+L1, W2, X+2*L1, W3, X+3*L1, W4, X+4*L1, W5, X+5*L1, W6)
title("Форма изгибных колебаний второй частоты колебания");
grid on
xlim([0, 6*L1])
ylim([-0.15, 0.15])

W1 = N1*V3(1)+N2*V3(2)+N3*V3(3)+N4*V3(4);
W2 = N1*V3(3)+N2*V3(4)+N3*V3(5)+N4*V3(6);
W3 = N1*V3(5)+N2*V3(6)+N3*V3(7)+N4*V3(8);
W4 = N1*V3(7)+N2*V3(8)+N3*V3(9)+N4*V3(10);
W5 = N1*V3(9)+N2*V3(10)+N3*V3(11)+N4*V3(12);
W6 = N1*V3(11)+N2*V3(12)+N3*V3(13)+N4*V3(14);
figure(3)
plot(X, W1, X+L1, W2, X+2*L1, W3, X+3*L1, W4, X+4*L1, W5, X+5*L1, W6)
title("Форма изгибных колебаний третьей частоты колебания");
grid on
xlim([0, 6*L1])
ylim([-0.15, 0.15])

