close all
F = 91.2*10^-4;
P = 1.9*10^3;

Ju = 2388.92*10^-8;
Jv = 4320.05*10^-8;

u = [6.24, -8.43, -10.99, 5.63, 8.2, 13.38];
v = [-5.92, -9.05, 2.98, 6.53, -5.5, -4.4];

x_1 = [15, 0, 0, 17, 17, 22.3];
y_1 = [0, 0, 12.8, 12.8, 0, 0];

%plot(x_1, y_1)
%grid on

W = [244.32, -30.93, -43.23, 59.62, -137.18, -39.93];

Jw = 489511.03146*10^-12;

%Bw = 500.428;
Bw = 20.4191;

%Mu = -2.3*10^3;
Mu = -1.09*10^3;

%Mv = -7.08*10^3;
Mv = -1.7*10^3;


SIGU = -(Mu/Ju).*v.*10^-2.*10^-6
SIGV = -(Mv/Jv).*u.*10^-2.*10^-6
SIGW =  (Bw/Jw).*W.*10^-4.*10^-6
SIGZ = P/F*10^-6+u.*0
SIGU+SIGV+SIGW+SIGZ
gr_plot(x_1, y_1, SIGU, 2.6)
gr_plot(x_1, y_1, SIGV, 7.4)
gr_plot(x_1, y_1, SIGW, 1)
gr_plot(x_1, y_1, SIGZ, 1/7.5)
gr_plot(x_1, y_1, SIGU+SIGV+SIGW+SIGZ, 2)
Wk1 = 4.3732*10^-5;
Wk2 = 4.5954*10^-6;
Wk3 = 9.9944*10^-5;
Wk4 = 1.54112*10^-5;
Wk5 = 8.25552*10^-6;

%Mk = -149.189;
Mk = -276.455;

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
gr_plotTAU(x_1, y_1, tau, 12.5, ZZ)

SIGSUM(1) = sqrt((SIGU(1)+SIGV(1)+SIGW(1)+SIGZ(1)).^2+4*tau(1).^2);
SIGSUM(2) = sqrt((SIGU(2)+SIGV(2)+SIGW(2)+SIGZ(2)).^2+4*tau(2).^2);
SIGSUM(3) = sqrt((SIGU(2)+SIGV(2)+SIGW(2)+SIGZ(2)).^2+4*tau(3).^2);
SIGSUM(4) = sqrt((SIGU(3)+SIGV(3)+SIGW(3)+SIGZ(3)).^2+4*tau(4).^2);
SIGSUM(5) = sqrt((SIGU(3)+SIGV(3)+SIGW(3)+SIGZ(3)).^2+4*tau(5).^2);
SIGSUM(6) = sqrt((SIGU(4)+SIGV(4)+SIGW(4)+SIGZ(4)).^2+4*tau(6).^2);
SIGSUM(7) = sqrt((SIGU(4)+SIGV(4)+SIGW(4)+SIGZ(4)).^2+4*tau(7).^2);
SIGSUM(8) = sqrt((SIGU(5)+SIGV(5)+SIGW(5)+SIGZ(5)).^2+4*tau(8).^2);
SIGSUM(9) = sqrt((SIGU(5)+SIGV(5)+SIGW(5)+SIGZ(5)).^2+4*tau(9).^2);
SIGSUM(10) = sqrt((SIGU(6)+SIGV(6)+SIGW(6)+SIGZ(6)).^2+4*tau(10).^2);

%SIGU+SIGV+SIGW+SIGZ
SIGSUM
gr_plotTAU(x_1, y_1, SIGSUM, 20, sqrt((SIGU+SIGV+SIGW+SIGZ).^2))

function gr_plotTAU(x, y, x_d, koef, x_d2)

figure()
hold off
hold on

%koef = max(abs(x_d))/4;

HPlot(x(1), x(2), x_d(1)/koef+y(1), x_d(2)/koef+y(2), y(1) ,18)

VPlot(x_d(3)/koef, x_d(4)/koef, y(2), y(3), x(2), 15)

HPlot(x(3), x(4), -x_d(5)/koef+y(3), -x_d(5)/koef+y(4), y(3) ,20)

VPlot(-x_d(7)/koef+x(4), -x_d(8)/koef+x(5), y(3), y(5), x(4), 15)

HPlot(x(5), x(6), -x_d(9)/koef+y(5), -x_d(10)/koef+y(6), y(5) ,5)
plot(x, y, 'black', 'linewidth', 2)
hold off

axis equal

grid on
xlim([-5, 25])
ylim([-10, 20])

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

%koef = max(x_d)/5;

HPlot(x(1), x(2), x_d(1)/koef+y(1), x_d(2)/koef+y(2), y(1) ,18)

VPlot(x_d(2)/koef, x_d(3)/koef, y(2), y(3), x(2), 15)

HPlot(x(3), x(4), -x_d(3)/koef+y(3), -x_d(4)/koef+y(4), y(3) ,20)

VPlot(-x_d(4)/koef+x(4), -x_d(5)/koef+x(5), y(3), y(5), x(4), 15)

HPlot(x(5), x(6), -x_d(5)/koef+y(5), -x_d(6)/koef+y(6), y(5) ,5)

plot(x, y, 'black', 'linewidth', 2)
hold off

axis equal

grid on
xlim([-5, 25])
ylim([-10, 20])

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