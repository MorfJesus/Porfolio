function [Uh] = uh(ksi,m)

global G Jk k

Uh=[m*(1-cosh(ksi)+((ksi)^2)/2)/(G*Jk*k^2)

m*(-sinh(ksi)+ksi)/(G*Jk*k^2)

-m*(-cosh(ksi)+1)/k^2

m*sinh(ksi)/k];

end