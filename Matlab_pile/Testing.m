clear
close all

fh = localfunctions;

syms CC1 CC2 x

R = 0.65;
h = 0.01;
l = 1.4;
k = 5;
q = 5000;
m = 4000;
nu = 0.3;
E = 200*10^9;

l0 = 2.5*sqrt(R*h);
kappa = ((3*(1-nu)^2)/(R^2*h^2))^(1/4);
Nx = q*l/(2*pi*R);
D = E*h^3/(12*(1-nu^2));

step = 0.01;

%kappa = 13.658;
%nu = 0.3;
%R = 0.65;
%h = 0.01;
%Nx = 1714;
%E = 2*10^11;
%l0 = 0.2016;
%l = 1.4;
%D = 18315;
%q = 5000;
%m = 4000;

WEQR = exp(-kappa*x)*(CC1*cos(kappa*x)+CC2*sin(kappa*x))+nu*R/(E*h)*Nx;
WEQL = exp(kappa*x)*(CC1*cos(kappa*x)+CC2*sin(kappa*x))+nu*R/(E*h)*Nx;

W = {WEQR, WEQL, WEQR, WEQL};
dW = cell(4,1);
Mx = cell(4,1);
My = cell(4,1);
Q = cell(4,1);
R_Nx = cell(4,1);
Ny = cell(4,1);

C1 = zeros(4, 1);
C2 = zeros(4, 1);
%%{

eqns1 = [subs(WEQR, x, 0) == 0
    subs(diff(WEQR, x), x, 0) == 0];

eqns2 = [D*subs(diff(WEQL, x, 2), x, 0) == m/2
    D*subs(WEQL, x, 0) == 0];

eqns3 = [D*subs(diff(WEQR, x, 2), x, 0) == -m/2
    D*subs(WEQR, x, 0) == 0];

eqns4 = [D*subs(diff(WEQL, x, 2), x, 0) == 2*m
    D*subs(diff(WEQL, x, 3), x, 0) == q/2];

EQNS = {eqns1, eqns2, eqns3, eqns4};

vars = [CC1, CC2];

x_r = 0:step:l/2;
x_l = -l/2:step:0;

X_CELL = {x_r, x_l, x_r, x_l};

shift = [0, l, l, 2*l];


for i=1:1:4
    [C1(i), C2(i)] = solve(EQNS{i}, vars);
    W{i} = subs(W{i}, [CC1, CC2], [C1(i), C2(i)]);
    %R_W{i} = subs(W{i}, x, X_CELL{i});
    %plot(X_CELL{i}+shift(i), R_W{i})
end

%additional part

C1_ADD = zeros(2, 1);
C2_ADD = zeros(2, 1);

eqns2_ADD = [D*subs(diff(WEQL, x, 1), x, 0)+D*subs(diff(W{2}, x, 1), x, 0) == 0
    D*subs(diff(WEQL, x, 3), x, 0)+D*subs(diff(W{2}, x, 3), x, 0) == -q/2];

eqns3_ADD = [D*subs(diff(WEQR, x, 1), x, 0)+D*subs(diff(W{3}, x, 1), x, 0) == 0
    D*subs(diff(WEQR, x, 3), x, 0)+D*subs(diff(W{3}, x, 3), x, 0) == q/2];

EQNS_ADD = {eqns2_ADD, eqns3_ADD};

W_ADD = {WEQL, WEQR};

for i=1:2
    [C1_ADD(i), C2_ADD(i)] = solve(EQNS_ADD{i}, vars);
    W{i+1} = subs(W_ADD{i}, [CC1, CC2], [C1_ADD(i), C2_ADD(i)]);
end

for i=1:4
    dW{i} = diff(W{i}, x, 1);
    Mx{i} = D*diff(W{i}, x, 2);
    My{i} = Mx{i}*nu;
    Q{i} = D*diff(W{i}, x, 3);
    R_Nx{i} = -Nx+0*W{i};
    Ny{i} = -nu*Nx+E*h*W{i}/R;
end
%}

%{
PartPlot(W{1}, X_CELL{1}, shift(1), "W")
PartPlot(dW{1}, X_CELL{1}, shift(1), "dW")
PartPlot(Mx{1}, X_CELL{1}, shift(1), "Mx")
PartPlot(Q{1}, X_CELL{1}, shift(1), "Qx")
%}

%{
MiddlePlot(W, X_CELL, shift, "W")
MiddlePlot(dW, X_CELL, shift, "dW")
MiddlePlot(Mx, X_CELL, shift, "Mx")
MiddlePlot(Q, X_CELL, shift, "Qx")
%}

%{
PartPlot(W{4}, X_CELL{4}, shift(4), "W")
PartPlot(dW{4}, X_CELL{4}, shift(4), "dW")
PartPlot(Mx{4}, X_CELL{4}, shift(4), "Mx")
PartPlot(Q{4}, X_CELL{4}, shift(4), "Qx")
%}

%{
MyPlot(W, X_CELL, shift, "W")
MyPlot(dW, X_CELL, shift, "dW")
MyPlot(Mx, X_CELL, shift, "Mx")
MyPlot(My, X_CELL, shift, "My")
MyPlot(Q, X_CELL, shift, "Qx")
MyPlot(R_Nx, X_CELL, shift, "Nx")
MyPlot(Ny, X_CELL, shift, "Ny")
%}

XXX = X_CELL{1}+shift(1);
for i=2:4
   XXX = [XXX X_CELL{i}+shift(i)];
end

