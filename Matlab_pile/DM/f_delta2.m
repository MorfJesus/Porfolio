function y=f_delta2(beta, k1 ,k2)
[a, b]=f_fg2(beta, k1, k2);
y=det(a(1)*b(3)-a(3)*b(1));
end