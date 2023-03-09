% Определение собственных частот и форм 
% методом начальных параметров и 
% методом конечных элементов с варьированием числа КЭ
 
clear
%X=imread('Схема конструкции.jpg');%Схема конструкции
%figure(1)
%image(X)
%axis equal
%axis off
 
% Частотное уравнение по МНП (f_delta.m)составляется как
% условие нетривиальности решения системы уравнений
% относительно момента и поперечной силы в левой опоре
% стержня. Это уравнение получается из граничных условий
% на правом конце. При этом используются фундаментальные
% решения (f_Sform.m)
% и переходные матрицы, входящие в функцию (f_fg.m).
 
k1=1;
k2=12;
 
 
bet=0.1:0.0005:9.;
del=zeros(1,length(bet));
delB=zeros(1,length(bet));
 
for j=1:length(bet)
    del(j)=f_delta2(bet(j),k1,k2);
    delB(j)=f_detB2(bet(j),k1,k2);
end
figure(2);hold on; grid on; 
set(gca,'ylim',[-5 5])
set(gca,'xlim',[0 9])
p1=plot(bet,delB/10^4);
p2=plot(bet,del/10^4);
set(p1,'Color','black','LineWidth',1)
set(p2,'Color','black','LineWidth',1.5)
 
title('Зависимость \Delta (\beta)')
ylabel('\Delta')
xlabel('\beta')
 
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
    b(j)=str2double(ns(j));
    beta(j)=fzero('f_delta2',b(j),[], k1, k2);
end
 
plot(beta,zeros(1,length(beta)),'*')
 
text(beta(1),0.1,'\beta_1')
text(beta(2)+0.1,0.1,'\beta_2')
text(beta(3)+0.1,0.1,'\beta_3')
text(beta(4)+0.1,0.1,'\beta_4')
text(beta(5)+0.1,0.1,'\beta_5')
 
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
     [c,b,v1,v3]=f_fg2(beta(k),k1,k2);
     V1(j,k)=v1'*f_Sform3(beta(k),x(j));
     V2(j,k)=v3'*f_Sform3(beta(k),x(j));
   end  
end
M=max([V1;V2],[],1);
 
for k=1:length(beta)
    V12(:,k)=(1/k)*[V1(:,k);V2(:,k)]/M(k);
end


%V12 = [V1(:,2);V2(:,2)-(V2(1,2)-V1(end,2))];
%V2(:,1)
figure(3);hold on; grid on; box on
p3=plot([x 1+x],V12);
set(p3,'LineWidth',2)
title('Формы собственных колебаний Метод нач. параметров')
ylabel('V_k')
xlabel('x')
text(1.1,0.90,'1','Fontsize',14);
text(0.7,0.55,'2','Fontsize',14);
text(1.6,0.3,'3','Fontsize',14);
text(1.2,0.3,'4','Fontsize',14);
text(1.4,-0.18,'5','Fontsize',14);



% Метод конечных элементов
% n- число КЭ
% Вычисление собственных частот для 2-х, 4-х,
% 6-и и 8-и конечных элементов
for n=[2, 4, 6, 8];
    a=2/n;% длина конечного элемента
    
    [K1,M1]=f_KM2(a); % матрица жесткости и матрица масс для
    % КЭ длиной a
 
    K=zeros(2*n+2,2*n+2,n); % Заготовка трехмерных массивов
    M=zeros(2*n+2,2*n+2,n); % для построения глобальных матриц
    
% Расширение матриц каждого КЭ до размера глобальной
for k=1:n
    K(2*k-1:2*k+2,2*k-1:2*k+2,k)=K1;
    M(2*k-1:2*k+2,2*k-1:2*k+2,k)=M1;
end
 
% формирование глобальных матриц
Kg=sum(K,3);
Mg=sum(M,3);
 
