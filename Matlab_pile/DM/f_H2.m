function y=f_H2(x,a)
y(1,:)=(1-3*(x/a)^2+2*(x/a)^3);
y(2,:)=a*((x/a)-2*(x/a)^2+(x/a)^3);
y(3,:)=(3*(x/a)^2-2*(x/a)^3);
y(4,:)=a*((x/a)^3-(x/a)^2);
