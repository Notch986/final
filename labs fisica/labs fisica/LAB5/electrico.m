



clear; clf; hold off;
xa=-2:0.5:2;
ya=-2:0.5:2;
k=1.; q1=1; q2=-1;
x1=1; x2=-1
[x,y]=meshgrid(xa,ya);
Ex=k*q1*(x-x1)./((x-x1).^2+y.^2).^(1.5)+k*q2*(x-x2)./((x-x2).^2+y.^2).^(1.5);
Ey=k*q1*y./((x-x1).^2+y.^2).^(1.5)+k*q2*y./((x-x2).^2+y.^2).^(1.5);
quiver(x,y,Ex,Ey);
axis square
