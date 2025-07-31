clear; clf; hold off;
xa=-4:0.2:4;
ya=-4:0.2:4;
B1=1;
[x,y]=meshgrid(xa,ya);

% Parámetros de la lámina de alambres
I = 1;          % corriente en cada alambre
d = 0.01;        % separación entre alambres
n_alambres = 100; % número de alambres

% Posiciones de los alambres (alineados en y, corriente en +z)
y_alambres = linspace(-3, 3, n_alambres);

for zi=-2:0.4:2
    B1=B1+20;

    % Inicializar campos totales
    Bx_total = 0*x;  % matriz de ceros del tamaño correcto
    By_total = 0*x;

    % Sumar contribución de cada alambre infinito
    for i = 1:n_alambres
        y_alambre = y_alambres(i);

        % Distancia de cada punto al alambre i (alambre en x=0, y=y_alambre)
        dx = x - 0;           % distancia en x al alambre
        dy = y - y_alambre;   % distancia en y al alambre
        r_sq = dx.^2 + dy.^2; % distancia al cuadrado

        % Evitar singularidades
        r_sq(r_sq < 0.01) = 0.01;

        % Campo magnético de alambre infinito (ley de Ampère)
        % B = (μ₀I/2πr) en dirección tangencial
        Bx_alambre = -B1 * dy ./ r_sq;  % componente x
        By_alambre = B1 * dx ./ r_sq;   % componente y

        % Sumar al campo total
        Bx_total = Bx_total + Bx_alambre;
        By_total = By_total + By_alambre;
    end

    % Asignar campos totales
    Bx = Bx_total;
    By = By_total;

    % Coordenada z constante para este nivel
    z = zi*x./x;

    % Campo en z (principalmente en xy para alambres en z)
    Bz = 0*sqrt(x.^2+y.^2);

    % Dibujar vectores de campo en 3D
    quiver(x,y,Bx,By,'b'); hold on
end

% Dibujar los alambres infinitos
for i = 1:n_alambres
    y_alambre = y_alambres(i);
    z_line = -2:0.1:2;
    x_line = 0*z_line;  % x = 0 para todos los alambres
    y_line = y_alambre*ones(size(z_line));
    plot3(x_line, y_line, z_line, 'r-', 'LineWidth', 3);
end

% Dibujar la lámina (plano x=0)
[Y_plane, Z_plane] = meshgrid(-3:0.5:3, -2:0.5:2);
X_plane = 0*Y_plane;
surf(X_plane, Y_plane, Z_plane, 'FaceAlpha', 0.3, 'FaceColor', 'yellow', 'EdgeColor', 'none');

axis equal;
xlabel('x'); ylabel('y'); zlabel('z');
title('Campo Magnético - Lámina Infinita de Alambres');
view(45, 30); % vista 3D oblicua
grid on;

% Información
fprintf('Lámina infinita con %d alambres\n', n_alambres);
fprintf('Separación entre alambres: %.2f\n', d);
fprintf('Corriente por alambre: %.2f A\n', I);
