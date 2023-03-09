close all
%A_x = 6.33;
%A_y = 21.74;
Ju = 5561.66;
Jv = 24595.94;
global HV
HV = 100;
x_1 = [0, 0, 16.3, 32.6, 32.6, 16.3, 16.3];
%x_1 = [0, 0, 31.6, 31.6, 16.3, 16.3, 32.6]; %%%%
y_1 = [0, 18.3, 18.3, 18.3, 4.1, 4.1, 18.3];
   
hold on
plot(x_1, y_1)
plot(13.7247, 19.8862, 'd', 'color', 'black')
plot(13.8786, 20.1843, 'd', 'color', 'black')
width = [2, 2, 2, 2, 1, 1, 1];
hold off
%x_2 = [16.3, 16.3, 32.6];
%y_2 = [18.3, 4.1, 4.1];

X_C = 16.8;
Y_C = 12.87;
%%{
hold on
alpha = 0.014386;

%plot(polyshape([1 -1 -1 1],[0 0 19.3 19.3]), 'FaceAlpha', 0)
%plot(polyshape([1 33.6 33.6 1],[17.3 17.3 19.3 19.3]), 'FaceAlpha', 0)
%plot(polyshape([33.6 31.6 31.6 33.6],[17.3 17.3 4.1-0.5 4.1-0.5]), 'FaceAlpha', 0)
%plot(polyshape([15.8 16.8 16.8 15.8],[17.3 17.3 19.3-15.7 19.3-15.7]), 'FaceAlpha', 0)
%plot(polyshape([16.8 31.6 31.6 16.8],[19.3-15.7 19.3-15.7 19.3-14.7 19.3-14.7]), 'FaceAlpha', 0)
%plot(x_1, y_1, 'color','#888888')
%plot(0, 0, 'd','color','black')
%plot(X_C, Y_C, 'd','color','black')

%{

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

alpha = 0.014386;

%alpha = 0.0707; %%%

u = x_d1.*cos(alpha)+y_d1.*sin(alpha);
v = -x_d1.*sin(alpha)+y_d1.*cos(alpha);

u
v

%gr_plot(x_1, y_1, u, 3) %plot U
%gr_plot(x_1, y_1, v, 3) %plot V



%O_x = 6.33;
%O_y = 18.3+3.44;
%{%%%%%%%%%%%%%%%%%%%%%%%%%%%
O_x = 0;
O_y = 18.3;
W1 = W_ep(x_1, y_1, O_x, O_y, 7)
gr_plot(x_1, y_1, W1, 100)
S = 231.46*2;
P = 61;
W1_S = starify(x_1, y_1, W1, S, P)
gr_plot(x_1, y_1, W1_S, 50)
%%%W1 = W_ep(x_1, y_1, O_x, O_y, 6)
%%%%gr_plot(x_1, y_1, W1, 100)
%W_ep(x_1, y_1, 6)
%W
%u
%%gr_plot(x_1, y_1, W1, 60) %W1

S_uw = S_int(x_1, y_1, W1_S, v)
S_vw = S_int(x_1, y_1, W1_S, u)

A_u = S_uw/Ju
A_v = -S_vw/Jv
A_x = A_u*cos(alpha)-A_v*sin(alpha)+O_x
A_y = A_u*sin(alpha)+A_v*cos(alpha)+O_y



WA = W_ep(x_1, y_1, A_x, A_y, 7)
gr_plot(x_1, y_1, WA, 100)
WA_S = starify(x_1, y_1, WA, S, P)
gr_plot(x_1, y_1, WA_S, 35)

S_intAR(x_1, y_1, WA_S)
C1 = -S_intAR(x_1, y_1, WA_S)/159.7
W = WA_S+C1
gr_plot(x_1, y_1, W, 35)

%S_intAR(x_1, y_1, W)
AAAAAAA=S_int(x_1, y_1, W, W)


Jw = 10.471*10^5*10^-12;

%Bw = -47.9744;
%Bw = -14.6787;
Bw = 62.5115;

SIGW = (Bw/Jw).*W.*10^-4.*10^-6;
gr_plot(x_1, y_1, SIGW, 0.12)


Wk1 = 2.4*10^-5;
Wk2 = 4.3*10^-5;
Wk3 = 1.15*10^-5;
Wk4 = 4.52*10^-6;
Wk5 = 5.21*10^-6;

Wk = Wk1+Wk2+Wk3+Wk4+Wk5;
Jk = 3597.16*10^-8;
Jk1 = 0.311*19.3*2^3*10^-8;
Jk2 = 0.305*14.8*2^3*10^-8;
%Mk = 0; 
%Mk = -7.36161;
Mk = -59.2184;

tau(1) = Mk/(Jk*Wk)*Jk1;
tau(2) = Mk/(Jk*Wk)*Jk1;
tau(3) = Mk/(Jk*Wk)*Jk2;
tau(4) = Mk/(Jk*Wk)*Jk2;
tau(5) = Mk/(S*10^-4*2*10^-3);
tau(6) = Mk/(S*10^-4*2*10^-3);
tau(7) = Mk/(S*10^-4*2*10^-3);
tau(8) = Mk/(S*10^-4*2*10^-3);
tau(9) = Mk/(S*10^-4*1*10^-3);
tau(10) = Mk/(S*10^-4*1*10^-3);
tau(11) = Mk/(S*10^-4*1*10^-3);
tau(12) = Mk/(S*10^-4*1*10^-3);
tau=tau*10^-6


gr_plotTAU(x_1, y_1, tau, 0.2)

%{
Mu = 0.172*10^3;
Mv = 0.148*10^3;

F = 150.7*10^-4;
P = 1.6*10^3;

Ju = 5041.03*10^-8;
Jv = 22135.97*10^-8;
u
v
Jw = AAAAAAA*10^-12;
Bw = -10.12;
SIGU = -(Mu/Ju).*v.*10^-2.*10^-6;
SIGV = -(Mv/Jv).*u.*10^-2.*10^-6;
SIGW =  (Bw/Jw).*W.*10^-4.*10^-6;
SIGZ = ((3/4)*P-(5/8)*P)/F*10^-6+u.*0;
%gr_plot(x_1, y_1, SIGU, 0.09)
%gr_plot(x_1, y_1, SIGV, 0.033)
%gr_plot(x_1, y_1, SIGW, 0.05)
%gr_plot(x_1, y_1, SIGZ, 1/250)
%gr_plot(x_1, y_1, SIGU+SIGV+SIGW+SIGZ, 0.08)
%}%%%%%%%%%%%%%%%%%%%%%%%%%%


%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





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







function W = starify(x, y, W1, S, P)
W = W1;
L = 0;
for i = 7:-1:4
    L = L+abs(x(i)-x(i-1))+abs(y(i)-y(i-1));
    W(i-1) = W1(i-1)-S*L/P;
end
for i=3:-1:2
    W(i-1) = W1(i-1)-S*L/P;
end
end


function gr_plot(x, y, x_d, koef)

figure()
hold off
hold on


VPlot(-x_d(1)/koef, -x_d(2)/koef, y(1), y(2), x(1), 10)
if x_d(1)~=0
    text(0, -1,num2str(abs(x_d(1))));
end
if x_d(2)~=0
    text(-0.3, 20,num2str(abs(x_d(2))), 'HorizontalAlignment', 'right');
end
HPlot(x(2), x(3), x_d(2)/koef+y(2), x_d(3)/koef+y(3), y(2) ,10)
%if x_d(3)~=0
%    text(33.6, 21,num2str(abs(x_d(3))));
%end
HPlot(x(3), x(4), x_d(3)/koef+y(3), x_d(4)/koef+y(4), y(4) ,10)
if x_d(4)~=0
    text(33.6, 21,num2str(abs(x_d(4))));
end
VPlot(x_d(4)/koef+x(4), x_d(5)/koef+x(5), y(4), y(5), x(4), 5)
if x_d(5)~=0
    text(33.6, 3.1,num2str(abs(x_d(5))));
end
HPlot(x(5), x(6), -x_d(5)/koef+y(5), -x_d(6)/koef+y(6), y(5) ,10)
VPlot(-x_d(6)/koef+x(6), -x_d(7)/koef+x(7), y(6), y(7), x(6), 8)
if x_d(7)~=0
    text(18.8, 17,num2str(abs(x_d(7))));
end
if x_d(6)~=0
    text(16, 3,num2str(abs(x_d(6))), 'HorizontalAlignment', 'right');
end

plot(x, y, 'black', 'linewidth', 2)
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
    if (xV(1) ~= 16.3)
        plot([xV(1) xV(1)],[yV(1) yZ],'black', 'linewidth', 2)
    end
    if (xV(end) ~= 16.3)
        plot([xV(end) xV(end)],[yV(end) yZ], 'black', 'linewidth', 2)
    else
        plot([xV(end) xV(end)],[yV(end) yZ], 'black')
    end
end

function res = S_int(x, y, val1, val2)
    res = 0;
    for i = 1:4
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
    for i = 1:4
        len = abs(x(i)-x(i+1))+abs(y(i)-y(i+1));
        res = res + 2*(val(i)+val(i+1))*len/2;
    end
    for i = 5:6
        len = abs(x(i)-x(i+1))+abs(y(i)-y(i+1));
        res = res + (val(i)+val(i+1))*len/2;
    end
end



function W = W_ep(x_1, y_1, O_x, O_y, ind)
W = zeros(1,length(x_1))
prev = 0;


for i=ind:1:length(x_1)-1
    ZN = 1;
    temp_x = [x_1(i), x_1(i+ZN), O_x];
    temp_y = [y_1(i), y_1(i+ZN), O_y];
    a = abs(polyarea(temp_x,temp_y))*2;
    if (y_1(i) == y_1(i+ZN))
        if (x_1(i)<x_1(i+ZN))
            gr_k = 1;
        else
            gr_k = -1;
        end
        if (O_y < y_1(i))
            gr_k = -gr_k;
        end
    elseif (x_1(i) == x_1(i+ZN))
        if (y_1(i)<y_1(i+ZN))
            gr_k = 1;
        else
            gr_k = -1;
        end
        if (O_x > y_1(i))
            gr_k = -gr_k;
        end
    end

    W(i+ZN) = a*gr_k+prev;
    prev = W(i+ZN);
end

prev = 0;

for i=ind:-1:2
        ZN = -1;
    temp_x = [x_1(i), x_1(i+ZN), O_x];
    temp_y = [y_1(i), y_1(i+ZN), O_y];
    a = abs(polyarea(temp_x,temp_y))*2;
    if (y_1(i) == y_1(i+ZN))
        if (x_1(i)<x_1(i+ZN))
            gr_k = 1;
        else
            gr_k = -1;
        end
        if (O_y < y_1(i))
            gr_k = -gr_k;
        end
    elseif (x_1(i) == x_1(i+ZN))
        if (y_1(i)<y_1(i+ZN))
            gr_k = 1;
        else
            gr_k = -1;
        end
        if (O_x > x_1(i))
            gr_k = -gr_k;
        end
    end

    W(i+ZN) = a*gr_k+prev;
    prev = W(i+ZN);
end
end

%{
for i=6:-1:2
    temp_x = [x_1(i), x_1(i-1), O_x];
    temp_y = [y_1(i), y_1(i-1), O_y];
    a = abs(polyarea(temp_x,temp_y))*2;
    if (x_1(i) == x_1(i-1))
        if (O_x < x_1(i))
            gr_k = -1;
        else
            gr_k = 1;
        end
    elseif (y_1(i) == y_1(i-1))
        if (O_y < y_1(i))
            gr_k = -1;
        else
            gr_k = 1;
        end
    end       
    W(i-1) = a*gr_k+prev; 
    if (i ~= 6)
        prev = W(i-1);
    end
end
%}


%{
function W = W_ep(x_1, y_1, O_x, O_y)
W = [0, 0, 0, 0, 0, 0];
prev = 0;

for i=6:-1:2
    temp_x = [x_1(i), x_1(i-1), O_x];
    temp_y = [y_1(i), y_1(i-1), O_y];
    a = abs(polyarea(temp_x,temp_y))*2;
    if (x_1(i) == x_1(i-1))
        if (O_x < x_1(i))
            gr_k = -1;
        else
            gr_k = 1;
        end
    elseif (y_1(i) == y_1(i-1))
        if (O_y < y_1(i))
            gr_k = -1;
        else
            gr_k = 1;
        end
    end       
    W(i-1) = a*gr_k+prev; 
    if (i ~= 6)
        prev = W(i-1);
    end
end
%}
%{
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
%}
%end

function gr_plotTAU(x, y, x_d, koef)

figure()
hold off
hold on


VPlotTAU(-x_d(1)/koef, -x_d(2)/koef, y(1), y(2), x(1), 10)
%if x_d(1)~=0
%    text(0, -1,num2str(abs(x_d(1))));
%end
%if x_d(2)~=0
%    text(-0.3, 20,num2str(abs(x_d(2))), 'HorizontalAlignment', 'right');
%end
HPlotTAU(x(2), x(3), x_d(3)/koef+y(2), x_d(4)/koef+y(3), y(2) ,10)
%if x_d(3)~=0
%    text(33.6, 21,num2str(abs(x_d(3))));
%end
HPlotTAU(x(3), x(4), x_d(5)/koef+y(3), x_d(6)/koef+y(4), y(4) ,10)
%if x_d(4)~=0
%    text(33.6, 21,num2str(abs(x_d(4))));
%end
VPlotTAU(x_d(7)/koef+x(4), x_d(8)/koef+x(5), y(4), y(5), x(4), 5)
%if x_d(5)~=0
%    text(33.6, 3.1,num2str(abs(x_d(5))));
%end
HPlotTAU(x(5), x(6), -x_d(9)/koef+y(5), -x_d(10)/koef+y(6), y(5) ,10)
VPlotTAU(-x_d(11)/koef+x(6), -x_d(12)/koef+x(7), y(6), y(7), x(6), 8)
%if x_d(7)~=0
%    text(18.8, 17,num2str(abs(x_d(7))));
%end
%if x_d(6)~=0
%    text(16, 3,num2str(abs(x_d(6))), 'HorizontalAlignment', 'right');
%end

plot(x, y, 'black', 'linewidth', 2)
hold off

axis equal

grid on
xlim([-10, 40])
ylim([-20, 30])

end

function HPlotTAU(x1, x2, y1, y2, yZ, steps)
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
    plot([xV(1) xV(2)],[yZ yV(1)],'black', 'linewidth', 2)
    plot([xV(end) xV(end-1)],[yZ yV(end)], 'black', 'linewidth', 2)

    plot([xV(1) xV(1)],[yZ yV(1)],'black', 'linewidth', 2)
    plot([xV(end) xV(end)],[yZ yV(end)], 'black', 'linewidth', 2)
end



function VPlotTAU(x1, x2, y1, y2, xZ, steps)
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
    plot([xV(1) xZ],[yV(2) yV(1)],'black', 'linewidth', 2)
    plot([xV(end) xZ],[yV(end-1) yV(end)], 'black', 'linewidth', 2)

    plot([xZ xZ],[yV(1) yV(1)],'black', 'linewidth', 2)
    plot([xZ xZ],[yV(end) yV(end)], 'black', 'linewidth', 2)
end
