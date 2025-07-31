clear; clf; hold off;
xa=-2.1:0.12:2;
ya=-2.1:0.12:2;
k=1.; q1=1; q2=-1;
x1=1; x2=-1
[x,y]=meshgrid(xa,ya);
z=k*q1./sqrt((x-x1).^2+y.^2)+k*q2./sqrt((x-x2).^2+y.^2);
mesh(x,y,z)
