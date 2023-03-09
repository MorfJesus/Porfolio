close all

figure(1)
S(1) = polyshape([0 19.8 19.8 0],[0 0 2 2]);
S(2)=  polyshape([0 1 1 0],[2 2 16.5 16.5]);
S(3) = polyshape([1 19.8 19.8 1],[15.5 15.5 16.5 16.5]);
S(4) = polyshape([19.8 21.8 21.8 19.8],[16.5 16.5 1.5 1.5]);
S(5) = polyshape([19.8 28.8 28.8 19.8],[0.5 0.5 1.5 1.5]);



A=area(S(1))+area(S(2))+area(S(3))+area(S(4))+area(S(5))

[Cx(1), Cy(1)] = centroid(S(1))
[Cx(2), Cy(2)] = centroid(S(2))
[Cx(3), Cy(3)] = centroid(S(3))
[Cx(4), Cy(4)] = centroid(S(4))
[Cx(5), Cy(5)] = centroid(S(5))



plot(S) 
grid on


Xc = (Cx(1)*area(S(1))+Cx(2)*area(S(2))+Cx(3)*area(S(3))+Cx(4)*area(S(4))+Cx(5)*area(S(5)))/A
Yc = (Cy(1)*area(S(1))+Cy(2)*area(S(2))+Cy(3)*area(S(3))+Cy(4)*area(S(4))+Cy(5)*area(S(5)))/A

Jx = 0;
Jy = 0;
Jxy = 0;

for i = 1:5
    b = max(S(i).Vertices(:,1))-min(S(i).Vertices(:,1));
    h = max(S(i).Vertices(:,2))-min(S(i).Vertices(:,2));
    Jx = Jx + (b*h^3)/12+area(S(i))*(Yc-Cy(i))^2;
    Jy = Jy + (h*b^3)/12+area(S(i))*(Xc-Cx(i))^2;
    Jxy = Jxy + (Yc-Cy(i))*(Xc-Cx(i))*area(S(i));
end

Jx
Jy
Jxy

alpha = 0.5*atan(-2*Jxy/(Jx-Jy));