close all

%A_x = 6.33;
%A_y = 21.74;
Ju = 5041.03;
Jv = 22135.97;
global HV
HV = 100;
x_1 = [0, 0, 32.6, 32.6, 16.3, 16.3, 32.6];
%x_1 = [0, 0, 31.6, 31.6, 16.3, 16.3, 32.6]; %%%%
y_1 = [0, 18.3, 18.3, 8.6, 18.3, 4.1, 4.1];

width = [2, 2, 2, 2, 1, 1, 1];

%x_2 = [16.3, 16.3, 32.6];
%y_2 = [18.3, 4.1, 4.1];

X_C = 16.32;
Y_C = 13.264;
%%{
hold on
alpha = 0.07616;
%%{
plot(polyshape([1 -1 -1 1],[0 0 19.3 19.3]), 'FaceAlpha', 0)
plot(polyshape([1 33.6 33.6 1],[17.3 17.3 19.3 19.3]), 'FaceAlpha', 0)
plot(polyshape([33.6 31.6 31.6 33.6],[17.3 17.3 19.3-10.7 19.3-10.7]), 'FaceAlpha', 0)
plot(polyshape([15.8 16.8 16.8 15.8],[17.3 17.3 19.3-15.7 19.3-15.7]), 'FaceAlpha', 0)
plot(polyshape([16.8 32.6 32.6 16.8],[19.3-15.7 19.3-15.7 19.3-14.7 19.3-14.7]), 'FaceAlpha', 0)
plot(x_1(1:4), y_1(1:4), 'color','#888888')
plot(x_1(5:7), y_1(5:7), 'color','#888888')
%{
plot(0, 18.3, 'o', 'color', 'black', 'MarkerSize', 24)
plot(0, 18.3, '+', 'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)
%}
plot([0 0], [19.3 21.3],'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)
plot(0, 21.3, '^', 'color', 'black', 'MarkerSize', 12, 'LineWidth', 2)

plot([33.6 35.6], [19.3 19.3],'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)
plot(35.6, 19.3, '>', 'color', 'black', 'MarkerSize', 12, 'LineWidth', 2)

plot([31.6 29.6], [8.6 8.6],'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)
plot(29.6, 8.6, '<', 'color', 'black', 'MarkerSize', 12, 'LineWidth', 2)

plot([32.6 32.6], [7.1 5.1],'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)
plot(32.6, 5.1, 'v', 'color', 'black', 'MarkerSize', 12, 'LineWidth', 2)

plot([32.6 32.6], [3.6 1.6],'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)
plot(32.6, 1.6, 'v', 'color', 'black', 'MarkerSize', 12, 'LineWidth', 2)

plot(X_C, Y_C, '.', 'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)
%{
plot(16.3, 4.1, 'o', 'color', 'black', 'MarkerSize', 24)
plot(16.3, 4.1, '.', 'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)

plot(X_C, Y_C, '.', 'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)
%}
axis equal
%}
%{
plot(0, 0, 'd', 'color', 'black')
plot([0 0],[0 10], 'linewidth', 1.5, 'color', 'black')
plot([0 10],[0 0], 'linewidth', 1.5, 'color', 'black')

plot([X_C X_C],[Y_C Y_C+10], 'linewidth', 1.5, 'color', 'black')
plot([X_C X_C+10],[Y_C Y_C], 'linewidth', 1.5, 'color', 'black')

plot(X_C, Y_C, 'd', 'color', 'black')

plot([X_C X_C-10*sin(alpha)],[Y_C (Y_C+10)*cos(alpha)], 'linewidth', 1.5, 'color', 'black')
plot([X_C (X_C+10)*cos(alpha)],[Y_C Y_C+10*sin(alpha)], 'linewidth', 1.5, 'color', 'black')

plot(6.4172, 21.4056, 'd', 'color', 'black')

%}
xlim([-5, 40])
ylim([-5, 25])
grid on
hold off
%}
%{
hold on
plot(x_1(1:4), y_1(1:4), 'color','#000000')
plot(x_1(5:7), y_1(5:7), 'color','#000000')
%plot(6.4172, 21.4056, 'd', 'color', 'black')
%plot(6.6843, 21.9812, 'd', 'color', 'black')
xlim([-5, 35])
ylim([-5, 35])
grid on
hold off
%}

%X_C = 14.96; %%%
%Y_C = 13.19; %%%

x_d1 = x_1 - X_C;
y_d1 = y_1 - Y_C;

koef = 5;
%x_d1
%y_d1
%%gr_plot(x_1, y_1, x_d1, 3) %plot X
%%gr_plot(x_1, y_1, y_d1, 3) %plot Y

alpha = 0.07616;

%alpha = 0.0707; %%%

u = x_d1.*cos(alpha)+y_d1.*sin(alpha);
v = -x_d1.*sin(alpha)+y_d1.*cos(alpha);

u
v

%%gr_plot(x_1, y_1, u, 3) %plot U
%%gr_plot(x_1, y_1, v, 3) %plot V

O_x = 0;
O_y = 18.3;

%O_x = 6.33;
%O_y = 18.3+3.44;
%{%%%%%%%%%%%%%%%%%%%%%%%%%%%
W1 = W_ep(x_1, y_1, O_x, O_y)

%W
%u
%%gr_plot(x_1, y_1, W1, 60) %W1

S_uw = S_int(x_1, y_1, W1, v)
S_vw = S_int(x_1, y_1, W1, u)

A_u = S_uw/Ju
A_v = -S_vw/Jv
A_x = A_u*cos(alpha)-A_v*sin(alpha)+O_x
A_y = A_u*sin(alpha)+A_v*cos(alpha)+O_y

WA = W_ep(x_1, y_1, A_x, A_y)
%%gr_plot(x_1, y_1, WA, 50)

S_intAR(x_1, y_1, WA)
C1 = -S_intAR(x_1, y_1, WA)/150.7
W = WA+C1
%%gr_plot(x_1, y_1, W, 40)

S_intAR(x_1, y_1, W)
AAAAAAA=S_int(x_1, y_1, W, W)

F = 150.7*10^-4;
P = 1.6*10^3;

Ju = 5041.03*10^-8;
Jv = 22135.97*10^-8;
u
v
Jw = AAAAAAA*10^-12;

%Bw = -47.9744;
Bw = 62.5115;
%Bw = -14.6787;
%Bw = -10.12;

%Mu = 1.76948*10^3;
Mu = -0.902007;
%Mu = -2.561462*10^3;
%Mu = 0.147471*10^3;

%Mv = -0.992059*10^3;
Mv = 0.266503;
%Mv = 1.48033*10^3;
%Mv = -0.174627*10^3;


SIGU = -(Mu/Ju).*v.*10^-2.*10^-6
SIGV = -(Mv/Jv).*u.*10^-2.*10^-6
SIGW =  (Bw/Jw).*W.*10^-4.*10^-6
SIGZ = ((3/4)*P-(5/8)*P)/F*10^-6+u.*0
gr_plot(x_1, y_1, SIGU, 0.09)
gr_plot(x_1, y_1, SIGV, 0.033)
gr_plot(x_1, y_1, SIGW, 0.08)
gr_plot(x_1, y_1, SIGZ, 1/250)
gr_plot(x_1, y_1, SIGU+SIGV+SIGW+SIGZ, 0.08)
gr_plot(x_1, y_1, sqrt((SIGU+SIGV+SIGW+SIGZ).^2), 0.8)
Wk1 = 2.4*10^-5;
Wk2 = 4.3*10^-5;
Wk3 = 1.15*10^-5;
Wk4 = 4.52*10^-6;
Wk5 = 5.21*10^-6;

%Mk = 0; 
Mk = -32.5398;
%Mk = -7.36161;
%Mk = -59.2184;

tau(1) = Mk/Wk1;
tau(2) = Mk/Wk1;
tau(3) = Mk/Wk2;
tau(4) = Mk/Wk2;
tau(5) = Mk/Wk3;
tau(6) = Mk/Wk3;
tau(7) = Mk/Wk4;
tau(8) = Mk/Wk4;
tau(9) = Mk/Wk5;
tau(10) = Mk/Wk5;
tau=tau*10^-6
ZZ = [0, 0, 0, 0, 0, 0, 0];
gr_plotTAU(x_1, y_1, tau, 1, ZZ)

SIGSUM(1) = sqrt((SIGU(1)+SIGV(1)+SIGW(1)+SIGZ(1)).^2+4*tau(1).^2);
SIGSUM(2) = sqrt((SIGU(2)+SIGV(2)+SIGW(2)+SIGZ(2)).^2+4*tau(2).^2);
SIGSUM(3) = sqrt((SIGU(2)+SIGV(2)+SIGW(2)+SIGZ(2)).^2+4*tau(3).^2);
SIGSUM(4) = sqrt((SIGU(3)+SIGV(3)+SIGW(3)+SIGZ(3)).^2+4*tau(4).^2);
SIGSUM(5) = sqrt((SIGU(3)+SIGV(3)+SIGW(3)+SIGZ(3)).^2+4*tau(5).^2);
SIGSUM(6) = sqrt((SIGU(4)+SIGV(4)+SIGW(4)+SIGZ(4)).^2+4*tau(6).^2);
SIGSUM(7) = sqrt((SIGU(5)+SIGV(5)+SIGW(5)+SIGZ(5)).^2+4*tau(7).^2);
SIGSUM(8) = sqrt((SIGU(6)+SIGV(6)+SIGW(6)+SIGZ(6)).^2+4*tau(8).^2);
SIGSUM(9) = sqrt((SIGU(6)+SIGV(6)+SIGW(6)+SIGZ(6)).^2+4*tau(9).^2);
SIGSUM(10) = sqrt((SIGU(7)+SIGV(7)+SIGW(7)+SIGZ(7)).^2+4*tau(10).^2);


SIGU+SIGV+SIGW+SIGZ
SIGSUM
gr_plotTAU(x_1, y_1, SIGSUM, 2.5, sqrt((SIGU+SIGV+SIGW+SIGZ).^2))
%}%%%%%%%%%%%%%%%%%%%%%%%%%%







%{
hold on
plot(polyshape([1 -1 -1 1],[0 0 19.3 19.3]), 'FaceAlpha', 0)
plot(polyshape([1 33.6 33.6 1],[17.3 17.3 19.3 19.3]), 'FaceAlpha', 0)
plot(polyshape([33.6 31.6 31.6 33.6],[17.3 17.3 19.3-10.7 19.3-10.7]), 'FaceAlpha', 0)
plot(polyshape([15.8 16.8 16.8 15.8],[17.3 17.3 19.3-15.7 19.3-15.7]), 'FaceAlpha', 0)
plot(polyshape([16.8 32.6 32.6 16.8],[19.3-15.7 19.3-15.7 19.3-14.7 19.3-14.7]), 'FaceAlpha', 0)
plot(x_1(1:4), y_1(1:4), 'color','#888888')
plot(x_1(5:7), y_1(5:7), 'color','#888888')
%{
plot(0, 18.3, 'o', 'color', 'black', 'MarkerSize', 24)
plot(0, 18.3, '+', 'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)
%}
plot([0 0], [19.3 21.3],'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)
plot(0, 21.3, '^', 'color', 'black', 'MarkerSize', 12, 'LineWidth', 2)

plot([33.6 35.6], [19.3 19.3],'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)
plot(35.6, 19.3, '>', 'color', 'black', 'MarkerSize', 12, 'LineWidth', 2)

plot([31.6 29.6], [8.6 8.6],'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)
plot(29.6, 8.6, '<', 'color', 'black', 'MarkerSize', 12, 'LineWidth', 2)

plot([32.6 32.6], [7.1 5.1],'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)
plot(32.6, 5.1, 'v', 'color', 'black', 'MarkerSize', 12, 'LineWidth', 2)

plot([32.6 32.6], [3.6 1.6],'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)
plot(32.6, 1.6, 'v', 'color', 'black', 'MarkerSize', 12, 'LineWidth', 2)

plot(A_x, A_y, '.', 'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)
%{
plot(16.3, 4.1, 'o', 'color', 'black', 'MarkerSize', 24)
plot(16.3, 4.1, '.', 'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)

plot(X_C, Y_C, '.', 'color', 'black', 'MarkerSize', 24, 'LineWidth', 2)
%}
axis equal
%{
plot(0, 0, 'd', 'color', 'black')
plot([0 0],[0 10], 'linewidth', 1.5, 'color', 'black')
plot([0 10],[0 0], 'linewidth', 1.5, 'color', 'black')

plot([X_C X_C],[Y_C Y_C+10], 'linewidth', 1.5, 'color', 'black')
plot([X_C X_C+10],[Y_C Y_C], 'linewidth', 1.5, 'color', 'black')

plot(X_C, Y_C, 'd', 'color', 'black')

plot([X_C X_C-10*sin(alpha)],[Y_C (Y_C+10)*cos(alpha)], 'linewidth', 1.5, 'color', 'black')
plot([X_C (X_C+10)*cos(alpha)],[Y_C Y_C+10*sin(alpha)], 'linewidth', 1.5, 'color', 'black')

plot(6.4172, 21.4056, 'd', 'color', 'black')

%}
xlim([-5, 40])
ylim([-5, 25])
grid on
hold off


%{
for i=1:length(x_1)-1
    temp_x = [x_1(i), x_1(i+1), A_x];
    temp_y = [y_1(i), y_1(i+1), A_y];
    a = polyarea(temp_x,temp_y)*2
end

x_2 = [16.3, 16.3, 32.6];
y_2 = [18.3, 4.1, 4.1];

for i=1:length(x_2)-1
    temp_x = [x_2(i), x_2(i+1), A_x];
    temp_y = [y_2(i), y_2(i+1), A_y];
    a = polyarea(temp_x,temp_y)*2
end

A = [0, -306.52]
B = [16.96, 16.27]
306.52*16.27*9.7
%}

%}





function gr_plotTAU(x, y, x_d, koef, x_d2)

figure()
hold off
hold on


VPlotTAU(-x_d(1)/koef, -x_d(2)/koef, y(1), y(2), x(1), 15, -x_d2(1)/koef, -x_d2(2)/koef)
%if x_d(1)~=0
%    text(0, -1,num2str(abs(x_d(1))));
%end
%if x_d(2)~=0
%    text(-0.3, 20,num2str(abs(x_d(2))), 'HorizontalAlignment', 'right');
%end
HPlotTAU(x(2), x(3), x_d(3)/koef+y(2), x_d(4)/koef+y(3), y(2) ,30, x_d2(2)/koef+y(2), x_d2(3)/koef+y(3))
%if x_d(3)~=0
%    text(33.6, 21,num2str(abs(x_d(3))));
%end
VPlotTAU(x_d(5)/koef+x(3), x_d(6)/koef+x(4), y(3), y(4), x(3), 8, x_d2(3)/koef+x(3), x_d2(4)/koef+x(4))
%if x_d(4)~=0
%    text(33.6, 7.5,num2str(abs(x_d(4))));
%end
VPlotTAU(x_d(7)/koef+x(5), x_d(8)/koef+x(6), y(5), y(6), x(5), 12, x_d2(5)/koef+x(5), x_d2(6)/koef+x(6))
%if x_d(5)~=0
%    text(18.8, 17,num2str(abs(x_d(5))));
%end
HPlotTAU(x(6), x(7), x_d(9)/koef+y(6), x_d(10)/koef+y(7), y(6) ,15, x_d2(6)/koef+y(6), x_d2(7)/koef+y(7))
%if x_d(6)~=0
%    text(16, 3,num2str(abs(x_d(6))), 'HorizontalAlignment', 'right');
%end
%if x_d(7)~=0
%    text(33.2, 4,num2str(abs(x_d(7))));
%end
plot(x(1:4), y(1:4), 'black', 'linewidth', 2)
plot(x(5:7), y(5:7), 'black', 'linewidth', 2)
hold off

axis equal

grid on
xlim([-10, 40])
ylim([-20, 30])

end


function HPlotTAU(x1, x2, y1, y2, yZ, steps, y11, y22)
    if (y1 ~= y2)
        yV = y1:(y2-y1)/steps:y2;
    else
        yV = zeros(steps+1)+y1;
    end
    
    if (x1 ~= x2)
        xV = x1:(x2-x1)/steps:x2;
    else
        xV = zeros(steps+1)+x1;
    end

    plot([xV(2), xV(end-1)], [yV(1), yV(end)], 'black', 'linewidth', 2)
    for i=2:length(yV)-1
        plot([xV(i) xV(i)],[yZ yV(i)], 'black');
    end
    plot([xV(1) xV(2)],[y11 yV(1)],'black', 'linewidth', 2)
    plot([xV(end) xV(end-1)],[y22 yV(end)], 'black', 'linewidth', 2)

    plot([xV(1) xV(1)],[yZ y11],'black', 'linewidth', 2)
    plot([xV(end) xV(end)],[yZ y22], 'black', 'linewidth', 2)
end



function VPlotTAU(x1, x2, y1, y2, xZ, steps, y11, y22)
    if (y1 ~= y2)
        yV = y1:(y2-y1)/steps:y2;
    else
        yV = zeros(steps+1)+y1;
    end
    
    if (x1 ~= x2)
        xV = x1:(x2-x1)/steps:x2;
    else
        xV = zeros(steps+1)+x1;
    end

     plot([xV(1), xV(end)], [yV(2), yV(end-1)], 'black', 'linewidth', 2)
    for i=2:length(yV)-1
        plot([xZ xV(i)],[yV(i) yV(i)], 'black');
    end
    plot([xV(1) y11],[yV(2) yV(1)],'black', 'linewidth', 2)
    plot([xV(end) y22],[yV(end-1) yV(end)], 'black', 'linewidth', 2)

    plot([xZ y11],[yV(1) yV(1)],'black', 'linewidth', 2)
    plot([xZ y22],[yV(end) yV(end)], 'black', 'linewidth', 2)
end



function gr_plot(x, y, x_d, koef)

figure()
hold off
hold on

koef = max(x_d)/5;

VPlot(-x_d(1)/koef, -x_d(2)/koef, y(1), y(2), x(1), 10)
if x_d(1)~=0
    text(0, -1,num2str(abs(x_d(1))));
end
if x_d(2)~=0
    text(-0.3, 20,num2str(abs(x_d(2))), 'HorizontalAlignment', 'right');
end
HPlot(x(2), x(3), x_d(2)/koef+y(2), x_d(3)/koef+y(3), y(2) ,20)
if x_d(3)~=0
    text(33.6, 21,num2str(abs(x_d(3))));
end
VPlot(x_d(3)/koef+x(3), x_d(4)/koef+x(4), y(3), y(4), x(3), 5)
if x_d(4)~=0
    text(33.6, 7.5,num2str(abs(x_d(4))));
end
VPlot(x_d(5)/koef+x(5), x_d(6)/koef+x(6), y(5), y(6), x(5), 8)
if x_d(5)~=0
    text(18.8, 17,num2str(abs(x_d(5))));
end
HPlot(x(6), x(7), x_d(6)/koef+y(6), x_d(7)/koef+y(7), y(6) ,10)
if x_d(6)~=0
    text(16, 3,num2str(abs(x_d(6))), 'HorizontalAlignment', 'right');
end
if x_d(7)~=0
    text(33.2, 4,num2str(abs(x_d(7))));
end
plot(x(1:4), y(1:4), 'black', 'linewidth', 2)
plot(x(5:7), y(5:7), 'black', 'linewidth', 2)
hold off

axis equal

grid on
xlim([-10, 40])
ylim([-20, 30])

end

function VPlot(x1, x2, y1, y2, xZ, steps)
    if (y1 ~= y2)
        yV = y1:(y2-y1)/steps:y2;
    else
        yV = zeros(steps+1)+y1;
    end
    
    if (x1 ~= x2)
        xV = x1:(x2-x1)/steps:x2;
    else
        xV = zeros(steps+1)+x1;
    end

    plot(xV, yV, 'black', 'linewidth', 2)
    for i=2:length(yV)-1
        plot([xZ xV(i)],[yV(i) yV(i)], 'black');
    end
    plot([xV(1) xZ],[yV(1) yV(1)],'black', 'linewidth', 2)
    plot([xV(end) xZ],[yV(end) yV(end)], 'black', 'linewidth', 2)
end

function HPlot(x1, x2, y1, y2, yZ, steps)
    if (y1 ~= y2)
        yV = y1:(y2-y1)/steps:y2;
    else
        yV = zeros(steps+1)+y1;
    end
    
    if (x1 ~= x2)
        xV = x1:(x2-x1)/steps:x2;
    else
        xV = zeros(steps+1)+x1;
    end

    plot(xV, yV, 'black', 'linewidth', 2)
    for i=2:length(yV)-1
        plot([xV(i) xV(i)],[yZ yV(i)], 'black');
    end
    plot([xV(1) xV(1)],[yV(1) yZ],'black', 'linewidth', 2)
    plot([xV(end) xV(end)],[yV(end) yZ], 'black', 'linewidth', 2)
end

function res = S_int(x, y, val1, val2)
    res = 0;
    for i = 1:3
        len = abs(x(i)-x(i+1))+abs(y(i)-y(i+1));
        res = res + 2*(len/6)*(val1(i)*val2(i)+4*((val1(i)+val1(i+1))/2)*((val2(i)+val2(i+1))/2)+val1(i+1)*val2(i+1));
    end
    for i = 5:6
        len = abs(x(i)-x(i+1))+abs(y(i)-y(i+1));
        res = res +   (len/6)*(val1(i)*val2(i)+4*((val1(i)+val1(i+1))/2)*((val2(i)+val2(i+1))/2)+val1(i+1)*val2(i+1));
    end
end

function res = S_intAR(x, y, val)
    res = 0;
    for i = 1:3
        len = abs(x(i)-x(i+1))+abs(y(i)-y(i+1));
        res = res + 2*(val(i)+val(i+1))*len/2;
    end
    for i = 5:6
        len = abs(x(i)-x(i+1))+abs(y(i)-y(i+1));
        res = res + (val(i)+val(i+1))*len/2;
    end
end

function W = W_ep(x_1, y_1, O_x, O_y)
W = [0, 0, 0, 0, 0, 0, 0];
prev = 0;

for i=1:3
    temp_x = [x_1(i), x_1(i+1), O_x];
    temp_y = [y_1(i), y_1(i+1), O_y];
    a = polyarea(temp_x,temp_y)*2;
    if (x_1(i) == x_1(i+1))
        if (O_x < x_1(i))
            gr_k = -1;
        else
            gr_k = 1;
        end
    elseif (y_1(i) == y_1(i+1))
        if (O_y < y_1(i))
            gr_k = -1;
        else
            gr_k = 1;
        end
    end
    if (i == 1)
       W(i) = a*gr_k; 
    else
       W(i+1) = a*gr_k+prev; 
    end
    if (i ~= 1)
        prev = W(i+1);
    end
end

if (O_x < x_1(2))
    gr_k = -1;
else
    gr_k = 1;
end
prev = polyarea([x_1(2), x_1(5), O_x],[y_1(2), y_1(5), O_y])*2*gr_k;
W(5) = prev;


for i=5:6
    temp_x = [x_1(i), x_1(i+1), O_x];
    temp_y = [y_1(i), y_1(i+1), O_y];
    a = polyarea(temp_x,temp_y)*2;
    if (x_1(i) == x_1(i+1))
       if (O_x < x_1(i))
           gr_k = -1;
       else
           gr_k = 1;
       end
   elseif (y_1(i) == y_1(i+1))
       if (O_y < y_1(i))
           gr_k = -1;
       else
           gr_k = 1;
       end
    end
    W(i+1) = a*gr_k+prev;
    prev = W(i+1);
end
end
