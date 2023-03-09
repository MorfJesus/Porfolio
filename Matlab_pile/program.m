%clear
close all 
fh = localfunctions;

global m a b c q h theta1 E nu D
m=6; %Kol-vo chlenov

a=0.1;
b=0.5;
c=0.4;
q=0.8*10^3;
m1=4*10^3;
h=0.01;
theta1 = 3*pi/2;
E=2*10^11;
nu = 0.3;

D = E*h^3/(12*(1-nu^2));

syms theta m0 r

q1 = q*3*(1-r^2/b^2)*cos(3*theta);
Pm = (1/pi) * int(q1*cos(m0*theta),theta, 0, theta1);
Qm = (1/pi) * int(q1*sin(m0*theta),theta, 0, theta1);
P0 = (1/(2*pi)) * int(q1, theta, 0, theta1);

vpa(PartSol(P0, 1, 1), 6)
P = 0;

Pmz = sym(zeros(1,m));
Qmz = sym(zeros(1,m));
Az = sym(zeros(1,m));
Bz = sym(zeros(1,m));

for i=1:m
    Pmz(i)=subs(Pm, m0, i);
    Az(i)=PartSol(Pmz(i), cos(i*theta), i);
    Qmz(i)=subs(Qm, m0, i);
    Bz(i)=PartSol(Qmz(i), sin(i*theta), i);
    P = P+Pmz(i)*cos(i*theta) + Qmz(i)*sin(i*theta);
    %PMM = PMM + Pmz(i)*cos(i*theta);
    %QMM = QMM + Qmz(i)*sin(i*theta);
end
vpa(PartSol(P0, 1, 1), 4)
vpa(Az, 4)
vpa(Bz, 4)
%Pmz
%Qmz

P = P + P0;

syms A1 A2 A3 A4 A5 A6 A7 A8 B1 B2 B3 B4 B5 B6 B7 B8
syms A0_1 A0_2 A0_3 A0_4 A0_5 A0_6 A0_7 A0_8

C_1 = sym(zeros(1,m)); %Cm
C_2 = sym(zeros(1,m));
S_1 = sym(zeros(1,m)); %Sm
S_2 = sym(zeros(1,m));

C_1(1)=A1*r + A2*r^3 + A3/r + A4*r*log(r) + Az(1); %Loaded part
C_2(1)=A5*r + A6*r^3 + A7/r + A8*r*log(r);

for i = 2:m
    C_1(i)=A1*r^i + A2*r^(2+i) + A3/(r^i) + A4*r^(2-i) + Az(i); %Loaded part
    C_2(i)=A5*r^i + A6*r^(2+i) + A7/(r^i) + A8*r^(2-i);
end

S_1(1)=B1*r + B2*r^3 + B3/r + B4*r*log(r) + Bz(1); %Loaded part
S_2(1)=B5*r + B6*r^3 + B7/r + B8*r*log(r);

for i = 2:m
    S_1(i)=B1*r^i + B2*r^(2+i) + B3/(r^i) + B4*r^(2-i) + Bz(i); %Loaded part
    S_2(i)=B5*r^i + B6*r^(2+i) + B7/(r^i) + B8*r^(2-i);
end

%axisymmetrical part of W

W0_1=A0_1 + A0_2*r^2 + A0_3*log(r) + A0_4*r^2*log(r)+PartSol(P0, 1, 1);
W0_2=A0_5 + A0_6*r^2 + A0_7*log(r) + A0_8*r^2*log(r);

%!!finding constants through conditions!!

%TESTING
%{
syms B
W = B*r^5*cos(theta);
syms P R r
PartSol(P*r/R, r^5*cos(theta))
%}
%TESTING DONE

%TO MEMORIZE
%{ 
QrKG_1(a) == 0;
Mrr_1(a) == 0;
W_1(c) == W_2(c);
dW_1(c) == dW_2(c);
Mrr_1(c) == Mrr_2(c);
Qr_1(c) == Qr_2(c);
W_2(b) == 0;
Mrr_2(b) == 0;



eqns = [subs(QrKG(W0_1), r, a)==0
    subs(Mrr(W0_1), r, a)==0
    subs(W0_1, r, c)==subs(W0_2, r, c)
    subs(diff(W0_1, r), r, c)==subs(diff(W0_2, r), r, c)
    subs(Mrr(W0_1), r, c)==subs(Mrr(W0_2), r, c)
    subs(Qr(W0_1), r, c)==subs(Qr(W0_2), r, c)
    subs(W0_2, r, b)==0
    subs(Mrr(W0_2), r, b)==0];
[A0_1, A0_2, A0_3, A0_4, A0_5, A0_6, A0_7, A0_8]=solve(eqns, vars);
%}
%MEMORIZING DONE

vars_W0 = [A0_1, A0_2, A0_3, A0_4, A0_5, A0_6, A0_7, A0_8];
vars_Cm = [A1, A2, A3, A4, A5, A6, A7, A8];
vars_Sm = [B1, B2, B3, B4, B5, B6, B7, B8];

