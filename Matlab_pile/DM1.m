clear
k1=1; %коэффициент при массе 
k2=6; %коэффициент при пружине
b=0:0.01:9;
for k=1:length(b)
    y(k)=f_detB10(b(k),k1,k2)/10^4;
end
figure(2); p1=plot(b,y);grid on;hold on
ylim([-5 5]);xlim([0 9]);
set(p1,'Color','black','LineWidth',1.5)
beta=zeros(1,5);
for j=1:5
      beta(j)=fzero('f_detB10',(pi/8)*(4*j+1),[],k1,k2);
end
disp([3.927/2 7.069/2 13*pi/8 17*pi/8 21*pi/8])
disp(beta)
figure(2)
plot(beta,[0 0 0 0 0],'*')
grid on
text(beta(1),0.1,'\beta_1')
text(beta(2)+0.1,0.1,'\beta_2')
text(beta(3)+0.1,0.1,'\beta_3')
text(beta(4)+0.1,0.1,'\beta_4')
text(beta(5)+0.1,0.1,'\beta_5')

%------------------------------
x=0:0.001:2;
F=f_form10(beta,x,k1,k2);
figure(3)
plot(x,F)
grid on