% Учет пружины и сосредоточенной массы
Kg(n+1,n+1)=Kg(n+1,n+1)+k2
Mg(n+1,n+1)=Mg(n+1,n+1)+k1


% Учет граничных условий
Kp=[Kg(3:2*n,3:2*n) Kg(3:2*n,2*n+2)]
Ks=[Kp;Kg(2*n+2,3:2*n) Kg(2*n+2,2*n+2)]
 
 
Mp=[Mg(3:2*n,3:2*n) Mg(3:2*n,2*n+2)]
Ms=[Mp;Mg(2*n+2,3:2*n) Mg(2*n+2,2*n+2)]

%Ks = Kg(3:end,3:end)
%Ms = Mg(3:end,3:end)
switch n
        case 2
        om2=sqrt(sort(eig(Ks,Ms)));
        %om2(1) = 5.3674;
        omega(1) = 3.6599;
        omega(2) = 12.0056;
        omega(3) = 22.0578;
        omega(4) = 43.4219;
        omega(5) = 60.1428;
  %-----------------------------------------
  % Вычисление собственных частот и форм для случая 4 конечных
  % элементов
    case 4
        % Для случая n=4 построим формы собственных колебаний,
        % поэтому оператор om4=sqrt(sort(eig(Ks,Ms)))заменим на
        [om4,in]=sort(sqrt(eig(Ks,Ms)));
        % чтобы с помощью вектора индексов in упорядочить собственные 
        % вектора vs
        [vs,om4s]=eig(Ks,Ms);
        v=vs(:,in);
        % С учетом кинематических граничных условий и столбцов
        % двумерного массива v(:,k) (k-номер формы) определим вектора
        % узловых перемещений
        v11=[0 0 v(1,1) v(2,1)];
        v21=[v(1,1) v(2,1) v(3,1) v(4,1)];
        v31=[v(3,1) v(4,1) v(5,1) v(6,1)];
        v41=[v(5,1) v(6,1) 0 v(7,1)];
        
        v12=[0 0 v(1,2) v(2,2)];
        v22=[v(1,2) v(2,2) v(3,2) v(4,2)];
        v32=[v(3,2) v(4,2) v(5,2) v(6,2)];
        v42=[v(5,2) v(6,2) 0 v(7,2)];
        
        v13=[0 0 v(1,3) v(2,3)];
        v23=[v(1,3) v(2,3) v(3,3) v(4,3)];
        v33=[v(3,3) v(4,3) v(5,3) v(6,3)];
        v43=[v(5,3) v(6,3) 0 v(7,3)];
        
        v14=[0 0 v(1,4) v(2,4)];
        v24=[v(1,4) v(2,4) v(3,4) v(4,4)];
        v34=[v(3,4) v(4,4) v(5,4) v(6,4)];
        v44=[v(5,4) v(6,4) 0 v(7,4)];

                    
     xk=0:a/100:a;
     
     H=zeros(4,length(xk));
     Z=zeros(1,length(xk));
     Y11=Z; Y21=Z; Y31=Z; Y41=Z;
     Y12=Z; Y22=Z; Y32=Z; Y42=Z;
     Y13=Z; Y23=Z; Y33=Z; Y43=Z;
     Y14=Z; Y24=Z; Y34=Z; Y44=Z;
      
    for j=1:length(xk)
        H(:,j)=f_H2(xk(j),a);
        
        Y11(j)=v11*H(:,j); Y21(j)=v21*H(:,j);
        Y31(j)=v31*H(:,j); Y41(j)=v41*H(:,j);
        
        Y12(j)=v12*H(:,j); Y22(j)=v22*H(:,j);
        Y32(j)=v32*H(:,j); Y42(j)=v42*H(:,j);
        
        Y13(j)=v13*H(:,j); Y23(j)=v23*H(:,j);
        Y33(j)=v33*H(:,j); Y43(j)=v43*H(:,j);
        
        Y14(j)=v14*H(:,j); Y24(j)=v24*H(:,j);
        Y34(j)=v34*H(:,j); Y44(j)=v44*H(:,j);
      
    end
    L=[xk a+xk 2*a+xk 3*a+xk];
    
    F1=[Y11 Y21 Y31 Y41];F2=[Y12 Y22 Y32 Y42];
    F3=[Y13 Y23 Y33 Y43];F4=[Y14 Y24 Y34 Y44];
   
    F1=F1/max(F1);F2=F2/max(F2);F3=F3/max(F3);F4=F4/max(F4);
      
 % ---------------------------------------  
      
    case 6
        om6=sqrt(sort(eig(Ks,Ms)));
    case 8
        om8=sqrt(sort(eig(Ks,Ms)));
