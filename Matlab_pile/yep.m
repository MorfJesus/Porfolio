t = (0:0.01:50)
q1 = 0.0179*sin(3.37*t)-3.671*10^(-3)*sin(2.85*t);
qDOT1 = diff(q1)./diff(t);
qDOT1(end+1) = qDOT1(end)
qDOT1 = qDOT1 / 3 * 4 * 1.5
plot(t, qDOT1);

grid on