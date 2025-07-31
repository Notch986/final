clear; clf; hold off;

% Parámetros físicos
v = 1.0;                   % velocidad de la onda
lambda = 2 * pi;           % longitud de onda
f = v / lambda;            % frecuencia

% Eje espacial (onda se propaga en x)
x = linspace(0, 2*pi, 300);  % una longitud de onda

% Tiempo de simulación
tfin = 10;
dt = 0.2;

% Animación de la onda electromagnética
for t = 0:dt:tfin
    % Onda viajera en y (campo eléctrico)
    Ey = sin(x - v*t);

    % Onda viajera en z (campo magnético)
    Bz = sin(x - v*t);

    % Limpiar y graficar
    clf;
    plot3(x, Ey, zeros(size(x)), 'b', 'LineWidth', 2); hold on;
    plot3(x, zeros(size(x)), Bz, 'r', 'LineWidth', 2);

    % Configuración gráfica
    xlabel('x (posición)');
    ylabel('Campo eléctrico E(x, t)');
    zlabel('Campo magnético B(x, t)');
    title(sprintf('Frecuencia: %.3f Hz | Longitud de onda: %.2f m', f, lambda));
    axis([0 2*pi -1.5 1.5 -1.5 1.5]);
    view(45, 25);  % vista 3D
    grid on;

    pause(0.1);
end

% Mostrar valores en consola
fprintf('Frecuencia: %.4f Hz\n', f);
fprintf('Longitud de onda: %.4f m\n', lambda);
