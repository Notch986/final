clear; clf; hold off;
figure('Position', [100, 100, 1200, 400]);  % Tamaño de figura grande

xa = -2.1:0.12:2;
ya = -2.1:0.12:2;
[x, y] = meshgrid(xa, ya);

% Constante y posiciones
k = 1;
L = 2;

x1 = -L/2; y1 = -L/(2*sqrt(3));
x2 =  L/2; y2 = -L/(2*sqrt(3));
x3 = 0;    y3 =  L/sqrt(3);

% === (a) Cargas positivas ===
q1 = 1; q2 = 1; q3 = 1;

Ex = k*q1*(x-x1)./((x-x1).^2 + (y-y1).^2).^(1.5) + ...
     k*q2*(x-x2)./((x-x2).^2 + (y-y2).^2).^(1.5) + ...
     k*q3*(x-x3)./((x-x3).^2 + (y-y3).^2).^(1.5);

Ey = k*q1*(y-y1)./((x-x1).^2 + (y-y1).^2).^(1.5) + ...
     k*q2*(y-y2)./((x-x2).^2 + (y-y2).^2).^(1.5) + ...
     k*q3*(y-y3)./((x-x3).^2 + (y-y3).^2).^(1.5);

subplot(1,3,1);
quiver(x, y, Ex, Ey, 'r');
title('(a) Cargas positivas');
axis equal tight;

% === (b) Cargas negativas ===
q1 = -1; q2 = -1; q3 = -1;

Ex = k*q1*(x-x1)./((x-x1).^2 + (y-y1).^2).^(1.5) + ...
     k*q2*(x-x2)./((x-x2).^2 + (y-y2).^2).^(1.5) + ...
     k*q3*(x-x3)./((x-x3).^2 + (y-y3).^2).^(1.5);

Ey = k*q1*(y-y1)./((x-x1).^2 + (y-y1).^2).^(1.5) + ...
     k*q2*(y-y2)./((x-x2).^2 + (y-y2).^2).^(1.5) + ...
     k*q3*(y-y3)./((x-x3).^2 + (y-y3).^2).^(1.5);

subplot(1,3,2);
quiver(x, y, Ex, Ey, 'b');
title('(b) Cargas negativas');
axis equal tight;

% === (c) Cargas intercaladas ===
q1 = -1; q2 = 1; q3 = -1;

Ex = k*q1*(x-x1)./((x-x1).^2 + (y-y1).^2).^(1.5) + ...
     k*q2*(x-x2)./((x-x2).^2 + (y-y2).^2).^(1.5) + ...
     k*q3*(x-x3)./((x-x3).^2 + (y-y3).^2).^(1.5);

Ey = k*q1*(y-y1)./((x-x1).^2 + (y-y1).^2).^(1.5) + ...
     k*q2*(y-y2)./((x-x2).^2 + (y-y2).^2).^(1.5) + ...
     k*q3*(y-y3)./((x-x3).^2 + (y-y3).^2).^(1.5);

subplot(1,3,3);
quiver(x, y, Ex, Ey, 'g');
title('(c) Cargas intercaladas');
axis equal tight;

