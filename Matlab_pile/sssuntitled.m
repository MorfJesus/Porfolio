clear
p = 7.8*10^3;
L1 = 3;
A = 14.7*10^(-4);
E = 2*10^11;
I = 350*10^-8;
EI = E*I;
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
M = p*A*L1/420*[M11    M12     zerosM   zerosM       zerosM   zerosM
     M21    M22+M11 M12     zerosM       zerosM   zerosM
     zerosM  M21     M22+M11 M12         zerosM   zerosM
     zerosM  zerosM   M21     M22+M11   M12     zerosM 
     zerosM  zerosM   zerosM   M21         M22+M11 M12
     zerosM  zerosM   zerosM   zerosM       M21     M22]
K = [K11+C    K12     zerosM   zerosM       zerosM   zerosM
     K21    K22+K11 K12     zerosM       zerosM   zerosM
     zerosM  K21     K22+K11 K12         zerosM   zerosM
     zerosM  zerosM   K21     K22+K11   K12     zerosM
     zerosM  zerosM   zerosM   K21         K22+K11 K12
     zerosM  zerosM   zerosM   zerosM       K21     K22]
%M(1,:) = 0;
%M(:,1) = 0;
%M(7,:) = 0
%M(:,7) = 0
%M(13,:) = 0
%M(:,13) = 0

