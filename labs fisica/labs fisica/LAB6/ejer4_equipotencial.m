clear; clf; hold off;

xa = -2.1:0.12:2;
ya = -2.1:0.12:2;
[x, y] = meshgrid(xa, ya);
k = 1;

% coordenadas del hexágono
r = 1.2;
for i = 1:6
    ang = 2*pi*(i-1)/6;
    posX(i) = r*cos(ang);
    posY(i) = r*sin(ang);
end

% positivo
z1 = zeros(size(x));
for i = 1:6
    z1 = z1 + k*1 ./ sqrt((x - posX(i)).^2 + (y - posY(i)).^2);
end
zmax1 = max(max(z1));
zmin1 = min(min(z1));
dz1 = (zmax1 - zmin1)/400;
nivel1 = zmin1:dz1:zmax1;

subplot(1,3,1);
contour(x, y, z1, nivel1);
title('Todas positivas');
axis equal; grid on;

% negativo
z2 = zeros(size(x));
for i = 1:6
    z2 = z2 + k*(-1) ./ sqrt((x - posX(i)).^2 + (y - posY(i)).^2);
end
zmax2 = max(max(z2));
zmin2 = min(min(z2));
dz2 = (zmax2 - zmin2)/400;
nivel2 = zmin2:dz2:zmax2;

subplot(1,3,2);
contour(x, y, z2, nivel2);
title('Todas negativas');
axis equal; grid on;

% intercaladas
z3 = zeros(size(x));
for i = 1:6
    carga = (-1)^(i+1);  % alterna entre +1 y -1
    z3 = z3 + k*carga ./ sqrt((x - posX(i)).^2 + (y - posY(i)).^2);
end
zmax3 = max(max(z3));
zmin3 = min(min(z3));
dz3 = (zmax3 - zmin3)/400;
nivel3 = zmin3:dz3:zmax3;

subplot(1,3,3);
contour(x, y, z3, nivel3);
title('Intercaladas');
axis equal; grid on;

sgtitle('Potencial eléctrico en hexágono (equipotencial)');
