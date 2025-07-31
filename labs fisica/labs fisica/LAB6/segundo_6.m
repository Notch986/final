% CASO A: Corriente en dirección +z (antihorario)
clear; clf; hold off;
xa=-10:0.4:10;
ya=-10:0.4:10;
[x,y]=meshgrid(xa,ya);

% Parámetros del cuadrado
a = 6;  % lado del cuadrado
I = 1;  % intensidad de corriente

% Vértices del cuadrado centrado en el origen
x1 = -a/2; y1 = a/2;    % vértice superior izquierdo
x2 = a/2;  y2 = a/2;    % vértice superior derecho
x3 = a/2;  y3 = -a/2;   % vértice inferior derecho
x4 = -a/2; y4 = -a/2;   % vértice inferior izquierdo

% Campo magnético de cada lado del cuadrado (antihorario)
% Lado 1-2 (horizontal superior)
r12_sq = (x-x1).^2 + (y-y1).^2;
r12_sq(r12_sq < 0.1) = 0.1; % evitar singularidades
Bx12 = -I*(y-y1)./r12_sq;
By12 = I*(x-x1)./r12_sq;

% Lado 2-3 (vertical derecho)
r23_sq = (x-x2).^2 + (y-y2).^2;
r23_sq(r23_sq < 0.1) = 0.1;
Bx23 = -I*(y-y2)./r23_sq;
By23 = I*(x-x2)./r23_sq;

% Lado 3-4 (horizontal inferior)
r34_sq = (x-x3).^2 + (y-y3).^2;
r34_sq(r34_sq < 0.1) = 0.1;
Bx34 = -I*(y-y3)./r34_sq;
By34 = I*(x-x3)./r34_sq;

% Lado 4-1 (vertical izquierdo)
r41_sq = (x-x4).^2 + (y-y4).^2;
r41_sq(r41_sq < 0.1) = 0.1;
Bx41 = -I*(y-y4)./r41_sq;
By41 = I*(x-x4)./r41_sq;

% Campo total
Bx = Bx12 + Bx23 + Bx34 + Bx41;
By = By12 + By23 + By34 + By41;

% Graficar
quiver(x,y,Bx,By,'b');
hold on;
% Dibujar cuadrado
plot([x1 x2 x3 x4 x1], [y1 y2 y3 y4 y1], 'r-', 'LineWidth', 2);
title('Caso A: Corriente +z (antihorario)');
axis square;

% CASO B: Corriente en dirección -z (horario)
figure;
clear; clf; hold off;
xa=-10:0.4:10;
ya=-10:0.4:10;
[x,y]=meshgrid(xa,ya);

% Parámetros del cuadrado
a = 6;  % lado del cuadrado
I = -1; % intensidad de corriente (negativa para horario)

% Vértices del cuadrado centrado en el origen
x1 = -a/2; y1 = a/2;    % vértice superior izquierdo
x2 = a/2;  y2 = a/2;    % vértice superior derecho
x3 = a/2;  y3 = -a/2;   % vértice inferior derecho
x4 = -a/2; y4 = -a/2;   % vértice inferior izquierdo

% Campo magnético de cada lado del cuadrado (horario: orden inverso)
% Lado 1-4 (vertical izquierdo)
r14_sq = (x-x1).^2 + (y-y1).^2;
r14_sq(r14_sq < 0.1) = 0.1;
Bx14 = -I*(y-y1)./r14_sq;
By14 = I*(x-x1)./r14_sq;

% Lado 4-3 (horizontal inferior)
r43_sq = (x-x4).^2 + (y-y4).^2;
r43_sq(r43_sq < 0.1) = 0.1;
Bx43 = -I*(y-y4)./r43_sq;
By43 = I*(x-x4)./r43_sq;

% Lado 3-2 (vertical derecho)
r32_sq = (x-x3).^2 + (y-y3).^2;
r32_sq(r32_sq < 0.1) = 0.1;
Bx32 = -I*(y-y3)./r32_sq;
By32 = I*(x-x3)./r32_sq;

% Lado 2-1 (horizontal superior)
r21_sq = (x-x2).^2 + (y-y2).^2;
r21_sq(r21_sq < 0.1) = 0.1;
Bx21 = -I*(y-y2)./r21_sq;
By21 = I*(x-x2)./r21_sq;

% Campo total
Bx = Bx14 + Bx43 + Bx32 + Bx21;
By = By14 + By43 + By32 + By21;

% Graficar
quiver(x,y,Bx,By,'g');
hold on;
% Dibujar cuadrado
plot([x1 x2 x3 x4 x1], [y1 y2 y3 y4 y1], 'r-', 'LineWidth', 2);
title('Caso B: Corriente -z (horario)');
axis square;
