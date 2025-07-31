clear; clc; close all;



% Parámetros de la simulación Monte Carlo
m = 100000;     % Número total de puntos por iteración
veces = 50;     % Número de iteraciones para estadísticas

% Límites del octante x < 0, y > 0, z < 0
% El elipsoide x²/4 + y²/4 + z²/9 = 1 tiene semi-ejes: a=2, b=2, c=3
ax = -2;  bx = 0;   % x: de -2 a 0 (x < 0)
ay = 0;   by = 2;   % y: de 0 a 2  (y > 0)
az = -3;  bz = 0;   % z: de -3 a 0  (z < 0)

% Calcular dimensiones de la caja limitante
largo_x = bx - ax;  % 2
largo_y = by - ay;  % 2  
largo_z = bz - az;  % 3

% Volumen de la caja limitante
volumen_caja = largo_x * largo_y * largo_z;

% Variables para estadísticas
sv = 0;      % suma de volúmenes
svv = 0;     % suma de volúmenes al cuadrado
px = []; py = []; pz = [];  % puntos dentro del elipsoide (para visualización)

% Simulación Monte Carlo
for k = 1:veces
    n = 0;  % contador de puntos dentro del elipsoide
    
    for i = 1:m
        % Generar punto aleatorio en la caja limitante
        x = ax + (bx - ax) * rand;  % x ∈ [-2, 0]
        y = ay + (by - ay) * rand;  % y ∈ [0, 2]
        z = az + (bz - az) * rand;  % z ∈ [-3, 0]
        
        % Verificar si el punto está dentro del elipsoide: x²/4 + y²/4 + z²/9 ≤ 1
        ecuacion_elipsoide = (x^2)/4 + (y^2)/4 + (z^2)/9;
        
        if ecuacion_elipsoide <= 1
            n = n + 1;
            % Guardar algunos puntos para visualización (solo primera iteración)
            if k == 1 && length(px) < 2000
                px(end+1) = x;
                py(end+1) = y;
                pz(end+1) = z;
            end
        end
    end
    
    % Calcular volumen usando la fórmula especificada: (n/m) * (by-ay) * (bx-ax) * (bz-az)
    volumen = (n/m) * (by - ay) * (bx - ax) * (bz - az);
    sv = sv + volumen;
    svv = svv + volumen^2;
    
    % Mostrar progreso cada 10 iteraciones
    if mod(k, 10) == 0
        proporcion = n/m;
        fprintf('🔄 Iteración %2d: n=%5d, n/m=%.4f ➜ volumen = %.6f\n', k, n, proporcion, volumen);
    end
end

% Calcular estadísticas finales
promedio = sv / veces;
varianza = (svv - sv^2/veces) / (veces - 1);
desviacion = sqrt(varianza);
error_estandar = desviacion / sqrt(veces);

% Valor teórico
% Volumen total del elipsoide = (4/3)π * a * b * c = (4/3)π * 2 * 2 * 3 = 16π
% Volumen en un octante = (1/8) * 16π = 2π
teorico = 2 * pi;

% Crear visualización 3D
figure(1);
clf;

% Dibujar el elipsoide completo (semitransparente)
[X, Y, Z] = ellipsoid(0, 0, 0, 2, 2, 3, 30);
surf(X, Y, Z, 'FaceAlpha', 0.1, 'EdgeAlpha', 0.1, 'FaceColor', 'blue');
hold on;

% Mostrar los puntos Monte Carlo en el octante
scatter3(px, py, pz, 3, 'red', 'filled', 'MarkerFaceAlpha', 0.8);

% Dibujar los planos que definen el octante
% Plano x = 0
[yy, zz] = meshgrid(0:0.5:2, -3:0.5:0);
xx = zeros(size(yy));
mesh(xx, yy, zz, 'FaceAlpha', 0.2, 'EdgeColor', 'green', 'FaceColor', 'green');

% Plano y = 0  
[xx, zz] = meshgrid(-2:0.5:0, -3:0.5:0);
yy = zeros(size(xx));
mesh(xx, yy, zz, 'FaceAlpha', 0.2, 'EdgeColor', 'magenta', 'FaceColor', 'magenta');

% Plano z = 0
[xx, yy] = meshgrid(-2:0.5:0, 0:0.5:2);
zz = zeros(size(xx));
mesh(xx, yy, zz, 'FaceAlpha', 0.2, 'EdgeColor', 'cyan', 'FaceColor', 'cyan');

% Configurar la gráfica
xlabel('x'); ylabel('y'); zlabel('z');
title(sprintf('🎯 MÉTODO MONTE CARLO\nElipsoide x²/4 + y²/4 + z²/9 = 1\nOctante x<0, y>0, z<0 ➜ Volumen = %.4f', promedio));
grid on;
axis equal;
xlim([-2.5, 0.5]); ylim([-0.5, 2.5]); zlim([-3.5, 0.5]);
view(45, 30);

legend('Elipsoide completo', 'Puntos Monte Carlo', 'Plano x=0', 'Plano y=0', 'Plano z=0', 'Location', 'best');

% Agregar texto con información
text(-1, 1, -1.5, sprintf('n/m ≈ %.4f\nVolumen ≈ %.3f', length(px)/m, promedio), ...
     'FontSize', 10, 'BackgroundColor', 'white', 'HorizontalAlignment', 'center');

