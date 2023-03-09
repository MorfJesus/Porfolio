clear
close all
global kappa
syms CC1 CC2 x

R = 0.65;
h = 0.01;
l0 = 2.5*sqrt(R*h);
k = 5;
l = l0/k;
q = 5000;
m = 4000;
nu = 0.3;
E = 200*10^9;

kappa = ((3*(1-nu)^2)/(R^2*h^2))^(1/4);
Nx = -q*l/(2*pi*R);
D = E*h^3/(12*(1-nu^2));
WCH = -nu*R/(E*h)*Nx;

syms x M0 Q0

W1 = -WCH*v1(kappa*x)+M0/(kappa^2*D)*v3(kappa*x)+Q0/(kappa^3*D)*v4(kappa*x)+WCH;
phi1 = -4*kappa*(-WCH)*v4(kappa*x)+M0/(kappa*D)*v2(kappa*x)+Q0/(kappa^2*D)*v3(kappa*x);
Mx1 = -4*D*kappa^2*(-WCH)*v3(kappa*x)+M0*v1(kappa*x)+Q0/(kappa)*v2(kappa*x);
Qx1 = -4*D*kappa^3*(-WCH)*v2(kappa*x)-4*kappa*M0*v4(kappa*x)+Q0*v1(kappa*x);

W2 = W1+m/(kappa^2*D)*v3(kappa*(x-l))+q/(kappa^3*D)*v4(kappa*(x-l));
phi2 = phi1+m/(kappa*D)*v2(kappa*(x-l))+q/(kappa^2*D)*v3(kappa*(x-l));
Mx2 = Mx1+m*v1(kappa*(x-l))+q/(kappa)*v2(kappa*(x-l));
Qx2 = Qx1-4*kappa*m*v4(kappa*(x-l))+q*v1(kappa*(x-l));


eqns = [subs(Mx2, x, 2*l)==2*m
    subs(Qx2, x, 2*l)==-q/2];

vars = [M0, Q0];

[R_M0, R_Q0] = solve(eqns, vars);

R_M0 = double(R_M0)
R_MQ0 = double(R_Q0)

R_W1 = subs(W1, [M0, Q0], [R_M0, R_Q0]);
R_phi1 = subs(phi1, [M0, Q0], [R_M0, R_Q0]);
R_Mx1 = subs(Mx1, [M0, Q0], [R_M0, R_Q0]);
R_Qx1 = subs(Qx1, [M0, Q0], [R_M0, R_Q0]);

R_W2 = subs(W2, [M0, Q0], [R_M0, R_Q0]);
R_phi2 = subs(phi2, [M0, Q0], [R_M0, R_Q0]);
R_Mx2 = subs(Mx2, [M0, Q0], [R_M0, R_Q0]);
R_Qx2 = subs(Qx2, [M0, Q0], [R_M0, R_Q0]);

global x1 x2

x1 = 0:l/20:l;
x2 = l:l/20:2*l;

R_My1 = nu*R_Mx1;
R_My2 = nu*R_Mx2;

R_Ny1 = nu*Nx+R_W1/R;
R_Ny2 = nu*Nx+R_W2/R;

%MyPlot(R_W1, R_W2, "W")
%MyPlot(R_phi1, R_phi2, "\phi")
%MyPlot(R_Mx1, R_Mx2, "Mx")
%MyPlot(R_My1, R_My2, "My")
%MyPlot(R_Qx1, R_Qx2, "Qx")
%MyPlot(Nx, Nx, "Nx")
%MyPlot(R_Ny1, R_Ny2, "Ny")

XXX = [x1, x2];

MX = double(ULTRASUBS(R_Mx1, R_Mx2));
MY = double(ULTRASUBS(R_My1, R_My2));
QX = double(ULTRASUBS(R_Qx1, R_Qx2));
NY = double(ULTRASUBS(R_Ny1, R_Ny2));

MxMAX = cell(3, 1);
MyMAX = cell(3, 1);
QxMAX = cell(3, 1);
NyMAX = cell(3, 1);

[MxMAX{1}, MxMAX{3}]= max(MX,[],'ComparisonMethod','abs');
MxMAX{2}= XXX(MxMAX{3});

[MyMAX{1}, MyMAX{3}]= max(MY,[],'ComparisonMethod','abs');
MyMAX{2}= XXX(MyMAX{3});

[QxMAX{1}, QxMAX{3}]= max(QX,[],'ComparisonMethod','abs');
QxMAX{2}= XXX(QxMAX{3});

[NyMAX{1}, NyMAX{3}]= max(NY,[],'ComparisonMethod','abs');
NyMAX{2}= XXX(NyMAX{3});

disp([MxMAX, MyMAX, QxMAX, NyMAX])

ind = [MxMAX{3}, MyMAX{3}, QxMAX{3}, NyMAX{3}];
ind = sort(unique(ind), 'descend');