%K(1,:) = 0;
%K(:,1) = 0;
%K(7,:) = 0
%K(:,7) = 0
%K(13,:) = 0
%K(:,13) = 0
K([11 12],:)=[];
K(:,[11 12])=[]; 
M([11 12],:)=[];
M(:,[11 12])=[]; 
K
M
[V, D] = eig(K, M);
V1 = [V(1:10, 1)' 0 0]
V2 = [V(1:10, 2)' 0 0]
V3 = [V(1:10, 3)' 0 0]
omega_1 = sqrt(D(1, 1)) 
omega_2 = sqrt(D(2, 2)) 
omega_3 = sqrt(D(3, 3))

L = (0:0.01:L1);
N1=1-3*L.^2/L1^2+2*L.^3/L1^3;
N2=L-2*L.^2/L1+L.^3/L1^2;
N3=3*L.^2/L1^2-2*L.^3/L1^3;
N4=-L.^2/L1+L.^3/L1^2;

W1 = N1*V1(1)+N2*V1(2)+N3*V1(3)+N4*V1(4);
W2 = N1*V1(3)+N2*V1(4)+N3*V1(5)+N4*V1(6);
W3 = N1*V1(5)+N2*V1(6)+N3*V1(7)+N4*V1(8);
W4 = N1*V1(7)+N2*V1(8)+N3*V1(9)+N4*V1(10);
W5 = N1*V1(9)+N2*V1(10)+N3*V1(11)+N4*V1(12);
figure(1)
plot(L, W1, L+L1, W2, L+2*L1, W3, L+3*L1, W4, L+4*L1, W5)
title("Форма изгибных колебаний первой частоты колебания");
grid on
xlim([0, 5*L1])

W1 = N1*V2(1)+N2*V2(2)+N3*V2(3)+N4*V2(4);
W2 = N1*V2(3)+N2*V2(4)+N3*V2(5)+N4*V2(6);
W3 = N1*V2(5)+N2*V2(6)+N3*V2(7)+N4*V2(8);
W4 = N1*V2(7)+N2*V2(8)+N3*V2(9)+N4*V2(10);
W5 = N1*V2(9)+N2*V2(10)+N3*V2(11)+N4*V2(12);
figure(2)
plot(L, W1, L+L1, W2, L+2*L1, W3, L+3*L1, W4, L+4*L1, W5)
title("Форма изгибных колебаний второй частоты колебания");
grid on
xlim([0, 5*L1])

W1 = N1*V3(1)+N2*V3(2)+N3*V3(3)+N4*V3(4);
W2 = N1*V3(3)+N2*V3(4)+N3*V3(5)+N4*V3(6);
W3 = N1*V3(5)+N2*V3(6)+N3*V3(7)+N4*V3(8);
W4 = N1*V3(7)+N2*V3(8)+N3*V3(9)+N4*V3(10);
W5 = N1*V3(9)+N2*V3(10)+N3*V3(11)+N4*V3(12);
figure(3)
plot(L, W1, L+L1, W2, L+2*L1, W3, L+3*L1, W4, L+4*L1, W5)
title("Форма изгибных колебаний третьей частоты колебания");
grid on
xlim([0, 5*L1])

M = p*A*L1/420*[M11    M12     zerosM   zerosM       zerosM   zerosM
     M21    M22+M11 M12     zerosM       zerosM   zerosM
     zerosM  M21     M22+M11 M12         zerosM   zerosM
     zerosM  zerosM   M21     M22+M11   M12     zerosM 
     zerosM  zerosM   zerosM   M21         M22+M11 M12
     zerosM  zerosM   zerosM   zerosM       M21     M22]
K = [K11    K12     zerosM   zerosM       zerosM   zerosM
     K21    K22+K11 K12     zerosM       zerosM   zerosM
     zerosM  K21     K22+K11 K12         zerosM   zerosM
     zerosM  zerosM   K21     K22+K11   K12     zerosM
     zerosM  zerosM   zerosM   K21         K22+K11 K12
     zerosM  zerosM   zerosM   zerosM       K21     K22]

M_new = M;
K_new = K;

K_new([11 12],:)=[];
K_new(:,[11 12])=[]; 
M_new([11 12],:)=[];
M_new(:,[11 12])=[];

[V_new, D1_new] = eigs(K_new, M_new, 3, 'sa');
omega1_0 = sqrt(D1_new(1, 1)) 
omega2_0 = sqrt(D1_new(2, 2)) 
omega3_0 = sqrt(D1_new(3, 3))


V1 = [V_new(1:10, 1)' 0 0]
V2 = [V_new(1:10, 2)' 0 0]

W1 = N1*V1(1)+N2*V1(2)+N3*V1(3)+N4*V1(4);
W2 = N1*V1(3)+N2*V1(4)+N3*V1(5)+N4*V1(6);
W3 = N1*V1(5)+N2*V1(6)+N3*V1(7)+N4*V1(8);
W4 = N1*V1(7)+N2*V1(8)+N3*V1(9)+N4*V1(10);
W5 = N1*V1(9)+N2*V1(10)+N3*V1(11)+N4*V1(12);
figure(4)
plot(L, W1, L+L1, W2, L+2*L1, W3, L+3*L1, W4, L+4*L1, W5)
title("Форма изгибных колебаний первой частоты колебания");
grid on
xlim([0, 5*L1])

W1 = N1*V2(1)+N2*V2(2)+N3*V2(3)+N4*V2(4);
W2 = N1*V2(3)+N2*V2(4)+N3*V2(5)+N4*V2(6);
W3 = N1*V2(5)+N2*V2(6)+N3*V2(7)+N4*V2(8);
W4 = N1*V2(7)+N2*V2(8)+N3*V2(9)+N4*V2(10);
W5 = N1*V2(9)+N2*V2(10)+N3*V2(11)+N4*V2(12);
figure(5)
plot(L, W1, L+L1, W2, L+2*L1, W3, L+3*L1, W4, L+4*L1, W5)
title("Форма изгибных колебаний второй частоты колебания");
grid on
xlim([0, 5*L1])

M_new = M;
K_new = K;

K_new([1 11 12],:)=[];
K_new(:,[1 11 12])=[]; 
M_new([1 11 12],:)=[];
M_new(:,[1 11 12])=[];

[V_new, D1_new] = eigs(K_new, M_new, 3, 'sa');
omega1_inf = sqrt(D1_new(1, 1)) 
omega2_inf = sqrt(D1_new(2, 2)) 
omega3_inf = sqrt(D1_new(3, 3))


V1 = [0 V_new(1:9, 1)' 0 0]
V2 = [0 V_new(1:9, 2)' 0 0]

W1 = N1*V1(1)+N2*V1(2)+N3*V1(3)+N4*V1(4);
W2 = N1*V1(3)+N2*V1(4)+N3*V1(5)+N4*V1(6);
W3 = N1*V1(5)+N2*V1(6)+N3*V1(7)+N4*V1(8);
W4 = N1*V1(7)+N2*V1(8)+N3*V1(9)+N4*V1(10);
W5 = N1*V1(9)+N2*V1(10)+N3*V1(11)+N4*V1(12);
figure(6)
plot(L, W1, L+L1, W2, L+2*L1, W3, L+3*L1, W4, L+4*L1, W5)
title("Форма изгибных колебаний первой частоты колебания");
grid on
xlim([0, 5*L1])

W1 = N1*V2(1)+N2*V2(2)+N3*V2(3)+N4*V2(4);
W2 = N1*V2(3)+N2*V2(4)+N3*V2(5)+N4*V2(6);
W3 = N1*V2(5)+N2*V2(6)+N3*V2(7)+N4*V2(8);
W4 = N1*V2(7)+N2*V2(8)+N3*V2(9)+N4*V2(10);
W5 = N1*V2(9)+N2*V2(10)+N3*V2(11)+N4*V2(12);
figure(7)
plot(L, W1, L+L1, W2, L+2*L1, W3, L+3*L1, W4, L+4*L1, W5)
title("Форма изгибных колебаний второй частоты колебания");
grid on
xlim([0, 5*L1])
%
C = (0:0.1:100);
om=-(16.9359-3.8612)./(0.5*C+1) + 16.9359
om2 = 16.9359 + om*0
om3 = 3.8612 + om*0
figure(6)
plot(C, om, C, om2, C, om3)
grid on

