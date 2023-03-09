syms tau omega

Ku = 2*exp(-abs(tau))*(1+abs(tau));
Kv = exp(-abs(tau))*(2*abs(tau)+3)/2;
Sq = 8/(2*pi)*(1/(omega^4+2*omega^2+1));
Su = 8/(2*pi)*(1/(omega^2+1)^3);


F_tau = -5:0.1:5;
F_om = -5:0.1:5;

MyPlot(F_tau, Ku, tau, "\tau", "K_u")
MyPlot(F_tau, Kv, tau, "\tau", "K_v")
MyPlot(F_tau, Su, omega, "\omega", "S_u")
MyPlot(F_tau, Sv, omega, "\omega", "S_v")

function MyPlot(F_tau, Kq, tau, xlab, ylab)
    figure()
    plot(F_tau, subs(Kq, tau, F_tau), 'LineWidth', 2)
    grid on
    xlabel(xlab)
    ylabel(ylab)
end
