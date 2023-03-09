% Определение собственных частот и форм 
% методом начальных параметров и 
% методом конечных элементов с варьированием числа КЭ
 
clear
%X=imread('Схема конструкции.jpg');%Схема конструкции
%figure(1)
%image(X)
axis equal
axis off
 
% Частотное уравнение по МНП (f_delta.m)составляется как
% условие нетривиальности решения системы уравнений
% относительно момента и поперечной силы в левой опоре
% стержня. Это уравнение получается из граничных условий
% на правом конце. При этом используются фундаментальные
% решения (f_Sform.m)
% и переходные матрицы, входящие в функцию (f_fg.m).
 
k1=4;
%k2=6;
 
 
bet=0.1:0.0005:9.;
del=zeros(1,length(bet));
delB=zeros(1,length(bet));
 
for j=1:length(bet)
    del(j)=f_delta(bet(j),k1);
    delB(j)=f_detB(bet(j),k1);
end
hold off
figure(1);
hold on;
grid on; 
set(gca,'ylim',[-5 5])
set(gca,'xlim',[0 9])
p1=plot(bet,delB/10^4);
p2=plot(bet,del/10);
set(p1,'Color','black','LineWidth',1)
set(p2,'Color','black','LineWidth',1.5)
 
title('Зависимость \Delta (\beta)')
ylabel('\Delta')
xlabel('\beta')
hold off

prompt={'Оценка первого корня',...
        'Оценка второго корня',...
        'Оценка третьего корня',...
        'Оценка четвертого корня',...
        'Оценка пятого корня'};
    
   
name='Ввод начальных приближений';
 
numlines=1;
defaultanswer={'2','3.5','5','6.5','8'};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
ns=inputdlg(prompt,name,numlines,defaultanswer,...
    options);
 
% Перевод начальных приближений из формата string
% в формат double и вычисление корней
b=zeros(1,length(ns));
beta=zeros(1,length(ns));
for j=1:length(ns)
    b(j)=str2double(ns(j))
    beta(j)=fzero('f_delta',b(j),[],k1);
end
 
plot(beta,zeros(1,length(beta)),'*')
 
text(beta(1),0.1,'\beta_1')
beta(1)
text(beta(2)+0.1,0.1,'\beta_2')
beta(2)
text(beta(3)+0.1,0.1,'\beta_3')
beta(3)
text(beta(4)+0.1,0.1,'\beta_4')
beta(4)
text(beta(5)+0.1,0.1,'\beta_5')
beta(5)
 
% Вывод на экран частотных параметров и собственных частот
disp(beta)
omega=beta.^2;
disp(omega)
 
% Построение собственных форм колебаний с использованием
% метода начальных параметров
x=0:0.001:1;
V1=zeros(length(x),length(beta));
V2=zeros(length(x),length(beta));
V12=zeros(2*length(x),length(beta));
for k=1:length(beta)  
   for j=1:length(x)
     [c,b,v1,v3]=f_fg(beta(k),k1);
     V1(j,k)=v1'*f_Sform(beta(k),x(j));
     V2(j,k)=(v3'*f_Sform(beta(k),x(j)));
   end  
end % Объединение массивов V1 и V2 
M=max([V1;V2],[],1);
 
for k=1:length(beta)
    V12(:,k)=(1/k)*[V1(:,k);V2(:,k)]/M(k);
end % Масштабирование амплитудных значений форм колебаний
 
figure(2);
hold off
hold on;

%box on
V12(length(x)+1:end,1)=V12(length(x)+1:end,1)*2+1.6


length(x)
p3=plot([x 1+x],V12);
grid on;
set(p3,'LineWidth',2)
title('Формы собственных колебаний Метод нач. параметров')
ylabel('V_k')
xlabel('x')
text(1.1,0.90,'1','Fontsize',14);
text(0.7,0.55,'2','Fontsize',14);
text(1.6,0.3,'3','Fontsize',14);
text(1.2,0.3,'4','Fontsize',14);
text(1.4,-0.18,'5','Fontsize',14);

hold off

function y=f_detB(b,k1)

B=f_B(b,k1);

y=det(B);
end