end
end

        

figure(4); hold on; box on;grid on;
title('Частоты собственных колебаний')
set(gca,'xTick',[1 2 3 4 5]);
ylabel('\omega_k')
xlabel('№ частоты')
plot(omega,'-*'); text(4.5,50,'Точн.');
plot(om2(1:3),'-o');text(2.5,30,'2 КЭ')
plot(om4(1:5),'-o'); text(3.6,50,'4 КЭ');
plot(om6(1:5),'-o'); text(4.7,60,'6 КЭ');
plot(om8(1:5),'-o')
 
% Составление таблицы для сравнения частот

A=[om2(1:3)' NaN NaN;
    round((om2(1)-omega(1))/omega(1)*100, 4) round((om2(2)-omega(2))/omega(2)*100, 4) round((om2(3)-omega(3))/omega(3)*100, 4) NaN NaN
    (om4(1:5))';
    round((om4(1)-omega(1))/omega(1)*100, 4) round((om4(2)-omega(2))/omega(2)*100, 4) round((om4(3)-omega(3))/omega(3)*100, 4) round((om4(4)-omega(4))/omega(4)*100, 4) round((om4(5)-omega(5))/omega(5)*100, 4)
    (om6(1:5))';
    round((om6(1)-omega(1))/omega(1)*100, 4) round((om6(2)-omega(2))/omega(2)*100, 4) round((om6(3)-omega(3))/omega(3)*100, 4) round((om6(4)-omega(4))/omega(4)*100, 4) round((om6(5)-omega(5))/omega(5)*100, 4)
    (om8(1:5))';
    round((om8(1)-omega(1))/omega(1)*100, 4) round((om8(2)-omega(2))/omega(2)*100, 4) round((om8(3)-omega(3))/omega(3)*100, 4) round((om8(4)-omega(4))/omega(4)*100, 4) round((om8(5)-omega(5))/omega(5)*100, 4)
    omega];
 
% Перевод массива частот в массив ячеек для отображения
% на фигуре
 
 C=num2cell(A); 

 figure(5);hold on; grid on; box on
 h5=gca;
 set(h5,'xTick',[0 0.2 0.4 0.6 0.8 1]);
 set(h5,'yTick',[0 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1]);
 set(h5,'xTicklabel','');
 set(h5,'yTicklabel','');
 text(0.1,1.04,'\omega_1','Fontsize',12);
 text(0.3,1.04,'\omega_2','Fontsize',12);
 text(0.5,1.04,'\omega_3','Fontsize',12);
 text(0.7,1.04,'\omega_4','Fontsize',12);
 text(0.9,1.04,'\omega_5','Fontsize',12);
 
 text(-0.1,0.95,'2 КЭ');
 text(-0.15,0.85,'% ПОГР.');
 text(-0.1,0.75,'4 КЭ');
 text(-0.15,0.65,'% ПОГР.');
 text(-0.1,0.55,'6 КЭ');
 text(-0.15,0.45,'% ПОГР.');
 text(-0.1,0.35,'8 КЭ');
 text(-0.15,0.25,'% ПОГР.');
 text(-0.1,0.1,'Точн.','Fontsize',12);
 
 for j=1:8
     for k=1:5
         text(0.05+(k-1)*0.2,0.95-(j-1)*0.1,C(j,k));
     end
 end

 for k=1:5
         text(0.05+(k-1)*0.2,0.1,C(9,k));
 end

  %}
