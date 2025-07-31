% CASO A: Corriente en dirección +z (antihorario)
clear; clf; hold off;
xa=-10:0.4:10;
ya=-10:0.4:10;
[x,y]=meshgrid(xa,ya);

% Parámetros del hexágono
a = 4;  % radio del hexágono (distancia del centro a vértice)
I = 1;  % intensidad de corriente

% Vértices del hexágono regular centrado en el origen
% Ángulos: 0°, 60°, 120°, 180°, 240°, 300°
x1 = a;           y1 = 0;              % vértice 1 (0°)
x2 = a/2;         y2 = a*sqrt(3)/2;    % vértice 2 (60°)
x3 = -a/2;        y3 = a*sqrt(3)/2;    % vértice 3 (120°)
x4 = -a;          y4 = 0;              % vértice 4 (180°)
x5 = -a/2;        y5 = -a*sqrt(3)/2;   % vértice 5 (240°)
x6 = a/2;         y6 = -a*sqrt(3)/2;   % vértice 6 (300°)

% Campo magnético de cada lado del hexágono (antihorario)
% Lado 1-2
r12_sq = (x-x1).^2 + (y-y1).^2;
r12_sq(r12_sq < 0.1) = 0.1;
Bx12 = -I*(y-y1)./r12_sq;
By12 = I*(x-x1)./r12_sq;

% Lado 2-3
r23_sq = (x-x2).^2 + (y-y2).^2;
r23_sq(r23_sq < 0.1) = 0.1;
Bx23 = -I*(y-y2)./r23_sq;
By23 = I*(x-x2)./r23_sq;

% Lado 3-4
r34_sq = (x-x3).^2 + (y-y3).^2;
r34_sq(r34_sq < 0.1) = 0.1;
Bx34 = -I*(y-y3)./r34_sq;
By34 = I*(x-x3)./r34_sq;

% Lado 4-5
r45_sq = (x-x4).^2 + (y-y4).^2;
r45_sq(r45_sq < 0.1) = 0.1;
Bx45 = -I*(y-y4)./r45_sq;
By45 = I*(x-x4)./r45_sq;

% Lado 5-6
r56_sq = (x-x5).^2 + (y-y5).^2;
r56_sq(r56_sq < 0.1) = 0.1;
Bx56 = -I*(y-y5)./r56_sq;
By56 = I*(x-x5)./r56_sq;

% Lado 6-1
r61_sq = (x-x6).^2 + (y-y6).^2;
r61_sq(r61_sq < 0.1) = 0.1;
Bx61 = -I*(y-y6)./r61_sq;
By61 = I*(x-x6)./r61_sq;

% Campo total
Bx = Bx12 + Bx23 + Bx34 + Bx45 + Bx56 + Bx61;
By = By12 + By23 + By34 + By45 + By56 + By61;

% Graficar
quiver(x,y,Bx,By,'b');
hold on;
% Dibujar hexágono
plot([x1 x2 x3 x4 x5 x6 x1], [y1 y2 y3 y4 y5 y6 y1], 'r-', 'LineWidth', 2);
title('Caso A: Corriente +z (antihorario)');
axis square;

% CASO B: Corriente en dirección -z (horario)
figure;
clear; clf; hold off;
xa=-10:0.4:10;
ya=-10:0.4:10;
[x,y]=meshgrid(xa,ya);

% Parámetros del hexágono
a = 4;  % radio del hexágono
I = -1; % intensidad de corriente (negativa para horario)

% Vértices del hexágono regular centrado en el origen
x1 = a;           y1 = 0;              % vértice 1 (0°)
x2 = a/2;         y2 = a*sqrt(3)/2;    % vértice 2 (60°)
x3 = -a/2;        y3 = a*sqrt(3)/2;    % vértice 3 (120°)
x4 = -a;          y4 = 0;              % vértice 4 (180°)
x5 = -a/2;        y5 = -a*sqrt(3)/2;   % vértice 5 (240°)
x6 = a/2;         y6 = -a*sqrt(3)/2;   % vértice 6 (300°)

% Campo magnético de cada lado del hexágono (horario: orden inverso)
% Lado 1-6
r16_sq = (x-x1).^2 + (y-y1).^2;
r16_sq(r16_sq < 0.1) = 0.1;
Bx16 = -I*(y-y1)./r16_sq;
By16 = I*(x-x1)./r16_sq;

% Lado 6-5
r65_sq = (x-x6).^2 + (y-y6).^2;
r65_sq(r65_sq < 0.1) = 0.1;
Bx65 = -I*(y-y6)./r65_sq;
By65 = I*(x-x6)./r65_sq;

% Lado 5-4
r54_sq = (x-x5).^2 + (y-y5).^2;
r54_sq(r54_sq < 0.1) = 0.1;
Bx54 = -I*(y-y5)./r54_sq;
By54 = I*(x-x5)./r54_sq;

% Lado 4-3
r43_sq = (x-x4).^2 + (y-y4).^2;
r43_sq(r43_sq < 0.1) = 0.1;
Bx43 = -I*(y-y4)./r43_sq;
By43 = I*(x-x4)./r43_sq;

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
Bx = Bx16 + Bx65 + Bx54 + Bx43 + Bx32 + Bx21;
By = By16 + By65 + By54 + By43 + By32 + By21;

% Graficar
quiver(x,y,Bx,By,'g');
hold on;
% Dibujar hexágono
plot([x1 x2 x3 x4 x5 x6 x1], [y1 y2 y3 y4 y5 y6 y1], 'r-', 'LineWidth', 2);
title('Caso B: Corriente -z (horario)');
axis square;
