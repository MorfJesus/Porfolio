clc
clear

E=7*10^10; %Па
h=4.5/100; %м %
mu=0.3; %коэф. пуассона
p0=2.8*10^6; %Па
a1=80/100; a2=50/100; %м
param = 15; %предел для m,n


lins_a1 = linspace(0,a1,100);
lins_a2 = linspace(0,a2,100);

% Определим выражение для нагрузки p(x1,x2)
% Решим систему уравнений на участе x1=[0,a1/2]

figure(1)
x_1=0:0.01:a1/2;
y_11=(3*p0.*x_1/a1-p0/2);
plot(x_1, y_11, 'b'); grid on; hold on;
%plot(x_1, sola_1(2)*x_1.^2+solb_1(2)*x_1+solc_1(2))
%%%%% выбираем первые значения из найденных sola_1, solb_1, solc_1
%%%%% т.к. по графику они правдивые

% Решим систему уравнений на участе x1=[2a1/3,a1]

x_2=2*a1/3:0.01:a1;
y_11=(-9*p0/(2*a1).*x_2+4*p0);
plot(x_2, y_11,'b')
plot([a1/2 2*a1/3],[0 0], 'b') %построение нулевой нагрузки


% Найдем выражение для p_mn
syms x1 x2 m n
fi_mn = (sin(m*pi*x1/a1)*sin(n*pi*x2/a2));
fun1 = 4/a1/a2*(3*p0.*x1/a1-p0/2)*fi_mn;
fun2 = 4/a1/a2*(-9*p0/(2*a1).*x1+4*p0)*fi_mn;
% вычислим интегралы
int1_x1 = int(fun1, x1, 0, a1/2); %двойное интегрирование 1 участка
int1_x2 = int(int1_x1, x2, 0, a2);

int2_x1 = int(fun2, x1, 2*a1/3, a1); %двойное интегрирование 2 участка
int2_x2 = int(int2_x1, x2, 0, a2);

p_mn = simplify(int1_x2 + int2_x2);



symsum1_p = simplify(sum(subs(p_mn*fi_mn, n, 1:param)));
symsum2_p = simplify(sum(subs(symsum1_p, m, 1:param))); %аналитическое выражение для p(x1,x2)

p_in_x2 = subs(symsum2_p, x2, a2/2);
r = 0:0.001:a1;
parfor i=1:length(r)
p_result(i) = double(subs(p_in_x2, x1, r(i)));
end
plot(r, p_result, 'r'); hold off
grid on
xlabel('x1, м')
ylabel('p(x1,b/2), МПа')