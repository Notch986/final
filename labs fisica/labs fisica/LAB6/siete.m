clear; clf; hold off;

xa = -2.1:0.12:2;
ya = -2.1:0.12:2;
[x, y] = meshgrid(xa, ya);
k = 1;

% Parámetros del alambre
L = 1;                % longitud
dx = 0.0001;
N = round(L / dx);

xCargas = linspace(-L/2, L/2, N);
yCargas = zeros(1, N);
q = 1;

z = zeros(size(x));
for i = 1:N
    Rx = x - xCargas(i);
    Ry = y - yCargas(i);
    R = sqrt(Rx.^2 + Ry.^2);
    z = z + k*q ./ (R + eps);
end

zmax = max(z(:));
zmin = min(z(:));
dz = (zmax - zmin)/400;
nivel = zmin:dz:zmax;

contour(x, y, z, nivel);
title('preg 7');
xlabel('x'); ylabel('y');
axis equal; grid on;