R_vars_Cm = sym(zeros(m,8));
R_vars_Sm = sym(zeros(m,8));

R_vars_W0=UniqueSol(W0_1, W0_2, vars_W0, 1);
for i=1:m
    R_vars_Cm(i, :)=UniqueSol(C_1(i), C_2(i), vars_Cm, cos(i*theta));
    R_vars_Sm(i, :)=UniqueSol(S_1(i), S_2(i), vars_Sm, sin(i*theta));
end


R_C_1 = sym(zeros(1,m)); %Cm
R_C_2 = sym(zeros(1,m));
R_S_1 = sym(zeros(1,m)); %Sm
R_S_2 = sym(zeros(1,m));

A1 = R_vars_Cm(1, 1);
A2 = R_vars_Cm(1, 2);
A3 = R_vars_Cm(1, 3);
A4 = R_vars_Cm(1, 4);
A5 = R_vars_Cm(1, 5);
A6 = R_vars_Cm(1, 6);
A7 = R_vars_Cm(1, 7);
A8 = R_vars_Cm(1, 8);

R_C_1(1)=A1*r + A2*r^3 + A3/r + A4*r*log(r) + Az(1); %Loaded part
R_C_2(1)=A5*r + A6*r^3 + A7/r + A8*r*log(r);

for i = 2:m
    A1 = R_vars_Cm(i, 1);
    A2 = R_vars_Cm(i, 2);
    A3 = R_vars_Cm(i, 3);
    A4 = R_vars_Cm(i, 4);
    A5 = R_vars_Cm(i, 5);
    A6 = R_vars_Cm(i, 6);
    A7 = R_vars_Cm(i, 7);
    A8 = R_vars_Cm(i, 8);

    R_C_1(i)=A1*r^i + A2*r^(2+i) + A3/(r^i) + A4*r^(2-i) + Az(i); %Loaded part
    R_C_2(i)=A5*r^i + A6*r^(2+i) + A7/(r^i) + A8*r^(2-i);
end


B1 = R_vars_Sm(1, 1);
B2 = R_vars_Sm(1, 2);
B3 = R_vars_Sm(1, 3);
B4 = R_vars_Sm(1, 4);
B5 = R_vars_Sm(1, 5);
B6 = R_vars_Sm(1, 6);
B7 = R_vars_Sm(1, 7);
B8 = R_vars_Sm(1, 8);

R_S_1(1)=B1*r + B2*r^3 + B3/r + B4*r*log(r) + Bz(1); %Loaded part
R_S_2(1)=B5*r + B6*r^3 + B7/r + B8*r*log(r);

for i = 2:m
    B1 = R_vars_Sm(i, 1);
    B2 = R_vars_Sm(i, 2);
    B3 = R_vars_Sm(i, 3);
    B4 = R_vars_Sm(i, 4);
    B5 = R_vars_Sm(i, 5);
    B6 = R_vars_Sm(i, 6);
    B7 = R_vars_Sm(i, 7);
    B8 = R_vars_Sm(i, 8);

    R_S_1(i)=B1*r^i + B2*r^(2+i) + B3/(r^i) + B4*r^(2-i) + Bz(i); %Loaded part
    R_S_2(i)=B5*r^i + B6*r^(2+i) + B7/(r^i) + B8*r^(2-i);
end

A0_1 = R_vars_W0(1);
A0_2 = R_vars_W0(2);
A0_3 = R_vars_W0(3);
A0_4 = R_vars_W0(4);
A0_5 = R_vars_W0(5);
A0_6 = R_vars_W0(6);
A0_7 = R_vars_W0(7);
A0_8 = R_vars_W0(8);

R_W0_1=A0_1 + A0_2*r^2 + A0_3*log(r) + A0_4*r^2*log(r)+PartSol(P0, 1, 1);
R_W0_2=A0_5 + A0_6*r^2 + A0_7*log(r) + A0_8*r^2*log(r);

W_1=0;
W_2=0;

for i=1:m
    W_1 = W_1+R_C_1(i)*cos(i*theta)+R_S_1(i)*sin(i*theta);
    W_2 = W_2+R_C_2(i)*cos(i*theta)+R_S_2(i)*sin(i*theta);
end

W_1 = (R_W0_1+W_1);
W_2 = (R_W0_2+W_2);

MRR_1 = Mrr(W_1);
MRR_2 = Mrr(W_2);

MRT_1 = Mrt(W_1);
MRT_2 = Mrt(W_2);

MTT_1 = Mtt(W_1);
MTT_2 = Mtt(W_2);

QR_1 = Qr(W_1);
QR_2 = Qr(W_2);

QT_1 = Qt(W_1);
QT_2 = Qt(W_2);

QRKG_1=QrKG(W_1);
QRKG_2=QrKG(W_2);

QTKG_1=QrKG(W_1);
QTKG_2=QrKG(W_2);

