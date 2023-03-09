clear
close all
syms CC1 CC2 CC3 CC4 x

step = 0.01;

kappa = 13.658;
nu = 0.3;
R = 0.65;
h = 0.01;
Nx = 1714;
E = 2*10^11;
l0 = 0.2016;
l = 1.4;
D = 18315;
q = 5000;
m = 4000;

WEQR = exp(-kappa*x)*(CC1*cos(kappa*x)+CC2*sin(kappa*x))+nu*R/(E*h)*Nx;
WEQL = exp(kappa*x)*(CC1*cos(kappa*x)+CC2*sin(kappa*x))+nu*R/(E*h)*Nx;

WEQ = exp(-kappa*x)*(CC1*cos(kappa*x)+CC2*sin(kappa*x))+exp(kappa*x)*(CC3*cos(kappa*x)+CC4*sin(kappa*x))+nu*R/(E*h)*Nx;

W = {WEQR, WEQL, WEQR, WEQL};
dW = cell(3,1);
M = cell(3,1);
Q = cell(3,1);

C1 = zeros(3, 1);
C2 = zeros(3, 1);
C3 = zeros(3, 1);
C4 = zeros(3, 1);
%%{

eqns1 = [subs(WEQR, x, 0) == 0
    subs(diff(WEQR, x), x, 0) == 0];
%{
eqns2 = [D*subs(diff(WEQR, x, 2), x, 0) == -m/2
    D*subs(diff(WEQR, x, 3), x, 0) == q/2];

eqns3 = [D*subs(diff(WEQR, x, 2), x, 0) == -m/2
    D*subs(diff(WEQR, x, 3), x, 0) == q/2];
%}

%{
%%ТЕСТ1%%
eqns2 = [D*subs(diff(WEQL, x, 1), x, 0) == 0
    D*subs(diff(WEQL, x, 3), x, 0) == -q/2];

eqns3 = [D*subs(diff(WEQR, x, 1), x, 0) == 0
    D*subs(diff(WEQR, x, 3), x, 0) == q/2];
%}

%%ТЕСТ2%%
eqns2 = [subs(WEQ, x, 0) == 0
    D*subs(diff(WEQ, x, 2), x, 0) == m/2];

eqns3 = [D*subs(diff(WEQL, x, 2), x, 0) == 2*m
    D*subs(diff(WEQL, x, 3), x, 0) == q/2];

EQNS = {eqns1, eqns2, eqns3};

vars = [CC1, CC2, CC3, CC4];

x_r = 0:step:l/2;
x_l = -l/2:step:0;
x_b = -l/2:step:l/2;

X_CELL = {x_r, x_b, x_l};

shift = [0, l, l, 2*l];



for i=1:1:3
    [C1(i), C2(i), C3(i), C4(i)] = solve(EQNS{i}, vars);
    W{i} = subs(W{i}, [CC1, CC2], [C1(i), C2(i)]);
    dW{i} = diff(W{i}, x, 1);
    M{i} =D*diff(W{i}, x, 2);
    Q{i} =D*diff(W{i}, x, 3);
    %R_W{i} = subs(W{i}, x, X_CELL{i});
    %plot(X_CELL{i}+shift(i), R_W{i})
end

MyPlot(W, X_CELL, shift)
MyPlot(dW, X_CELL, shift)
MyPlot(M, X_CELL, shift)
MyPlot(Q, X_CELL, shift)

function MyPlot(W, X_CELL, shift)
    syms x
    R_W = cell(3,1);
    figure()
    hold on
    for i=1:1:3
        R_W{i} = subs(W{i}, x, X_CELL{i});
        plot(X_CELL{i}+shift(i), R_W{i})
    end
    grid on
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


