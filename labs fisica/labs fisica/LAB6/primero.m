clear; clf; hold off;

xa = -2.1:0.12:2;
ya = -2.1:0.12:2;
[x, y] = meshgrid(xa, ya);

% Constante y posiciones
k = 1;
L = 2; % lado triángulo

x1 = -L/2; y1 = -L/2/sqrt(3);
x2 = L/2;  y2 = -L/2/sqrt(3);
x3 = 0;    y3 = L/sqrt(3);

% cargas positivas
q1 = 1; q2 = 1; q3 = 1;

z = k*q1./sqrt((x-x1).^2 + (y-y1).^2) + ...
    k*q2./sqrt((x-x2).^2 + (y-y2).^2) + ...
    k*q3./sqrt((x-x3).^2 + (y-y3).^2);

subplot(1,3,1);


zmax=max(max(z));
zmin=min(min(z));
dz=(zmax-zmin)/400;
nivel=zmin:dz:zmax;
contour(x,y,z,nivel);
title('(a) Cargas positivas');
axis equal tight;

% negativas
q1 = -1; q2 = -1; q3 = -1;

z = k*q1./sqrt((x-x1).^2 + (y-y1).^2) + ...
    k*q2./sqrt((x-x2).^2 + (y-y2).^2) + ...
    k*q3./sqrt((x-x3).^2 + (y-y3).^2);

subplot(1,3,2);
zmax = max(z(:)); zmin = min(z(:)); dz = (zmax-zmin)/400;
nivel = zmin:dz:zmax;
contour(x, y, z, nivel);
title('(b) Cargas negativas');
axis equal tight;

% cargas intercalas
q1 = -1; q2 = 1; q3 = -1;

z = k*q1./sqrt((x-x1).^2 + (y-y1).^2) + ...
    k*q2./sqrt((x-x2).^2 + (y-y2).^2) + ...
    k*q3./sqrt((x-x3).^2 + (y-y3).^2);

subplot(1,3,3);
zmax = max(z(:)); zmin = min(z(:)); dz = (zmax-zmin)/100;
nivel = zmin:dz:zmax;
contour(x, y, z, nivel);
title('(c) Cargas intercaladas');
axis equal tight;
