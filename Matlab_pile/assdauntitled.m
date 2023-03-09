syms v11 v12 v21 v22 omega
eqn = (C(1, 1)-omega^2*A(1, 1))*(C(2, 2)-omega^2*A(2, 2))-(C(1, 2)-omega^2*A(1, 2))^2;
C = [3000 -2000; -2000 5000];
A = [10 0; 0 20];
s = solve(eqn, omega)
omega1 = double(s(1))
omega2 = double(s(2))
eqns = [(C(1, 1)-omega1^2*A(1, 1))*v11 + (C(1, 2)-omega1^2*A(1, 2)) == 0, (C(2, 1)-omega1^2*A(2, 1)) + (C(2, 2)-omega1^2*A(2, 2))*v12 == 0]
s = solve(eqns, [v11, v12])
V1 = double(s.v11)
V2 = double(s.v12)
eqns = [(C(1, 1)-omega2^2*A(1, 1))*v11 + (C(1, 2)-omega2^2*A(1, 2)) == 0, (C(2, 1)-omega2^2*A(2, 1)) + (C(2, 2)-omega2^2*A(2, 2))*v12 == 0]
s = solve(eqns, [v11, v12])
V3 = double(s.v11)
V4 = double(s.v12)
