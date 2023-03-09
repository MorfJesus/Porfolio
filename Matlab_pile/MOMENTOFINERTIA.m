close all

figure(1)
S(1) = polyshape([1 -1 -1 1],[0 0 19.3 19.3]);
S(2)=  polyshape([1 33.6 33.6 1],[17.3 17.3 19.3 19.3]);
S(3) = polyshape([33.6 31.6 31.6 33.6],[17.3 17.3 4.1-0.5 4.1-0.5]);
S(4) = polyshape([15.8 16.8 16.8 15.8],[17.3 17.3 19.3-15.7 19.3-15.7]);
S(5) = polyshape([16.8 31.6 31.6 16.8],[19.3-15.7 19.3-15.7 19.3-14.7 19.3-14.7]);

S(1) = translate(S(1), 1, 0);
S(2) = translate(S(2), 1, 0);
S(3) = translate(S(3), 1, 0);
S(4) = translate(S(4), 1, 0);
S(5) = translate(S(5), 1, 0);

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
%{
figure(2)

S_ANGLE = S;

for i = 1:5
    S_ANGLE(i).Vertices(:,1) = (S(i).Vertices(:,1)-Xc)*cos(alpha)+(S(i).Vertices(:,2)-Yc)*sin(alpha)+Xc;
    S_ANGLE(i).Vertices(:,2) =-(S(i).Vertices(:,1)-Xc)*sin(alpha)+(S(i).Vertices(:,2)-Yc)*cos(alpha)+Yc;
end

plot(S_ANGLE)
grid on

S = S_ANGLE

[Cx(1), Cy(1)] = centroid(S(1));
[Cx(2), Cy(2)] = centroid(S(2));
[Cx(3), Cy(3)] = centroid(S(3));
[Cx(4), Cy(4)] = centroid(S(4));
[Cx(5), Cy(5)] = centroid(S(5));


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
alpha = 0.5*atan(-2*Jxy/(Jx-Jy))

Juv=(Jx-Jy)/2*sin(2*alpha)+Jxy*cos(2*alpha)
(Jx-Jy)/2*sin(2*alpha)
Jxy*cos(2*alpha)
%}
