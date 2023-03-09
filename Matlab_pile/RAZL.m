global m a b c q h theta1 E nu D
close all
m = 6; %Kol-vo chlenov

a=0.15;
b=0.6;
c=0.4;
q=0.5*10^3;
h=0.04;
theta1 = pi;
E=2*10^11;
nu = 0.3;

D = E*h^3/(12*(1-nu^2));

syms theta m0 r

q1 = (r*cos(theta) + sin(3*theta));

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
end

S = vpa(simplify(Pmz), 6)
S = vpa(Qmz, 6)

S = vpa(simplify(Az), 6)
S = vpa(Bz, 6)

%double(subs(subs(simplify(D*delta(delta(Bz*sin(theta)))), r, 10), theta, pi/2))
%double(subs(subs(Qmz*sin(theta), r, 10), theta, pi/2))

P = P + P0;

P=subs(P, r, a);
R_theta = 0:pi/180:2*pi;
R_theta_c1 = 0:pi/180:theta1;
R_theta_c2 = theta1+pi/180:pi/180:2*pi;

QQ1 = (r*cos(R_theta_c1) + sin(3*R_theta_c1));
QQ1=subs(QQ1, r, a);

QQ2 = R_theta_c2.*0;

QQ = [QQ1 QQ2];

P = double(subs(P, theta, R_theta));
plot(R_theta, QQ, R_theta, P)
grid on
xlim([0, 2*pi])
legend("Оригинальная ф-ия", "Разложенная ф-ия")
%}
syms P1 R

%PartSol(P1*r/R, cos(theta));

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