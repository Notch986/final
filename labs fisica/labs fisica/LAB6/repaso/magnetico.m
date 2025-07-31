clear; clf; hold off;
xa=-10:0.4:10;
ya=-10:0.4:10;
B1=1;d=4;B2=-1;
[x,y]=meshgrid(xa,ya);
Bx=-B1*y./(x.^2+y.^2)-B2*y./((x-d).^2+y.^2);
By=+B1*x./(x.^2+y.^2)+B2*(x-d)./((x-d).^2+y.^2);
quiver(x,y,Bx,By);
axis square
