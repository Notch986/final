clear; clc; close all;

% Parámetros de la simulación Monte Carlo
m = 100000;     % Número de puntos por iteración  
veces = 50;     % Número de iteraciones

% Límites de integración
a = 0;          % x = 0
b = 1;          % x = 1

% Límites del rectángulo que contiene la región
% u = e^x en [0,1], entonces u va de e^0 = 1 hasta e^1 = e ≈ 2.718
u_min = 0;      % límite inferior para u
u_max = exp(1); % límite superior para u (e ≈ 2.718)

% Variables para estadísticas
sa = 0;      % suma de áreas
saa = 0;     % suma de áreas al cuadrado
px = []; pu = [];  % puntos dentro de la región

% Simulación Monte Carlo
for k = 1:veces
    n = 0;  % contador de puntos bajo la curva
    
    for i = 1:m
        % Generar punto aleatorio en el rectángulo [a,b] × [u_min, u_max]
        x = a + (b - a) * rand;
        u = u_min + (u_max - u_min) * rand;
        
        % Verificar si el punto está bajo la curva u ≤ e^x
        if u <= exp(x)
            n = n + 1;
            % Guardar algunos puntos para visualización (solo primera iteración)
            if k == 1 && length(px) < 5000
                px(end+1) = x;
                pu(end+1) = u;
            end
        end
    end
    
    % Calcular área para esta iteración
    area = n * (b - a) * (u_max - u_min) / m;
    sa = sa + area;
    saa = saa + area^2;
    
    % Mostrar progreso cada 10 iteraciones
    if mod(k, 10) == 0
        fprintf('🔄 Iteración %2d: %5d puntos bajo la curva ➜ área = %.6f\n', k, n, area);
    end
end

% Crear visualización 2D
figure(1);
clf;

% Dibujar la curva u = e^x
x_curva = linspace(0, 1, 1000);
u_curva = exp(x_curva);
plot(x_curva, u_curva, 'b-', 'LineWidth', 3);
hold on;

% Mostrar los puntos Monte Carlo bajo la curva
scatter(px, pu, 1, 'red', 'filled', 'MarkerFaceAlpha', 0.6);

% Dibujar las líneas límite
line([0, 0], [0, u_max], 'Color', 'green', 'LineWidth', 2); % x = 0
line([1, 1], [0, u_max], 'Color', 'green', 'LineWidth', 2); % x = 1
line([0, 1], [0, 0], 'Color', 'black', 'LineWidth', 1);     % u = 0

% Rellenar el área bajo la curva
x_fill = [0, x_curva, 1, 0];
u_fill = [0, u_curva, 0, 0];
fill(x_fill, u_fill, 'yellow', 'FaceAlpha', 0.3, 'EdgeColor', 'none');

% Configurar la gráfica
xlabel('x');
ylabel('u');

grid on;
axis([0, 1, 0, u_max]);
legend('u = e^x', 'Puntos Monte Carlo', 'x = 0', 'x = 1', 'Área calculada', 'Location', 'northwest');