global R_theta R_1 R_2 X1 X2 Y1 Y2

R_theta = 0:pi/180:2*pi;

R_1 = a:0.005:c;
R_2 = c:0.005:b;

for i = 1:length(R_theta)
    for j = 1:length(R_1)
        X1(i, j) = R_1(j)*cos(R_theta(i));
        Y1(i, j) = R_1(j)*sin(R_theta(i));
    end
    for k = 1:length(R_2)
        X2(i, k) = R_2(k)*cos(R_theta(i));
        Y2(i, k) = R_2(k)*sin(R_theta(i));
    end
end

%{
figure()
P=subs(P, r, c);
%R_theta = 0:pi/18:2*pi;
R_theta_c1 = 0:pi/18:theta1;
R_theta_c2 = (theta1+pi/18):pi/18:2*pi;
QQ1 = q*3*(1-r^2/b^2)*cos(3*R_theta_c1);
QQ1=subs(QQ1, r, c);

QQ2 = R_theta_c2.*0;

QQ = [QQ1 QQ2];

P = double(subs(P, theta, R_theta));


%COPYplot3Mat(P)
TEST1 = double(subs(subs(D*delta(delta(W_1)), theta, R_theta), r, c));
plot(R_theta, QQ, R_theta, P, R_theta, TEST1)
double(trapz(QQ))
double(trapz(P))
double(trapz(TEST1))
grid on
xlim([0, 2*pi])
legend("Оригинальная ф-ия", "Разложенная ф-ия", "Ф-ия полученная из условия равновесия")

figure()
plot(R_theta, QQ, R_theta, P)
grid on
xlim([0, 2*pi])
legend("Оригинальная ф-ия", "Разложенная ф-ия")
%}

%{
%SGIMA AT Z=h/2
%"HEHE1"
%SIG_r1 = plot3D(-6*MRR_1/h^2, -6*MRR_2/h^2);
%"HEHE2"
%SIG_t1 = plot3D(-6*MTT_1/h^2, -6*MTT_2/h^2);
%"HEHE3"
%SIG_z1 = plot3DP(-P);
%"HEHE4"

%SGIMA AT Z=-h/2
"HEHE1"
SIG_r2 = plot3D(6*MRR_1/h^2, 6*MRR_2/h^2);
"HEHE2"
SIG_t2 = plot3D(6*MTT_1/h^2, 6*MTT_2/h^2);
"HEHE3"
SIG_z2 = plot3DP(0);
"HEHE4"

%SIGEQV = double(sqrt(((SIG_r1-SIG_t1).^2+(SIG_t1-SIG_z1).^2+(SIG_r1-SIG_z1).^2)./2));
SIGEQV = double(sqrt(((SIG_r2-SIG_t2).^2+(SIG_t2-SIG_z2).^2+(SIG_r2-SIG_z2).^2)./2));
"HEH"
maximum = max(max(SIGEQV))
[SX,SY]=find(SIGEQV==maximum)
plot3DEQV(SIGEQV)

R_R = [R_1, R_2];
    X = zeros(length(R_theta), length(R_R));
    Y = zeros(length(R_theta), length(R_R));
for i = 1:length(R_theta)
        X(i,:) = R_R*cos(R_theta(i));
        Y(i,:) = R_R*sin(R_theta(i));
    end


hold on
plot3(X(SX, SY),Y(SX, SY), maximum,'o','MarkerSize',10);
hold off
syms RRR TTT
vars=[RRR, TTT];

 
eqs=[X(SX, SY) == RRR*cos(TTT)
        Y(SX, SY) == RRR*sin(TTT)];
 
[S1, S2]=solve(eqs,vars)
%}
%plot3Mat(W_1, W_2)

%{
plot_by_theta(W_1, W_2, "W");
plot_by_theta(W_1/h, W_2/h, "W/h");
%}
%double(subs(subs(P, r, 0.23), theta, 3*pi/2))
%double(subs(subs(P, r, 0.1), theta, 0))
%double(subs(subs(P, r, 0.1), theta, 3*pi/4))


%double(subs(subs(MTT_1, r, 0.23), theta, 3*pi/2))
%double(subs(subs(MRR_1, r, 0.1), theta, 3*pi/4))
%plot_by_theta(MRR_1, MRR_2, "Mrr");
%plot_by_theta(MRT_1, MRT_2, "Mr\theta");
%plot_by_theta(MTT_1, MTT_2, "M\theta\theta");

%plot_by_theta(QR_1, QR_2, "Qr");
%plot_by_theta(QT_1, QT_2, "Qt");

%double(subs(subs(QT_1, r, 0.4), theta, 5*pi/4))
%double(subs(subs(MRT_1, r, 0.4), theta, 5*pi/4))

%double(subs(subs(MRT_1, r, 0.1), theta, pi/2))

%double(subs(subs(QR_1, r, 0.1), theta, 0))
%double(subs(subs(QT_1, r, 0.1), theta, 0))