for i=1:length(ind)
    "VALUES AT: "+XXX(ind(i))
    disp([{"Mx("+XXX(ind(i))+")";MX(ind(i))}, {"My("+XXX(ind(i))+")";MY(ind(i))}, {"Nx("+XXX(ind(i))+")";-Nx}, {"Ny("+XXX(ind(i))+")";NY(ind(i))}, {"Qx("+XXX(ind(i))+")";QX(ind(i))}])
end


SigMx = cell(length(ind),1);
SigMy = cell(length(ind),1);
TauQx = cell(length(ind),1);
SigNx = cell(length(ind),1);
SigNy = cell(length(ind),1);


"Z=h/2"

for i=1:length(ind)
    SigMx{i} = -6*MX(ind(i))/h^2*10^-6;
    SigMy{i} = -6*MY(ind(i))/h^2*10^-6;
    SigNy{i} = NY(ind(i))/h*10^-6;
    SigNx{i} = -Nx/h*10^-6;
    TauQx{i} = double(0);
end
%{
for i=1:length(ind)
    "VALUES AT: "+XXX(ind(i))
    disp([{"σ_Mx, МПа";SigMx{i}}, {"σ_My, МПа";SigMy{i}}, {"σ_Nx, МПа";SigNx{i}}, {"σ_Ny, МПа";SigNy{i}}, {"τ_Qx, МПа";TauQx{i}}])
    disp([SigMx{i}+SigNx{i}, SigMy{i}+SigNy{i}])
end

"Z=-h/2"

for i=1:length(ind)
    SigMx{i} = 6*MX(ind(i))/h^2*10^-6;
    SigMy{i} = 6*MY(ind(i))/h^2*10^-6;
    SigNy{i} = NY(ind(i))/h*10^-6;
    SigNx{i} = -Nx/h*10^-6;
    TauQx{i} = double(0);
end

for i=1:length(ind)
    "VALUES AT: "+XXX(ind(i))
    disp([{"σ_Mx, МПа";SigMx{i}}, {"σ_My, МПа";SigMy{i}}, {"σ_Nx, МПа";SigNx{i}}, {"σ_Ny, МПа";SigNy{i}}, {"τ_Qx, МПа";TauQx{i}}])
    disp([SigMx{i}+SigNx{i}, SigMy{i}+SigNy{i}])
end
%}

"Z=0"

SIGMA = cell(length(ind), 1);

for i=1:length(ind)
    SigMx{i} = double(0);
    SigMy{i} = double(0);
    SigNy{i} = NY(ind(i))/h*10^-6;
    SigNx{i} = -Nx/h*10^-6;
    TauQx{i} = 1.5*abs(QX(ind(i)))/h*10^-6;
end

for i=1:length(ind)
    "VALUES AT: "+XXX(ind(i))
    disp([{"σ_Mx, МПа";SigMx{i}}, {"σ_My, МПа";SigMy{i}}, {"σ_Nx, МПа";SigNx{i}}, {"σ_Ny, МПа";SigNy{i}}, {"τ_Qx, МПа";TauQx{i}}])
    disp([SigMx{i}+SigNx{i}, SigMy{i}+SigNy{i}])
end

syms lambda

for i=1:length(ind)
    "VALUES AT: "+XXX(ind(i))
    SIGMA{i} = [SigMx{i}+SigNx{i}-lambda, 0, TauQx{i};
                0, SigMy{i}+SigNy{i}-lambda, 0;
                TauQx{i}, 0, 0-lambda];
    [SIG] = solve(det(SIGMA{i})==0, lambda);
    SIG = sort(double(SIG), 'descend');
    disp([{"σ_1, МПа"; SIG(1)},{"σ_2, МПа"; SIG(2)},{"σ_3, МПа"; SIG(3)}])
    disp({"σ_экв, МПа"; SIG(1)-SIG(3)})
end
%{
%}
function R_W = ULTRASUBS(R_W1, R_W2)
    global x1 x2
    syms x
    R_W = [subs(R_W1, x, x1), subs(R_W2, x, x2)];
end

function MyPlot(R_W1, R_W2, lab)
    global x1 x2
    syms x
    figure()
    plot([x1(end) x2(1)], [subs(R_W1, x, x1(end)) subs(R_W2, x, x2(1))],x1, subs(R_W1, x, x1), x2, subs(R_W2, x, x2), 'Color','b','LineWidth',2)
    %plot(, 'Color','b')
    title("Зависимость "+lab+"(x)")
    xlabel("x (м)")
    ylabel(lab)
    grid on
end

function res=v1(x)
    res = cosh(x)*cos(x);
end

function res=v2(x)
    res = 0.5*(cosh(x)*sin(x)+sinh(x)*cos(x));
end

function res=v3(x)
    res = 0.5*sinh(x)*sin(x);
end

function res=v4(x)
    res = 0.25*(cosh(x)*sin(x)-sinh(x)*cos(x));
end
