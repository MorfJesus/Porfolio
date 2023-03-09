close all

figure(1)
S(1) = polyshape([0 16.5 16.5 0],[0 0 1 1]);
S(2)=  polyshape([0 1 1 0],[1 1 13.8 13.8]);
S(3) = polyshape([1 16.5 16.5 1],[11.8 11.8 13.8 13.8]);
S(4) = polyshape([16.5 18.5 18.5 16.5],[13.8 13.8 1 1]);
S(5) = polyshape([16.5 22.8 22.8 16.5],[0 0 1 1]);



A=area(S(1))+area(S(2))+area(S(3))+area(S(4))+area(S(5))

[Cx(1), Cy(1)] = centroid(S(1))
[Cx(2), Cy(2)] = centroid(S(2))
[Cx(3), Cy(3)] = centroid(S(3))
[Cx(4), Cy(4)] = centroid(S(4))
[Cx(5), Cy(5)] = centroid(S(5))



plot(S) 
grid on


Xc = (Cx(1)*area(S(1))+Cx(2)*area(S(2))+Cx(3)*area(S(3))+Cx(4)*area(S(4))+Cx(5)*area(S(5)))/A
Yc = (Cy(1)*area(S(1))+Cy(2)*area(S(2))+Cy(3)*area(S(3))+Cy(4)*area(S(4))+Cy(5)*area(S(5)))/A

Jx = 0;
Jy = 0;
Jxy = 0;

for i = 1:5
    b = max(S(i).Vertices(:,1))-min(S(i).Vertices(:,1));
    h = max(S(i).Vertices(:,2))-min(S(i).Vertices(:,2));
    Jx = Jx + (b*h^3)/12+area(S(i))*(Yc-Cy(i))^2;
    Jy = Jy + (h*b^3)/12+area(S(i))*(Xc-Cx(i))^2;
    Jxy = Jxy + (Yc-Cy(i))*(Xc-Cx(i))*area(S(i));
end

Jx
Jy
Jxy

alpha = 0.5*atan(-2*Jxy/(Jx-Jy))
rad2deg(alpha)

Ju = (Jx+Jy)/2-sqrt(((Jx-Jy)/2)^2+Jxy^2)
Jv = (Jx+Jy)/2+sqrt(((Jx-Jy)/2)^2+Jxy^2)

x = [17.5 0.5 0.5 17.5 17.5 22.8]
y = [0.5 0.5 12.8 12.8 0.5 0.5]

x_d = x -Xc;
y_d = y -Yc;

U = x_d*cos(alpha)+y_d*sin(alpha)
V = -x_d*sin(alpha)+y_d*cos(alpha)
hold on
plot(x, y)
hold off

O1_x = 0.5;
O1_y = 12.8;

O2_x = 17.5;
O2_y = 12.8;

width = [1, 1, 1, 2, 2, 1];

%a = polyarea();
s = [17+17+12.3+12.3, 12.3+17+12.3, 17+12.3, 12.3, 0, 17+17+12.3+12.3]
%W1=W_ep(x, y, O1_x, O1_y)
W_ep(x, y, O1_x, O1_y)
W1=Wstar(W_ep(x, y, O1_x, O1_y), s)

%W2=W_ep(x, y, O2_x, O2_y)
W2=Wstar(W_ep(x, y, O2_x, O2_y), s)

S_uw=S_int(x, y, width, W1, V)
S_vw=S_int(x, y, width, W1, U)

A_u = S_uw/Ju
A_v = -S_vw/Jv
A_x = A_u*cos(alpha)-A_v*sin(alpha)+O1_x
A_y = A_u*sin(alpha)+A_v*cos(alpha)+O1_y

function res = S_int(x, y, width, val1, val2)
    res = 0;
    for i = 1:length(x)-1
        len = abs(x(i)-x(i+1))+abs(y(i)-y(i+1));
        %width(i+1)*(len/6)*(val1(i)*val2(i)+4*((val1(i)+val1(i+1))/2)*((val2(i)+val2(i+1))/2)+val1(i+1)*val2(i+1))
        res = res + width(i+1)*(len/6)*(val1(i)*val2(i)+4*((val1(i)+val1(i+1))/2)*((val2(i)+val2(i+1))/2)+val1(i+1)*val2(i+1));
    end
end

function W = W_ep(x, y, O_x, O_y)
    W = zeros(1, 6);
    W(5) = 0;
    W(4) = 2*polyarea([O_x, x(5), x(4)], [O_y, y(5), y(4)]);
    W(3) = W(4)+2*polyarea([O_x, x(4), x(3)], [O_y, y(4), y(3)]);
    W(2) = W(3)+2*polyarea([O_x, x(3), x(2)], [O_y, y(3), y(2)]);
    W(1) = W(2)+2*polyarea([O_x, x(2), x(1)], [O_y, y(2), y(1)]);
    W(6) = W(1)+2*polyarea([O_x, x(6), x(1)], [O_y, y(6), y(1)]);
end

function Ws=Wstar(W, s)
    omega = 418.2;
    S = 58.6;
    Ws = W-omega*s/S;
end