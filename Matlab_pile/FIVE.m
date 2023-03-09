syms tau omega

Kq = 2*exp(-abs(tau))*(1+abs(tau));
Sq = 8/(2*pi)*(1/(omega^4+2*omega^2+1));
Su = 8/(2*pi)*(1/(omega^2+1)^3);
Ku = exp(-abs(tau))*(2*abs(tau)+3)/2;

F_tau = -5:0.1:5;
F_om = -5:0.1:5;

MyPlot(F_tau, Kq, tau, "\tau", "K_q")
MyPlot(F_tau, Ku, tau, "\tau", "K_u")
MyPlot(F_tau, Sq, omega, "\omega", "S_q")
MyPlot(F_tau, Su, omega, "\omega", "S_u")

function MyPlot(F_tau, Kq, tau, xlab, ylab)
    figure()
    plot(F_tau, subs(Kq, tau, F_tau), 'LineWidth', 2)
    grid on
    xlabel(xlab)
    ylabel(ylab)
end