% -------------------------------------
% Построение собственных форм, полученных по МКЭ
 figure(6);hold on; grid on; box on
 h6=plot(L,F1,L,F2/2,L,F3/3,L,-F4/4);
 %V12 = 0.98*V12;
% h6 = plot([x 1+x],V12);
 set(h6,'LineWidth',2)
 title('Формы собственных колебаний 4 КЭ')
 ylabel('F_k')
 xlabel('x')
 
 text(1.1,.9,'1','Fontsize',14);
 text(0.7,0.55,'2','Fontsize',14);
 text(1.6,0.25,'3','Fontsize',14);
 text(1.3,0.3,'4','Fontsize',14); 
 %{
 text(1.1,0.90,'1','Fontsize',14);
text(0.7,0.55,'2','Fontsize',14);
text(1.6,0.3,'3','Fontsize',14);
text(1.2,0.3,'4','Fontsize',14);
text(1.4,-0.18,'5','Fontsize',14);
%}
 function y=f_Sform3(beta,x)
y(1,:)=(1/2)*(cosh(beta*x)+cos(beta*x));
y(2,:)=(1/2)*(sinh(beta*x)+sin(beta*x))/beta;
y(3,:)=(1/2)*(cosh(beta*x)-cos(beta*x))/beta^2;
y(4,:)=(1/2)*(sinh(beta*x)-sin(beta*x))/beta^3;
end

function y=f_detB2(x,k1,k2)
   B=f_B2(x,k1,k2);
   y=det(B);
end

function y=f_B2(x,k1,k2)
   B11=[0 1 0 1;
       1 0 1 0;
       sin(x) cos(x) sinh(x) cosh(x);
       cos(x) -sin(x) cosh(x) sinh(x)];
   B12=[0 0 0 0;
       0 0 0 0;
       -sin(x) -cos(x) -sinh(x) -cosh(x);
       -cos(x) sin(x) -cosh(x) -sinh(x)];
   b11=[-sin(x) -cos(x);
       (k1*x-2*k2/x^3)*sin(x)-cos(x) ...
       (k1*x-2*k2/x^3)*cos(x)+sin(x)];
   b12=[sinh(x) cosh(x);
       (k1*x-2*k2/x^3)*sinh(x)+cosh(x) ...
       (k1*x-2*k2/x^3)*cosh(x)+sinh(x)];
   b21=[0 0;
       0 0];
   b22=b21;
   B21=[b11 b12;
       b21 b22];
       B22=[sin(x) cos(x) -sinh(x) -cosh(x);
           cos(x) -sin(x) -cosh(x) -sinh(x);
           sin(2*x) cos(2*x) sinh(2*x) cosh(2*x);
           -sin(2*x) -cos(2*x) sinh(2*x) cosh(2*x)];
y=[B11 B12;B21 B22];
end


function y=f_form2(beta,x,k1,k2)
n=length(beta);
m=length(x);
y=zeros(n,m);
for j=1:n
     C=zeros(8,1);
     B=f_B2(beta(j),k1,k2);
  
     C(1)=1;
     C(2:8)=B(2:8,2:8)^-1*(-B(2:8,1));
    for k=1:m
        if x(k)<1
           y(j,k)=C(1)*sin(beta(j)*x(k))+C(2)*cos(beta(j)*x(k))+C(3)*sinh(beta(j)*x(k))+C(4)*cosh(beta(j)*x(k));
        else
           y(j,k)=C(5)*sin(beta(j)*x(k))+C(6)*cos(beta(j)*x(k))+C(7)*sinh(beta(j)*x(k))+C(8)*cosh(beta(j)*x(k));
        end
    end
end
end