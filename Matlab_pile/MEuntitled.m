clear
close all 

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

P = 0;
PMM = 0;
QMM = 0;

Pmz = sym(zeros(1,m));
Qmz = sym(zeros(1,m));
Az = sym(zeros(1,m));
Bz = sym(zeros(1,m));

for i=1:m
    Pmz(i)=subs(Pm, m0, i);
    Az(i)=PartSol(Pmz(i), cos(i*theta), i);
    Qmz(i)=subs(Qm, m0, i);
    Bz(i)=PartSol(Qmz(i), sin(i*theta), i);
    P = P0+Pmz(i)*cos(i*theta) + Qmz(i)*sin(i*theta);
    PMM = PMM + Pmz(i)*cos(i*theta);
    QMM = QMM + Qmz(i)*sin(i*theta);
end
double(subs(P0, r, a))
double(subs(Pmz, r, a))
double(subs(Qmz, r, a))

P = P + P0;

syms A1 A2 A3 A4 A5 A6 A7 A8 B1 B2 B3 B4 B5 B6 B7 B8
syms A0_1 A0_2 A0_3 A0_4 A0_5 A0_6 A0_7 A0_8

C_1 = sym(zeros(1,m)); %Cm
C_2 = sym(zeros(1,m));
S_1 = sym(zeros(1,m)); %Sm
S_2 = sym(zeros(1,m));

C_1(1)=A1*r + A2*r^3 + A3/r + A4*r*log(r)+Az(1); %Loaded part
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

W0_1=A0_1 + A0_2*r^2 + A0_3*log(r) + A0_4*r^2*log(r) +PartSol(P0, 1, 1);
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
    A5 = R_vars_Cm(i, 3);
    A6 = R_vars_Cm(i, 4);
    A7 = R_vars_Cm(i, 5);
    A8 = R_vars_Cm(i, 6);

    R_C_1(i)=A1*r^i + A2*r^(2+i) + + A3/(r^i) + A4*r^(2-i)+Az(i); %Loaded part
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

R_S_1(1)=B1*r + B2*r^3+ B3/r + B4*r*log(r) + Bz(1); %Loaded part
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

    R_S_1(i)=B1*r^i + B2*r^(2+i)  + B3/(r^i) + B4*r^(2-i)+ Bz(i); %Loaded part
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

W_1 = (R_W0_1*0+W_1);
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

%PLOT TESTING
%{
W_1_1 = subs(W_1, theta, 0);
W_2_1 = subs(W_2, theta, 0);

R_1 = a:0.001:c;
R_2 = c:0.001:b;

W_1_1 = double(subs(W_1_1, r, R_1));
W_2_1 = double(subs(W_2_1, r, R_2));

W_1_2 = subs(W_1, theta, 0);
W_2_2 = subs(W_2, theta, 0);

W_1_2 = double(subs(W_1_2, r, R_1));
W_2_2 = double(subs(W_2_2, r, R_2));

plot(R_1, W_1_1, R_2, W_2_1, -R_1, W_1_2, -R_2, W_2_2)
grid on
xlim([-b b])
ylim([-1*10^-7 5*10^-7])
%}
%PLOT TESTING DONE

global R_theta R_1 R_2 X1 X2 Y1 Y2

R_theta = 0:pi/18:2*pi;

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

figure()
P=subs(P0+PMM+QMM, r, a);
R_theta = 0:pi/180:2*pi;
R_theta_c1 = 0:pi/180:theta1;
R_theta_c2 = theta1+pi/180:pi/180:2*pi;
QQ1 = q*3*(1-r^2/b^2)*cos(3*R_theta_c1);
QQ1=subs(QQ1, r, a);

QQ2 = R_theta_c2.*0;

QQ = [QQ1 QQ2];

P = double(subs(P, theta, R_theta));


%COPYplot3Mat(P)
%subs(subs(D*delta(delta(W_1)), theta, R_theta), r, a)
TEST1 = double(subs(subs(D*delta(delta(W_1)), theta, R_theta), r, a))
%TEST2 = D*delta(delta(subs(subs(MRR_2, theta, R_theta), r, a)));
%TEST = [TEST1, TEST2];
length(TEST1)
plot(R_theta, QQ, R_theta, P, R_theta, TEST1)
grid on
xlim([0, 2*pi])
legend("Оригинальная ф-ия", "Разложенная ф-ия", "LOL")

plot_by_theta(W_1, W_2);
plot_by_theta(W_1/h, W_2/h);
%{
plot_by_theta(MRR_1, MRR_2);
plot_by_theta(MRT_1, MRT_2);
plot_by_theta(MTT_1, MTT_2);
plot_by_theta(QR_1, QR_2);
plot_by_theta(QT_1, QT_2);
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

%ANOTHER TESTING
%{
mrr = Mrr(W0_1)
mtt = Mtt(W0_1)
mrt = Mrt(W0_1)
qr = Qr(W0_1)
qt = Qt(W0_1)
qrkg = QrKG(W0_1)
qtkg = QtKG(W0_1)
%}
%TESTING DONE

function res=RIDOF(fun)
syms r
    fun=subs(fun, log(r), 0);
    for i=1:10
        fun=subs(fun, 1/r^i, 0);
    end
    res = fun;
end

function [R_W_1, R_W_2]=plot_by_theta(W_1, W_2)
    syms theta r
    global R_1 R_2
    figure()
    hold on
    step = pi/4;
    LIM = 0;
    for THET = 0:step:2*pi-step
        ZVAL = limit(subs(W_1, theta, THET), r, 0);
        R_W_1 =  subs(subs(W_1, theta, THET), r, R_1);
        R_W_2 =  subs(subs(W_2, theta, THET), r, R_2);
        R_W=[ZVAL, R_W_1, R_W_2];
        R=[0, R_1, R_2];
        plot(R, R_W)
        LIM = double(1.5*max(max(abs(R_W_1)),LIM));
    end
    grid on
    hold off
    legend("\theta=0°","\theta=45°","\theta=90°","\theta=135°","\theta=180°","\theta=225°","\theta=270°","\theta=315°")
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

function [R_W_1, R_W_2]=plot3Mat(W_1, W_2)
    syms theta r
    global R_theta R_1 R_2 X1 X2 Y1 Y2
    WW_1 = subs(W_1, theta, R_theta);
    WW_2 = subs(W_2, theta, R_theta);

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

%{
function res = Mrr(pW)
    global D nu
    syms r theta
    res = D*(diff(pW, r, 2)+nu*(1/r*diff(pW, r)));
end

function res = Mtt(pW)
    global D nu
    syms r theta
    res = D*(1/r*diff(pW, r)+nu*(diff(pW, r, 2)));
end

function res = Mrt(pW)
    global D nu
    syms r theta
    res = D*(1-nu)*(1/r*diff(diff(pW, r), theta));
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
%}

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
%}

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
        res = (A*r^6+B*r^5*r^4*log(r)+C);
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