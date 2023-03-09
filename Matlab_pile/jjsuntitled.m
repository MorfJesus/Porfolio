clear
om = (0:0.1:10);
alpha = 0*om;
beta = -1./(om.^2+3);
plot(alpha, beta, "b")
xlim([-1, 1])
ylim([-0.4, 0])
grid on
hold on
rang = (-2:0.1:2);
line1 = (rang-1)/4;
plot(rang, line1, 'b');
line2 = rang*0 - 1/3;
plot(rang, line2, "b")