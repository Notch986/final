clear; clf; hold off;
xa=-2:0.4:2;
ya=-2:0.4:2;
B1=1;
[x,y]=meshgrid(xa,ya);
for zi=-2:0.4:2
    B1=B1+50;
    Bx=-B1*y./(x.^2+y.^2);
    By=+B1*x./(x.^2+y.^2);
    z=zi*x./x;
    Bz=0*sqrt(x.^2+y.^2);
    quiver3(x,y,z,Bx,By,Bz); hold on
end
axis square
