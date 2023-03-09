x = [17, 0, 0, 17, 17, 22.3];
y = [0, 0, 12.3, 12.3, 0, 0];
width = [1, 1, 1, 2, 2, 1];

x_1 = [0, 0, 32.6, 32.6, 16.3, 16.3];
y_1 = [0, 18.3, 18.3, 8.6, 18.3, 4.1];

val1 = [1, 2, 3, 4, 5, 6, 7];
val2 = [1, 2, 3, 4, 5, 6, 7];
%width = [2, 2, 2, 2, 1, 1];

%[1.6970e+03, S_int(x_1, y_1, width, val1, val2)]
W1 = [0, 121.32, 0, -87.78, 0, 0];
W2 = [0, -87.78, -209.1, -87.78, 0, 65.19];
U = [8.24, -8.3, -11.14, 5.41, 8.24, 13.4];
V = [-5.25, -9.17, 2.8, 6.72, -5.25, -4.03];

S_uw=S_int(x, y, width, W2, V)
S_vw=S_int(x, y, width, W2, U)

alpha=deg2rad(-13.337);
O1_x = 17.5;
O1_y = 0.5;

O2_x = 17.5;
O2_y = 12.8;

Ju = 2421.42;
Jv = 4365.91;

A_u = S_uw/Ju
A_v = -S_vw/Jv
A_x = A_u*cos(alpha)-A_v*sin(alpha)+O2_x
A_y = A_u*sin(alpha)+A_v*cos(alpha)+O2_y

function res = S_int(x, y, width, val1, val2)
    res = 0;
    for i = 1:length(x)-1
        len = abs(x(i)-x(i+1))+abs(y(i)-y(i+1));
        %width(i+1)*(len/6)*(val1(i)*val2(i)+4*((val1(i)+val1(i+1))/2)*((val2(i)+val2(i+1))/2)+val1(i+1)*val2(i+1))
        res = res + width(i+1)*(len/6)*(val1(i)*val2(i)+4*((val1(i)+val1(i+1))/2)*((val2(i)+val2(i+1))/2)+val1(i+1)*val2(i+1));
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