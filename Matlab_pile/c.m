function [C] = c(ksi)

global G Jk Jw k E

C=[ 1 sinh(ksi) -(cosh(ksi)-1)./(k^2*E*Jw) -(sinh(ksi)-ksi)./(k*G*Jk)

0 cosh(ksi) -(sinh(ksi))./(k^2*E*Jw) (-cosh(ksi)+1)./(k*G*Jk)

0 -G*Jk*sinh(ksi) cosh(ksi) sinh(ksi)./k

0 -G*Jk*k*cosh(ksi) k*sinh(ksi) cosh(ksi)];

end
