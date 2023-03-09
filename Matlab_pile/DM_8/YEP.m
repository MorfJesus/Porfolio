function F = YEP(C)
syms x
B = 18.8496;
gamma = 10;
phi1 = C(1)*sin(B*x)+C(2)*cos(B*x)+C(3)*sinh(B*x)+C(4)*cosh(B*x);
phi2 = C(5)*sin(B*x)+C(6)*cos(B*x)+C(7)*sinh(B*x)+C(8)*cosh(B*x);
    F(1)=double(subs(phi1, x, 0));
    F(2)=double(subs(diff(phi1, x, 2), x, 0));
    F(3)=double(subs(phi1, x, 0.5)-subs(phi2, x, 0.5));
    F(4)=double(subs(diff(phi1, x, 1), x, 0.5)-subs(diff(phi2, x, 1), x, 0.5));
    F(5)=double(subs(diff(phi1, x, 2), x, 0.5)-subs(diff(phi2, x, 2), x, 0.5));
    F(6)=double(subs(diff(phi1, x, 3), x, 0.5)-gamma*subs(phi1, x, 0.5)-subs(diff(phi2, x, 3), x, 0.5));
    F(7)=double(subs(phi2, x, 1));
    F(8)=double(subs(diff(phi2, x, 2), x, 1));
end