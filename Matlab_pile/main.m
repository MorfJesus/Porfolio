clear
close all
% Порядок работы с файлом:
% Файл разбит на 3 секции, разделенные двойными процентами %%
% При запуске 1-ой секции (кнопка Ran Section)загружается рисунок (схема)
% и строится график зависимости левой части частотного уравнения
% (определителя системы уравнений относительно констант)
% По этому графику в командной строке  вводится вектор b0 начальных 
% приближений для корней частотного уравнения
% Запускается 3-я секция (в данном примере 2-я, т.к. b0 уже определен)
% Здесь вычисляются собственные частоты и формы

% Построение схемы (для этого нужно схему преобразовать в формат jpg
% X=imread('РИСУНОК_1.JPG');%Схема конструкции
% figure(1)
% image(X)
% axis equal
% axis off

%1. ОПРЕДЕЛЕНИЕ СОБСТВЕННЫХ ЧАСТОТ И ФОРМ КОЛЕБАНИЙ
% Задание параметров системы (пока без учета параметров нагрузки и
% коэффициента демпфирования)
gamma=100;% жесткость пружины
% С использованием граничных условий составляем частотное уравнение
% (определитель матрицы А) и составляем файл-функцию f_beta
% Определяем первые 4 корня частотного уравнения (4 частотных параметра)
% с использованием функции fzero
% начальные приближения для этой функции определяем либо подбором 
% функции, либо построив график -
% зависимость определителя матрицы А от частотного параметра beta и
% оценить начальные приближения по графику 

beta=0:0.1:15; 
for k=1:length(beta)
    detA(k)=f_beta(beta(k));
end
figure(2)
plot(beta,detA,'LineWidth',2) % по графику определяем приближенно корни уравнения 
grid on
ylim([-10 10])
% Число частот и форм n
n=4;
%%
% 2 секция
% Образовать из первых 4 корней вектор
% b0=[beta0(1) beta0(2) beta0(3) beta0(4)], чтобы включить его
% в аргументы функции bet=f_bet_n(4,b0,gamma),
% в данном примере
b0=[3.29 6.28 9.428 12.56];
%{
%%
% 3 секция
% Определение частотных параметров
bet=f_bet_n(n,b0);
% Собственные частоты
om=bet.^2;
% Вывод собственных частот на экран
disp(om')
% Координаты сечений
x=0:0.01:2;
% Формы собственных колебаний
k = 1;
for i=x(1):0.01:x(end)
    yy=f_form(bet,i);
    y1(k) = yy(1);
    y2(k) = yy(2);
    y3(k) = yy(3);
    y4(k) = yy(4);
    k = k + 1;
end
figure(3)
hold on
plot(x,y1,'LineWidth',2)
plot(x,y2,'LineWidth',2)
plot(x,y3,'LineWidth',2)
plot(x,y4,'LineWidth',2)
hold off
grid on
%}