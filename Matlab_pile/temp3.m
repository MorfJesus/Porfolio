clear
syms C1
p = 7.8*10^3;
L = 9;
L1 = 3;
E = 2*10^11;
I = 572*10^-8;
EI = E*I;
A = 17.4*10^(-4);
C = [C1  0
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
     zerosM  zerosM   K21     K22+C+K11   K12     zerosM   zerosM
     zerosM  zerosM   zerosM   K21         K22+K11 K12     zerosM
     zerosM  zerosM   zerosM   zerosM       K21     K22+K11 K12
     zerosM  zerosM   zerosM   zerosM       zerosM   K21     K22+C]
K([1],:)=[];
K(:,[1])=[]; 
M([1],:)=[];
M(:,[1])=[]; 
K;
M;
length(K)
[V, D] = eig(inv(M)*K);
omega1 = sqrt(D(1, 1))