angles = ["0°"; "45°"; "90°"; "135°"; "180°"; "225°"; "270°"; "315°"];

MRR = ULTRASUBS(MRR_1, MRR_2);
MRT = ULTRASUBS(MRT_1, MRT_2);
MTT = ULTRASUBS(MTT_1, MTT_2);
QR = ULTRASUBS(QR_1, QR_2);
QT = ULTRASUBS(QT_1, QT_2);
R_P = ULTRASUBS(P, 0);

R_R = [R_1, R_2];

maxMRR = zeros(8, 1);
maxMRT = zeros(8, 1);
maxMTT = zeros(8, 1);

maxMRR_IND = zeros(8, 1);
maxMRT_IND = zeros(8, 1);
maxMTT_IND = zeros(8, 1);

for i=1:8
    [~, maxMRR_IND(i)] = max(abs(MRR{i}));
    maxMRR(i) = MRR{i}(maxMRR_IND(i));

    [~, maxMRT_IND(i)] = max(abs(MRT{i}));
    maxMRT(i) = MRT{i}(maxMRT_IND(i));

    [~, maxMTT_IND(i)] = max(abs(MTT{i}));
    maxMTT(i) = MTT{i}(maxMTT_IND(i));
end



table(angles, maxMRR, R_R(maxMRR_IND)', maxMRT, R_R(maxMRT_IND)', maxMTT, R_R(maxMTT_IND)', ...
    'VariableNames',[{'θ'}, {'Значение экстремума Mrr, Н'}, {' r, м '}, {'Значение экстремума Mrθ, Н'}, {'  r, м  '}, {'Значение экстремума Mθθ, Н'} {'   r, м   '}])

R_maxMRR = zeros(3, 1);
R_maxMRT = zeros(3, 1);
R_maxMTT = zeros(3, 1);
R_R_P = zeros(3, 1);

r_ARR = zeros(3, 1);
new_angles = ["1", "2", "3"];

%indecipherable texts of forbidden fucking knowledge I will not understand
%what's written here in like 2 hours, let alone a day

[~, maxIND] = max(abs(maxMRR));
r_ARR(1) = R_R(maxMRR_IND(maxIND));
R_maxMRR(1) = maxMRR(maxIND);
R_maxMRT(1) = MRT{maxIND}(maxMRR_IND(maxIND));
R_maxMTT(1) = MTT{maxIND}(maxMRR_IND(maxIND));
R_R_P(1) = R_P{maxIND}(maxMRR_IND(maxIND));
new_angles(1) = angles(maxIND);


[~, maxIND] = max(abs(maxMRT));
r_ARR(2) = R_R(maxMRT_IND(maxIND));
R_maxMRR(2) = MRR{maxIND}(maxMRT_IND(maxIND));
R_maxMRT(2) = maxMRT(maxIND);
R_maxMTT(2) = MTT{maxIND}(maxMRT_IND(maxIND));
R_R_P(2) = R_P{maxIND}(maxMRT_IND(maxIND));
new_angles(2) = angles(maxIND);

[~, maxIND] = max(abs(maxMTT));
r_ARR(3) = R_R(maxMTT_IND(maxIND));
R_maxMRR(3) = MRR{maxIND}(maxMTT_IND(maxIND));
R_maxMRT(3) = MRT{maxIND}(maxMTT_IND(maxIND));
R_maxMTT(3) = maxMTT(maxIND);
R_R_P(3) = R_P{maxIND}(maxMTT_IND(maxIND));
new_angles(3) = angles(maxIND);



