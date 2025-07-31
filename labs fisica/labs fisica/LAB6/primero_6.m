% CASO A: Corriente en dirección +z (antihorario)
clear; clf; hold off;
xa=-10:0.4:10;
ya=-10:0.4:10;
[x,y]=meshgrid(xa,ya);

% Parámetros del triángulo equilátero
a = 6;  % lado del triángulo
I = 1;  % intensidad de corriente

% Vértices del triángulo centrado en origen
h = a*sqrt(3)/2;
x1 = 0; y1 = 2*h/3;           % vértice superior
x2 = -a/2; y2 = -h/3;         % vértice inferior izquierdo
x3 = a/2; y3 = -h/3;          % vértice inferior derecho

% Campo magnético de cada lado del triángulo (antihorario)
% Lado 1-2
r12_sq = (x-x1).^2 + (y-y1).^2;
r12_sq(r12_sq < 0.1) = 0.1; % evitar singularidades
Bx12 = -I*(y-y1)./r12_sq;
By12 = I*(x-x1)./r12_sq;

% Lado 2-3
r23_sq = (x-x2).^2 + (y-y2).^2;
r23_sq(r23_sq < 0.1) = 0.1;
Bx23 = -I*(y-y2)./r23_sq;
By23 = I*(x-x2)./r23_sq;

% Lado 3-1
r31_sq = (x-x3).^2 + (y-y3).^2;
r31_sq(r31_sq < 0.1) = 0.1;
Bx31 = -I*(y-y3)./r31_sq;
By31 = I*(x-x3)./r31_sq;

% Campo total
Bx = Bx12 + Bx23 + Bx31;
By = By12 + By23 + By31;

% Graficar
quiver(x,y,Bx,By,'b');
hold on;
% Dibujar triángulo
plot([x1 x2 x3 x1], [y1 y2 y3 y1], 'r-', 'LineWidth', 2);
title('Caso A: Corriente +z (antihorario)');
axis square;

% CASO B: Corriente en dirección -z (horario)
figure;
clear; clf; hold off;
xa=-10:0.4:10;
ya=-10:0.4:10;
[x,y]=meshgrid(xa,ya);

% Parámetros del triángulo equilátero
a = 6;  % lado del triángulo
I = -1; % intensidad de corriente (negativa para horario)

% Vértices del triángulo centrado en origen
h = a*sqrt(3)/2;
x1 = 0; y1 = 2*h/3;           % vértice superior
x2 = -a/2; y2 = -h/3;         % vértice inferior izquierdo
x3 = a/2; y3 = -h/3;          % vértice inferior derecho

% Campo magnético de cada lado del triángulo (horario)
% Lado 1-3 (orden inverso)
r13_sq = (x-x1).^2 + (y-y1).^2;
r13_sq(r13_sq < 0.1) = 0.1;
Bx13 = -I*(y-y1)./r13_sq;
By13 = I*(x-x1)./r13_sq;

% Lado 3-2
r32_sq = (x-x3).^2 + (y-y3).^2;
r32_sq(r32_sq < 0.1) = 0.1;
Bx32 = -I*(y-y3)./r32_sq;
By32 = I*(x-x3)./r32_sq;

% Lado 2-1
r21_sq = (x-x2).^2 + (y-y2).^2;
r21_sq(r21_sq < 0.1) = 0.1;
Bx21 = -I*(y-y2)./r21_sq;
By21 = I*(x-x2)./r21_sq;

% Campo total
Bx = Bx13 + Bx32 + Bx21;
By = By13 + By32 + By21;

% Graficar
quiver(x,y,Bx,By,'g');
hold on;
% Dibujar triángulo
plot([x1 x2 x3 x1], [y1 y2 y3 y1], 'r-', 'LineWidth', 2);
title('Caso B: Corriente -z (horario)');
axis square;
