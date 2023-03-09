x_1 = [0, 13.5, 4.3, 4.3, 0, 16.3, 16.3]; %%%%
y_1 = [1, 1, 1, 18, 15.5, 15.5, 7]; %%%%
X_C = 7.3584;
Y_C = 9.2240;
alpha = 0.5*atan(-2*459/(3765-2118));
x_d1 = x_1 - X_C;
y_d1 = y_1 - Y_C;
U = x_d1.*cos(alpha)+y_d1.*sin(alpha)
V = -x_d1.*sin(alpha)+y_d1.*cos(alpha)
W1 = [-62.35, 133.4, 0, 0, 0, 0, -102];
W2 = [111.65, 307.4, 174, -18, 0, 0, 0];
width = [0, 0, 0, 0, 0, 0, 0];

S_uw = S_int(x_1, y_1, width, W2, V)
S_vw = S_int(x_1, y_1, width, W2, U)

O1_x = 4.3;
O1_y = 15.5;

O2_x = 16.3;
O2_y = 15.5;
Ju = 3884;
Jv = 1999;

A_u = S_uw/Ju
A_v = -S_vw/Jv
A_x = A_u*cos(alpha)-A_v*sin(alpha)+O2_x
A_y = A_u*sin(alpha)+A_v*cos(alpha)+O2_y

function res = S_int(x, y, width, val1, val2)
    res = 0;
    for i = 1:1
        len = abs(x(i)-x(i+1))+abs(y(i)-y(i+1))
        res = res + 2*(len/6)*(val1(i)*val2(i)+4*((val1(i)+val1(i+1))/2)*((val2(i)+val2(i+1))/2)+val1(i+1)*val2(i+1));
        2*(len/6)*(val1(i)*val2(i)+4*((val1(i)+val1(i+1))/2)*((val2(i)+val2(i+1))/2)+val1(i+1)*val2(i+1))
    end
    for i = 3:3
        len = abs(x(i)-x(i+1))+abs(y(i)-y(i+1))
        res = res + 2*(len/6)*(val1(i)*val2(i)+4*((val1(i)+val1(i+1))/2)*((val2(i)+val2(i+1))/2)+val1(i+1)*val2(i+1));
        2*(len/6)*(val1(i)*val2(i)+4*((val1(i)+val1(i+1))/2)*((val2(i)+val2(i+1))/2)+val1(i+1)*val2(i+1))
    end
    for i = 5:5
        len = abs(x(i)-x(i+1))+abs(y(i)-y(i+1))
        res = res + 2*(len/6)*(val1(i)*val2(i)+4*((val1(i)+val1(i+1))/2)*((val2(i)+val2(i+1))/2)+val1(i+1)*val2(i+1));
        2*(len/6)*(val1(i)*val2(i)+4*((val1(i)+val1(i+1))/2)*((val2(i)+val2(i+1))/2)+val1(i+1)*val2(i+1))
    end
    for i = 6:6
        len = abs(x(i)-x(i+1))+abs(y(i)-y(i+1))
        res = res + (len/6)*(val1(i)*val2(i)+4*((val1(i)+val1(i+1))/2)*((val2(i)+val2(i+1))/2)+val1(i+1)*val2(i+1));
        (len/6)*(val1(i)*val2(i)+4*((val1(i)+val1(i+1))/2)*((val2(i)+val2(i+1))/2)+val1(i+1)*val2(i+1))
    end
end