table((new_angles' + ', ' + r_ARR + 'м'), R_maxMRR, R_maxMRT, R_maxMTT, R_R_P, 'VariableNames',[{'θ, r'}, {'Mrr, Н'}, {'Mrθ, Н'},{'Mθθ, Н'}, {'P, Н'}])

"!!! z = h/2 !!!"

sigR = zeros(3, 1);
sigT = zeros(3, 1);
sigZ = zeros(3, 1);
tauRT = zeros(3, 1);

for i=1:3
    sigR(i) = -R_maxMRR(i)/h^2*10^(-6);
    sigT(i) = -R_maxMTT(i)/h^2*10^(-6);
    sigZ(i) = -R_R_P(i)*10^(-6);
    tauRT(i) = -6*R_maxMRT(i)/h^2*10^(-6);
end

table((new_angles' + ', ' + r_ARR + 'м'), sigR, sigT, sigZ, tauRT, 'VariableNames',[{'θ, r'}, {'σ_r, МПа'}, {'σ_θ, МПа'},{'σ_z, МПа'}, {'τ_rθ, МПа'}])

syms lambda

for i=1:3
"VALUES AT i = " + i + ", THETA AND r = " + new_angles(i) + ', ' + r_ARR(i) + 'м'
A = [sigR(i)-lambda tauRT(i) 0;
     tauRT(i) sigT(i)-lambda 0;
     0 0 sigZ(i)-lambda];
disp(vpa(A, 4))
res = solve(det(A)==0, lambda);
res = sort(double(res), 'descend');
SIGEQV = sqrt((res(1)-res(2))^2+(res(2)-res(3))^2+(res(1)-res(3))^2);
table(new_angles(i) + ', ' + r_ARR(i) + 'м', res(1), res(2), res(3), SIGEQV, ...
    'VariableNames',[{'θ, r'}, {'σ_1, МПа'}, {'σ_2, МПа'},{'σ_3, МПа'},{'σ_экв, МПа'}])
end


"!!! z = -h/2 !!!"

sigR = zeros(3, 1);
sigT = zeros(3, 1);
sigZ = zeros(3, 1);
tauRT = zeros(3, 1);

for i=1:3
    sigR(i) = R_maxMRR(i)/h^2*10^(-6);
    sigT(i) = R_maxMTT(i)/h^2*10^(-6);
    sigZ(i) = 0;
    tauRT(i) = 6*R_maxMRT(i)/h^2*10^(-6);
end

table((new_angles' + ', ' + r_ARR + 'м'), sigR, sigT, sigZ, tauRT, 'VariableNames',[{'θ, r'}, {'σ_r, МПа'}, {'σ_θ, МПа'},{'σ_z, МПа'}, {'τ_rθ, МПа'}])

syms lambda

for i=1:3
"VALUES AT i = " + i + ", THETA AND r = " + new_angles(i) + ', ' + r_ARR(i) + 'м'
A = [sigR(i)-lambda tauRT(i) 0;
     tauRT(i) sigT(i)-lambda 0;
     0 0 sigZ(i)-lambda];
disp(vpa(A, 4))
res = solve(det(A)==0, lambda);
res = sort(double(res), 'descend');
SIGEQV = sqrt((res(1)-res(2))^2+(res(2)-res(3))^2+(res(1)-res(3))^2);
table(new_angles(i) + ', ' + r_ARR(i) + 'м', res(1), res(2), res(3), SIGEQV, ...
    'VariableNames',[{'θ, r'}, {'σ_1, МПа'}, {'σ_2, МПа'},{'σ_3, МПа'},{'σ_экв, МПа'}])
end

"!!! z = 0 !!!"

maxQR = zeros(8, 1);
maxQT = zeros(8, 1);

maxQR_IND = zeros(8, 1);
maxQT_IND = zeros(8, 1);

for i=1:8
    [~, maxQR_IND(i)] = max(abs(QR{i}));
    maxQR(i) = QR{i}(maxQR_IND(i));

    [~, maxQT_IND(i)] = max(abs(QT{i}));
    maxQT(i) = QT{i}(maxQT_IND(i));
end



table(angles, maxQR, R_R(maxQR_IND)', maxQT, R_R(maxQT_IND)', ...
    'VariableNames',[{'θ'}, {'Значение экстремума Qr, Н/м'}, {' r, м '}, {'Значение экстремума Qθ, Н/м'}, {'  r, м  '}])

R_maxQR = zeros(2, 1);
R_maxQT = zeros(2, 1);

r_ARR = zeros(2, 1);
new_angles = ["1", "2"];

%indecipherable texts of forbidden fucking knowledge I will not understand
%what's written here in like 2 hours, let alone a day

[~, maxIND] = max(abs(maxQR));
r_ARR(1) = R_R(maxQR_IND(maxIND));
R_maxQR(1) = maxQR(maxIND);
R_maxQT(1) = QT{maxIND}(maxQR_IND(maxIND));

new_angles(1) = angles(maxIND);


[~, maxIND] = max(abs(maxQT));
r_ARR(2) = R_R(maxQT_IND(maxIND));
R_maxQR(2) = QR{maxIND}(maxQT_IND(maxIND));
R_maxQT(2) = maxQT(maxIND);

new_angles(2) = angles(maxIND);

table((new_angles' + ', ' + r_ARR + 'м'), R_maxQR, R_maxQT, 'VariableNames',[{'θ, r'}, {'Qr, Н/м'}, {'Qθ, Н/м'}])

tauRZ = zeros(2, 1);
tauTZ = zeros(2, 1);

for i=1:2
    tauRZ(i) = 1.5*abs(R_maxQR(i))/h*10^(-6);
    tauTZ(i) = 1.5*abs(R_maxQT(i))/h*10^(-6);
end

table((new_angles' + ', ' + r_ARR + 'м'), tauRZ, tauTZ, 'VariableNames',[{'θ, r'}, {'τ_rz, МПа'}, {'τ_θz, МПа'}])

syms lambda

for i=1:2
"VALUES AT i = " + i + ", THETA AND r = " + new_angles(i) + ', ' + r_ARR(i) + 'м'
A = [-lambda 0 tauRZ(i);
     0 -lambda tauTZ(i);
     tauRZ(i) tauTZ(i) -lambda];
disp(vpa(A, 4))
res = solve(det(A)==0, lambda);
res = sort(double(res), 'descend');
SIGEQV = sqrt((res(1)-res(2))^2+(res(2)-res(3))^2+(res(1)-res(3))^2);
table(new_angles(i) + ', ' + r_ARR(i) + 'м', res(1), res(2), res(3), SIGEQV, ...
    'VariableNames',[{'θ, r'}, {'σ_1, МПа'}, {'σ_2, МПа'},{'σ_3, МПа'},{'σ_экв, МПа'}])
end

%{
syms lambda

"z = h/2"

R = [R_1, R_2];
SIG_R = cell(8,1);
SIG_T = cell(8,1);
SIG_Z = cell(8,1);
TAU_TR = cell(8,1);
TAU_ZR = cell(8,1);
TAU_ZT = cell(8,1);
A = cell(8,1);

for i = 1:1:8
    SIG_R{i} = -MRR{i}/h^2
    SIG_T{i} = -MTT{i}/h^2
    SIG_Z{i} = -R_P{i}
    TAU_TR{i} = -6*MRT{i}/h^2
    TAU_ZR{i} = zeros(1, length(R))
    TAU_ZT{i} = zeros(1, length(R))
    A{i} = [SIG_R{i} TAU_TR{i} TAU_ZR{i}
            TAU_TR{i} SIG_T{i} TAU_ZT{i}
            TAU_ZR{i} TAU_ZT{i} SIG_Z{i}]
end
%}




%{
plot_by_theta(QRKG_1, QRKG_2, "Qr*");
plot_by_theta(QTKG_1, QTKG_2, "Qt*");

QS = subs(QR_1, r, a)
PS = subs(P, r, a);
SUM1 = 0;
SUM2 = 0;
%}
%{
for i = 0:pi/18:2*pi
    SUM1 = SUM1 + double(subs(QS, theta, i));
    SUM2 = SUM2 + double(subs(PS, theta, i));
end
%}
%SUM1_2 = int(QS,theta, 0, 2*pi)
%{
%}
%{
[R_W_1, R_W_2] = plot3Mat(W_1, W_2);
[R_MRR_1, R_MRR_2] = plot3Mat(MRR_1, MRR_2);
[R_MRT_1, R_MRT_2] = plot3Mat(MRT_1, MRT_2);
[R_MTT_1, R_MTT_2] = plot3Mat(MTT_1, MTT_2);
[R_QR_1, R_QR_2] = plot3Mat(QR_1, QR_2);
[R_QT_1, R_QT_2] = plot3Mat(QT_1, QT_2);
%}

%{
figure()
plot3(X1, Y1, R_W_1, X2, Y2, R_W_2)
grid on

figure()
plot3(X1, Y1, R_MRR_1, X2, Y2, R_MRR_2)
grid on

figure()
plot3(X1, Y1, R_MRT_1, X2, Y2, R_MRT_2)
grid on

figure()
plot3(X1, Y1, R_MTT_1, X2, Y2, R_MTT_2)
grid on

figure()
plot3(X1, Y1, R_QR_1, X2, Y2, R_QR_2)
grid on

figure()
plot3(X1, Y1, R_QT_1, X2, Y2, R_QT_2)
grid on
%}

%subs(WW_1(1), r, R_1)

%[numRows1,numCols1] = size(WW_1);
%[numRows2,numCols2] = size(WW_2);

function R_W=ULTRASUBS(W_1, W_2)
    syms theta r
    global R_1 R_2
    R_W = cell(8, 1);
   
    step = pi/4;
   
    tab = zeros(8,3);
    j = 1;
    for THET = 0:step:2*pi-step
        R_W_1 =  double(subs(subs(W_1, theta, THET), r, R_1));
        R_W_2 =  double(subs(subs(W_2, theta, THET), r, R_2));
        R_W{j}=[R_W_1, R_W_2];
        [M, i] = max(abs(R_W{j}));
        R=[R_1, R_2];
        tab(j, 2)=double(R_W{j}(i));
        tab(j, 3)=R(i);
        tab(j, 1)=THET*180/pi;
        j = j + 1;
    end
    disp(tab)
end

function [R_W_1, R_W_2]=plot_by_theta(W_1, W_2, lab)
    syms theta r
    global R_1 R_2
    figure()
    hold on
    step = pi/4;
    LIM = 0;
    tab = zeros(8,3);
    lab
    j = 1;
    for THET = 0:step:2*pi-step
        R_W_1 =  subs(subs(W_1, theta, THET), r, R_1);
        R_W_2 =  subs(subs(W_2, theta, THET), r, R_2);
        R_W=[R_W_1, R_W_2];
        [M, i] = max(abs(R_W));
        R=[R_1, R_2];
        tab(j, 2)=double(R_W(i));
        tab(j, 3)=R(i);
        tab(j, 1)=THET*180/pi;
        j = j + 1;
        plot(R, R_W,'LineWidth', 2)
        LIM = double(1.5*max(max(abs(R_W_1)),LIM));
    end
    disp(tab)
    grid on
    hold off
    legend("\theta=0°","\theta=45°","\theta=90°","\theta=135°","\theta=180°","\theta=225°","\theta=270°","\theta=315°")
    ylabel(lab)
    title("График зависимости "+lab+" от r при разных \theta");
    xlabel("r, м")
    %ylim([-LIM, LIM])
end

function [L_W_1, L_W_2, R_W_1, R_W_2]=plot_at_theta(W_1, W_2, THET)
    syms theta r
    global R_1 R_2

    R_W_1 =  subs(subs(W_1, theta, THET), r, R_1);
    R_W_2 =  subs(subs(W_2, theta, THET), r, R_2);

    L_W_1 =  subs(subs(W_1, theta, THET+pi), r, R_1);
    L_W_2 =  subs(subs(W_2, theta, THET+pi), r, R_2);

    figure()
    plot(-R_1, L_W_1, -R_2, L_W_2, R_1, R_W_1, R_2, R_W_2)
    grid on
    LIM = double(1.5*max(max(abs(R_W_1)),max(abs(R_W_2))));
    ylim([-LIM, LIM])
end

function [R_W_1, R_W_2]=COPYplot3Mat(P)
    syms theta r
    global R_theta R_1 R_2 X1 X2 Y1 Y2
    WW_1 = subs(P, theta, R_theta);
    WW_2 = subs(P, theta, R_theta);

    WW_1 = WW_1.';
    WW_2 = WW_2.';

    for i = 1:length(R_theta)
        R_W_1(i, :) =  subs(WW_1(i), r, R_1);
        R_W_2(i, :) =  subs(WW_2(i), r, R_2);
    end

    figure()
    plot3(X1, Y1, R_W_1, X2, Y2, R_W_2)
    grid on
end

function res=plot3D(W_1, W_2) %absolutely atrocious stuff, gonna forget this in 2 weeks
    syms theta r
    global R_theta R_1 R_2
    WW_1 = subs(W_1, r, R_1);
    WW_2 = subs(W_2, r, R_2);
    WW = [WW_1, WW_2];
    R_R = [R_1, R_2];
    R_WW = zeros(length(R_theta), length(R_R));
    X = zeros(length(R_theta), length(R_R));
    Y = zeros(length(R_theta), length(R_R));

    for i = 1:length(R_theta)
        X(i,:) = R_R*cos(R_theta(i));
        Y(i,:) = R_R*sin(R_theta(i));
        R_WW(i,:) = subs(WW, theta, R_theta(i));
    end

    figure()
    plot3(X, Y, R_WW)
    grid on

    res = R_WW;
end

function res=plot3DP(P) %gonna forget this in 2 weeks as well
    syms theta r
    global R_theta R_1 R_2
    R_R = [R_1, R_2];
    PP = subs(P, r, R_R);
    R_PP = zeros(length(R_theta), length(R_R));
    X = zeros(length(R_theta), length(R_R));
    Y = zeros(length(R_theta), length(R_R));

    for i = 1:length(R_theta)
        i
        X(i,:) = R_R*cos(R_theta(i));
        Y(i,:) = R_R*sin(R_theta(i));
        R_PP(i,:) = subs(PP, theta, R_theta(i));
    end

    fig=figure();
    plot3(X, Y, R_PP);
    %saveas(fig, "cock.png")
    grid on

    res = R_PP;
end

function res=plot3DEQV(P) %gonna forget this in 2 weeks as well
    syms theta r
    global R_theta R_1 R_2
    R_R = [R_1, R_2];
    X = zeros(length(R_theta), length(R_R));
    Y = zeros(length(R_theta), length(R_R));

    for i = 1:length(R_theta)
        X(i,:) = R_R*cos(R_theta(i));
        Y(i,:) = R_R*sin(R_theta(i));
    end

    figure()
    plot3(X, Y, P)
    grid on

    res = P;
end

function [R_W_1, R_W_2]=plot3Mat(W_1, W_2)
    syms theta r
    global R_theta R_1 R_2 X1 X2 Y1 Y2
    
    R_R = [R_1, R_2];

    [R1, Theta1] = meshgrid(R_2, R_theta);
    [R2, Theta2] = meshgrid(R_1, R_theta);
    %Theta1 = Theta1
    %Theta2 = Theta2
    x1 = R1.*cos(Theta1);
    y1 = R1.*sin(Theta1);
    x2 = R2.*cos(Theta2);
    y2 = R2.*sin(Theta2);
    WW1 = double(subs(W_1, {r, theta}, {R1, Theta1}));
    WW2 = double(subs(W_2, {r, theta}, {R2, Theta2}));

    plot3(x1, y1, WW1, x2, y2, WW2)
% 
%     WW_1 = subs(W_1, theta, Theta);
%     WW_2 = subs(W_2, theta, Theta);
% 
%     WW_1 = WW_1.';
%     WW_2 = WW_2.';
% 
%     for i = 1:length(R)
%         i
%         R_W_1(i, :) =  subs(WW_1(i), r, R);
%         R_W_2(i, :) =  subs(WW_2(i), r, R);
%     end
% 
%     figure()
%     %length(X1)
%     %length(Y1)
%     %length(R_W_1(:,1))
%     %length(R_W_1(1,:))
%     plot3(x, y, R_W_1, X2, Y2, R_W_2)
%     grid on
end

function [res] = UniqueSol(W0_1, W0_2, vars, fun) %ONLY WORKS FOR YOU, WILL NEED TO CHANGE ACCORDING TO CONDITIONS
    global a c b
    syms r
    eqns = [subs(QrKG(W0_1*fun), r, a)==0
    subs(Mrr(W0_1*fun), r, a)==0
    subs(W0_1*fun, r, c)==subs(W0_2*fun, r, c)
    subs(diff(W0_1*fun, r), r, c)==subs(diff(W0_2*fun, r), r, c)
    subs(Mrr(W0_1*fun), r, c)==subs(Mrr(W0_2*fun), r, c)
    subs(Qr(W0_1*fun), r, c)==subs(Qr(W0_2*fun), r, c)
    subs(W0_2*fun, r, b)==0
    subs(Mrr(W0_2*fun), r, b)==0];

    [res1, res2, res3, res4, res5, res6, res7, res8]=solve(eqns, vars);
    res = [res1, res2, res3, res4, res5, res6, res7, res8];
end

function res = Mrr(pW)
    global D nu
    syms r theta
    res = D*(diff(pW, r, 2)+nu*(1/r*diff(pW, r)+1/r^2*diff(pW, theta, 2)));
end

function res = Mtt(pW)
    global D nu
    syms r theta
    res = D*(1/r*diff(pW, r)+nu*(diff(pW, r, 2)+1/r^2*diff(pW, theta, 2)));
end

function res = Mrt(pW)
    global D nu
    syms r theta
    res = D*(1-nu)*(1/r*diff(diff(pW, r), theta)-1/r^2*diff(pW, theta));
end

function res = Qr(pW)
    global D
    syms r theta
    res = D*diff(delta(pW), r);
end

function res = Qt(pW)
    global D
    syms r theta
    res = D*1/r*diff(delta(pW), theta);
end

function res = QrKG(pW)
    global D
    syms r theta
    res = Qr(pW)+1/r*diff(Mrt(pW), theta);
end

function res = QtKG(pW)
    global D
    syms r theta
    res = Qt(pW)+diff(Mrt(pW), r);
end

function res = PartSol(EQ2, fun, i)
    global D
    syms A B C r
    if (i == 2)
        EQ1=simplify(D*delta(delta((A*r^2+B*r+C*log(r))*r^4*fun)));
    elseif (i == 3)
        EQ1=simplify(D*delta(delta((A*r^2+B*r*log(r)+C)*r^4*fun)));
    elseif (i == 4)
        EQ1=simplify(D*delta(delta((A*r^2*log(r)+B*r+C*log(r))*r^4*fun)));
    elseif (i == 5)
        EQ1=simplify(D*delta(delta((A*r^2+B*r*log(r)+C)*r^4*fun)));
    elseif (i == 6)
        EQ1=simplify(D*delta(delta((A*r^2*log(r)+B*r+C)*r^4*fun)));
    else
        EQ1=simplify(D*delta(delta((A*r^2+B*r+C)*r^4*fun)));
    end
    
    %EQ2 = P1*r/R
    EQ1 = (EQ1 + r^2*fun);
    EQ2 = (EQ2 + r^2)*fun;
    eq1=coeffs(EQ1, r, 'All');
    %[eq2, t2]=coeffs(Pmz(2)*cos(theta), r, 'All')
    eq2=coeffs(EQ2, r, 'All');

    A=solve(eq1(1)==eq2(1), A);
    B=solve(eq1(2)==eq2(2), B);
    C=solve(eq1(3)==eq2(3), C);
    if isempty(A)
        A = 0;
    end
    if isempty(B)
        B = 0;
    end
    if isempty(C)
        C = 0;
    end
    if (i == 2)
        res = (A*r^6+B*r^5+C*r^4*log(r));
    elseif (i == 3)
        res = (A*r^6+B*r^5*log(r)+C*r^4);
    elseif (i == 4)
        res = (A*r^6*log(r)+B*r^5+C*r^4*log(r));
    elseif (i == 5)
        res = (A*r^6+B*r^5*log(r)+C*r^4);
    elseif (i == 6)
        res = (A*r^6*log(r)+B*r^5+C*r^4);
    else
        res = (A*r^6+B*r^5+C*r^4);
    end
end

%{
function res = PartSol(Pmz, rem)
    global D
    syms B theta
    W = B*rem;
    res=solve(D*delta(delta(W))==Pmz, B);
end
%}

function res = delta(W)
    syms r theta
    res = diff(W, r, 2)+1/r*diff(W, r)+1/r^2*diff(W, theta, 2);
end