MX = double(ULTRASUBS(Mx, X_CELL));
MY = double(ULTRASUBS(My, X_CELL));
QX = double(ULTRASUBS(Q, X_CELL));
NY = double(ULTRASUBS(Ny, X_CELL));

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
    disp([{"Mx("+XXX(ind(i))+")";MX(ind(i))}, {"My("+XXX(ind(i))+")";MY(ind(i))}, {"Nx("+XXX(ind(i))+")";-Nx}, {"Ny("+XXX(ind(i))+")";NY(ind(i))}, {"Qx("+XXX(ind(i))+")";QX(ind(i))}])
end


for i=1:length(ind)
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
(in00-lambda)*(in11*lambda)*(in22*lambda)+
(a00-lambda)*(a11*lambda)*(a22*lambda) + a12*a23*a31 + a13*a21*a32 - a13*a22*a31 - a11*a23*a32 - a12*a21*a33
(a00-lambda)*(a11*lambda)*(a22*lambda) + a01*a12*a20 + a02*a10*a21 - a02*(a11-lambda)*a20 - (a00-lambda)*a12*a21 - a01*a10*(a22-lambda)
(a00-lambda)*(a11-lambda)*(a22-lambda) + a01*a12*a20 + a02*a10*a21 - a02*(a11-lambda)*a20 - (a00-lambda)*a12*a21 - a01*a10*(a22-lambda)
a_1*lambda^2 + a_2*lambda^2 + a_3*lambda^2 - a_1*a_2*lambda - a_1*a_3*lambda - a_2*a_3*lambda + a_1*a_2*a_3 - lambda^3
-lambda^3+(lambda^2)*(a00+a11+a22) - lamba*(a00*a11+a00*a22+a11*a22) + a00*a11*a22 + a01*a12*a20 + a02*a10*a21 - a02*a20*(a11-lambda) - a12*a21*(a00-lambda) - a01*a10*(a22-lambda)
-lambda^3+(lambda^2)*(a00+a11+a22) - lamba*(a00*a11+a00*a22+a11*a22-a01*a10-a12*a21-a02*a20) + a00*a11*a22 + a01*a12*a20 + a02*a10*a21 - a02*a20*a11 - a12*a21*a00 - a01*a10*a22 
function R_W = ULTRASUBS(W, X_CELL)
    syms x
    R_W = subs(W{1}, x, X_CELL{1});
    for i=2:1:4
        R_W = [R_W subs(W{i}, x, X_CELL{i})];
    end
end

function MiddlePlot(W, X_CELL, shift, lab)
    syms x
    R_W = cell(2,1);
    figure()
    hold on
    for i=2:1:3
        R_W{i-1} = subs(W{i}, x, X_CELL{i});
        plot(X_CELL{i}+shift(i), R_W{i-1})
    end
    grid on
    title("Зависимость "+lab+"(x)")
    xlabel("x (м)")
    ylabel(lab)
    hold off
end

function PartPlot(W, X_CELL, shift, lab)
    syms x
    figure()
    hold on
    R_W = subs(W, x, X_CELL);
    plot(X_CELL+shift, R_W)
    grid on
    title("Зависимость "+lab+"(x)")
    xlabel("x (м)")
    ylabel(lab)
    hold off
end

function MyPlot(W, X_CELL, shift, lab)
    syms x
    R_W = cell(4,1);
    figure()
    hold on
    for i=1:1:4
        R_W{i} = subs(W{i}, x, X_CELL{i});
        plot(X_CELL{i}+shift(i), R_W{i})
    end
    grid on
    title("Зависимость "+lab+"(x)")
    xlabel("x (м)")
    ylabel(lab)
    hold off
end


%{
[C1(1), C2(1)] = solve(eqns, vars)

W(1,1) = exp(-kappa*x)*(C1*cos(kappa*x)+C2*sin(kappa*x))+nu*R/(E*h)*Nx

R_x = 0:0.001:l/2;

R_W = double(subs(W1, x, R_x))



figure
plot(R_x, R_W)
grid on
hold on
%%}
syms C1 C2 x
W = exp(-kappa*x)*(C1*cos(kappa*x)+C2*sin(kappa*x))+nu*R/(E*h)*Nx;


vars = [C1, C2];

[C1, C2] = solve(eqns, vars)
W = exp(kappa*x)*(C1*cos(kappa*x)-C2*sin(kappa*x))+nu*R/(E*h)*Nx;

R_x = -l/2:0.001:0;

R_W = double(subs(W, x, R_x))

R_x = R_x + l;

plot(R_x, R_W)
hold on
grid on

syms C1 C2 x
W = exp(-kappa*x)*(C1*cos(kappa*x)+C2*sin(kappa*x))+nu*R/(E*h)*Nx;

vars = [C1, C2];

[C1, C2] = solve(eqns, vars)
W = exp(-kappa*x)*(C1*cos(kappa*x)+C2*sin(kappa*x))+nu*R/(E*h)*Nx;

R_x = 0:0.001:l/2;

R_W = double(subs(W, x, R_x))

R_x = R_x + l;

plot(R_x, R_W)

%%{
syms C1 C2 x
W = exp(kappa*x)*(C1*cos(kappa*x)-C2*sin(kappa*x))+nu*R/(E*h)*Nx;


vars = [C1, C2];

[C1, C2] = solve(eqns, vars)
W = exp(kappa*x)*(C1*cos(kappa*x)-C2*sin(kappa*x))+nu*R/(E*h)*Nx;

R_x = l+l/2:0.001:2*l;

R_W = double(subs(W, x, R_x))

plot(R_x, R_W)
%}


