%% MODELO DE LORENZ - MÉTODO DE EULER EXPLÍCITO
% Resolución numérica de las ecuaciones de Lorenz usando el método de Euler
%
% Sistema de ecuaciones:
% dx/dt = -sigma*(y - x)
% dy/dt = x*(r - z) - y
% dz/dt = x*y - b*z

clear all; close all; clc;

%% PARÁMETROS DEL MODELO DE LORENZ
sigma = 10;      % Número de Prandtl
r = 28;          % Número de Rayleigh
b = 8/3;         % Parámetro geométrico

%% CONDICIONES INICIALES
x = 1;           % Valor inicial de x
y = 1;           % Valor inicial de y
z = 1;           % Valor inicial de z

%% PARÁMETROS NUMÉRICOS
h = 0.01;        % Paso de tiempo (h en lugar de dt)
t_final = 50;    % Tiempo final de simulación
pasos = round(t_final/h);  % Número de pasos

%% DEFINIR LAS ECUACIONES COMO FUNCIONES
% Funciones que calculan las derivadas (las "velocidades" en el espacio de fase)
dxdt = @(x, y, z) -sigma * (y - x);           % Ecuación 1
dydt = @(x, y, z) x * (r - z) - y;            % Ecuación 2
dzdt = @(x, y, z) x * y - b * z;              % Ecuación 3

%% INICIALIZAR VECTORES PARA ALMACENAR RESULTADOS
t_vec = zeros(pasos+1, 1);
x_vec = zeros(pasos+1, 1);
y_vec = zeros(pasos+1, 1);
z_vec = zeros(pasos+1, 1);

% Guardar condiciones iniciales
t_vec(1) = 0;
x_vec(1) = x;
y_vec(1) = y;
z_vec(1) = z;

%% MÉTODO DE EULER EXPLÍCITO
fprintf('Resolviendo sistema de Lorenz con método de Euler explícito...\n');
fprintf('Parámetros: sigma=%.1f, r=%.1f, b=%.3f\n', sigma, r, b);
fprintf('Paso de tiempo h=%.4f, Pasos=%d\n\n', h, pasos);

tic; % Iniciar cronómetro

for i = 1:pasos
    % Calcular las derivadas (velocidades en el espacio de fase)
    vx = dxdt(x, y, z);  % dx/dt
    vy = dydt(x, y, z);  % dy/dt
    vz = dzdt(x, y, z);  % dz/dt

    % Actualizar variables usando Euler explícito
    % Nuevos valores = valores actuales + velocidad * paso_tiempo
    x = x + vx * h;     % Ecuación 1: x(n+1) = x(n) + dx/dt * h
    y = y + vy * h;     % Ecuación 2: y(n+1) = y(n) + dy/dt * h
    z = z + vz * h;     % Ecuación 3: z(n+1) = z(n) + dz/dt * h

    % Guardar resultados
    t_vec(i+1) = i * h;
    x_vec(i+1) = x;
    y_vec(i+1) = y;
    z_vec(i+1) = z;

    % Mostrar progreso cada 1000 pasos
    if mod(i, 1000) == 0
        fprintf('Paso %d/%d completado\n', i, pasos);
    end
end

tiempo_calculo = toc;
fprintf('\nCálculo completado en %.4f segundos\n\n', tiempo_calculo);

%% GRÁFICAS DEL MODELO DE LORENZ PARA FLUIDOS ATMOSFÉRICOS
% En el modelo de Lorenz:
% x = intensidad del movimiento del fluido (velocidad horizontal)
% y = variación de temperatura en dirección horizontal
% z = variación de temperatura en dirección vertical

% Crear figura principal
figure('Position', [100, 100, 1200, 600], 'Name', 'Modelo de Lorenz - Variables Físicas del Fluido Atmosférico');

%% 1. GRÁFICO: TIEMPO vs VELOCIDAD DEL FLUIDO (horizontal)
subplot(1,2,1);
plot(t_vec, x_vec, 'b-', 'LineWidth', 2);
hold on;
plot(t_vec(1), x_vec(1), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'red'); % Punto inicial
plot(t_vec(end), x_vec(end), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'green'); % Punto final
grid on;
xlabel('Tiempo (t)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Velocidad del Fluido (x)', 'FontSize', 14, 'FontWeight', 'bold');
title({'Evolución Temporal de la Velocidad del Fluido'; 'Intensidad del Movimiento Horizontal'}, ...
      'FontSize', 16, 'FontWeight', 'bold');
legend('Velocidad x(t)', 'Inicio', 'Final', 'Location', 'best', 'FontSize', 12);
axis tight;

% Añadir información estadística en el gráfico
text(0.02, 0.95, sprintf('Máx: %.2f', max(x_vec)), 'Units', 'normalized', ...
     'BackgroundColor', 'white', 'FontSize', 10);
text(0.02, 0.88, sprintf('Mín: %.2f', min(x_vec)), 'Units', 'normalized', ...
     'BackgroundColor', 'white', 'FontSize', 10);

%% 2. GRÁFICO: TEMPERATURA VERTICAL vs TEMPERATURA HORIZONTAL
subplot(1,2,2);
plot(y_vec, z_vec, 'r-', 'LineWidth', 2);
hold on;
plot(y_vec(1), z_vec(1), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'red', 'MarkerEdgeColor', 'black'); % Punto inicial
plot(y_vec(end), z_vec(end), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'green', 'MarkerEdgeColor', 'black'); % Punto final

% Añadir flechas para mostrar dirección del flujo
n_arrows = 20; % Número de flechas
step_arrow = floor(length(y_vec)/n_arrows);
for i = 1:step_arrow:length(y_vec)-step_arrow
    dx_arrow = y_vec(i+step_arrow) - y_vec(i);
    dy_arrow = z_vec(i+step_arrow) - z_vec(i);
    if norm([dx_arrow, dy_arrow]) > 0.1  % Solo dibujar si hay movimiento significativo
        quiver(y_vec(i), z_vec(i), dx_arrow, dy_arrow, 0.3, 'k', 'MaxHeadSize', 0.8);
    end
end

grid on;
xlabel('Temperatura Horizontal (y)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Temperatura Vertical (z)', 'FontSize', 14, 'FontWeight', 'bold');
title({'Diagrama de Fase: Temperaturas'; 'Horizontal vs Vertical'}, ...
      'FontSize', 16, 'FontWeight', 'bold');
legend('Trayectoria', 'Estado Inicial', 'Estado Final', 'Dirección del Flujo', ...
       'Location', 'best', 'FontSize', 12);
axis equal;
axis tight;

% Añadir información en el gráfico
text(0.02, 0.95, sprintf('Rango Y: [%.1f, %.1f]', min(y_vec), max(y_vec)), ...
     'Units', 'normalized', 'BackgroundColor', 'white', 'FontSize', 10);
text(0.02, 0.88, sprintf('Rango Z: [%.1f, %.1f]', min(z_vec), max(z_vec)), ...
     'Units', 'normalized', 'BackgroundColor', 'white', 'FontSize', 10);

%% GRÁFICO ADICIONAL: VISTA 3D DEL SISTEMA COMPLETO
figure('Position', [150, 150, 800, 600], 'Name', 'Atractor de Lorenz - Sistema Completo 3D');

plot3(x_vec, y_vec, z_vec, 'b-', 'LineWidth', 1.5);
hold on;
plot3(x_vec(1), y_vec(1), z_vec(1), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'red', 'MarkerEdgeColor', 'black');
plot3(x_vec(end), y_vec(end), z_vec(end), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'green', 'MarkerEdgeColor', 'black');

grid on;
xlabel('Velocidad del Fluido (x)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Temperatura Horizontal (y)', 'FontSize', 14, 'FontWeight', 'bold');
zlabel('Temperatura Vertical (z)', 'FontSize', 14, 'FontWeight', 'bold');
title({'Atractor de Lorenz - Sistema Atmosférico Completo'; ...
       'Velocidad del Fluido vs Temperaturas Horizontal y Vertical'}, ...
      'FontSize', 16, 'FontWeight', 'bold');
legend('Trayectoria del Sistema', 'Estado Inicial', 'Estado Final', 'Location', 'best');
view(-37.5, 30);
axis tight;

% Añadir texto explicativo
text(min(x_vec), max(y_vec), max(z_vec), ...
     sprintf('σ=%.0f, r=%.0f, b=%.2f', sigma, r, b), ...
     'FontSize', 12, 'BackgroundColor', 'yellow', 'EdgeColor', 'black');

%% MOSTRAR LAS ECUACIONES Y SU INTERPRETACIÓN FÍSICA
fprintf('=== MODELO DE LORENZ PARA FLUIDOS ATMOSFÉRICOS ===\n');
fprintf('Variables físicas del sistema:\n');
fprintf('  x = Intensidad del movimiento del fluido (velocidad horizontal)\n');
fprintf('  y = Variación de temperatura en dirección horizontal\n');
fprintf('  z = Variación de temperatura en dirección vertical\n\n');

fprintf('Ecuaciones del sistema:\n');
fprintf('Ecuación 1: dx/dt = -σ(y - x)     = -%.1f(y - x)\n', sigma);
fprintf('           (Evolución de la velocidad del fluido)\n');
fprintf('Ecuación 2: dy/dt = x(r - z) - y  = x(%.1f - z) - y\n', r);
fprintf('           (Variación de temperatura horizontal)\n');
fprintf('Ecuación 3: dz/dt = xy - bz       = xy - %.3fz\n', b);
fprintf('           (Variación de temperatura vertical)\n\n');

fprintf('Parámetros físicos:\n');
fprintf('  σ = %.1f (Número de Prandtl - relación viscosidad/difusión térmica)\n', sigma);
fprintf('  r = %.1f (Número de Rayleigh - diferencia de temperatura)\n', r);
fprintf('  b = %.3f (Parámetro geométrico - relación de aspecto)\n\n', b);

fprintf('=== MÉTODO DE EULER EXPLÍCITO ===\n');
fprintf('x(n+1) = x(n) + (velocidad del fluido)'' * h\n');
fprintf('y(n+1) = y(n) + (cambio temp. horizontal)'' * h\n');
fprintf('z(n+1) = z(n) + (cambio temp. vertical)'' * h\n\n');

%% ESTADÍSTICAS DE LA SIMULACIÓN FÍSICA
fprintf('=== RESULTADOS DEL MODELO ATMOSFÉRICO ===\n');
fprintf('Condiciones iniciales del fluido:\n');
fprintf('  Velocidad inicial: x₀ = %.2f\n', x_vec(1));
fprintf('  Temp. horizontal inicial: y₀ = %.2f\n', y_vec(1));
fprintf('  Temp. vertical inicial: z₀ = %.2f\n', z_vec(1));

fprintf('\nComportamiento del sistema:\n');
fprintf('  Velocidad del fluido: [%.2f, %.2f]\n', min(x_vec), max(x_vec));
fprintf('  Temperatura horizontal: [%.2f, %.2f]\n', min(y_vec), max(y_vec));
fprintf('  Temperatura vertical: [%.2f, %.2f]\n', min(z_vec), max(z_vec));

fprintf('\nInterpretación física:\n');
if max(abs(x_vec)) > 10
    fprintf('  • El fluido muestra movimiento caótico intenso\n');
else
    fprintf('  • El fluido tiene movimiento moderado\n');
end

if max(z_vec) > 25
    fprintf('  • Hay gradientes de temperatura vertical significativos\n');
else
    fprintf('  • Los gradientes de temperatura son moderados\n');
end

fprintf('  • El sistema exhibe comportamiento de convección atmosférica caótica\n');

%% FUNCIÓN AUXILIAR PARA PROBAR DIFERENTES PARÁMETROS
function probar_diferentes_parametros()
    figure('Position', [200, 200, 1000, 600], 'Name', 'Comparación de Diferentes Parámetros');

    % Parámetros base
    h = 0.01; t_final = 30; pasos = round(t_final/h);
    x0 = 1; y0 = 1; z0 = 1;

    % Diferentes valores de r (Rayleigh)
    r_valores = [14, 28, 100];  % Subcrítico, caótico, hipercaótico
    colores = ['r', 'b', 'g'];

    for idx = 1:length(r_valores)
        r_actual = r_valores(idx);

        % Resolver sistema
        [x_vec, y_vec, z_vec] = resolver_lorenz_euler(x0, y0, z0, 10, r_actual, 8/3, h, pasos);

        % Graficar
        plot3(x_vec, y_vec, z_vec, colores(idx), 'LineWidth', 1.5, ...
              'DisplayName', sprintf('r = %.0f', r_actual));
        hold on;
    end

    grid on;
    xlabel('x'); ylabel('y'); zlabel('z');
    title('Atractor de Lorenz para Diferentes Valores de r');
    legend('show', 'Location', 'best');
    view(-37.5, 30);
end

function [x_vec, y_vec, z_vec] = resolver_lorenz_euler(x0, y0, z0, sigma, r, b, h, pasos)
    % Función auxiliar que implementa el método de Euler explícito

    % Inicializar
    x = x0; y = y0; z = z0;
    x_vec = zeros(pasos+1, 1);
    y_vec = zeros(pasos+1, 1);
    z_vec = zeros(pasos+1, 1);

    x_vec(1) = x; y_vec(1) = y; z_vec(1) = z;

    % Definir ecuaciones
    dxdt = @(x, y, z) -sigma * (y - x);
    dydt = @(x, y, z) x * (r - z) - y;
    dzdt = @(x, y, z) x * y - b * z;

    % Euler explícito
    for i = 1:pasos
        % Calcular velocidades (derivadas)
        vx = dxdt(x, y, z);
        vy = dydt(x, y, z);
        vz = dzdt(x, y, z);

        % Actualizar variables
        x = x + vx * h;
        y = y + vy * h;
        z = z + vz * h;

        % Guardar
        x_vec(i+1) = x;
        y_vec(i+1) = y;
        z_vec(i+1) = z;
    end
end

%% EJECUTAR COMPARACIÓN (descomenta si quieres ver diferentes parámetros)
% probar_diferentes_parametros();

fprintf('\n=== GRÁFICOS GENERADOS ===\n');
fprintf('1. Tiempo vs Velocidad del Fluido:\n');
fprintf('   • Muestra cómo evoluciona la intensidad del movimiento horizontal\n');
fprintf('   • Comportamiento caótico característico de la convección\n\n');
fprintf('2. Temperatura Vertical vs Temperatura Horizontal:\n');
fprintf('   • Diagrama de fase de las variaciones térmicas\n');
fprintf('   • Revela los patrones de intercambio de calor\n');
fprintf('   • Las flechas indican la dirección del flujo térmico\n\n');
fprintf('3. Vista 3D del Sistema Completo:\n');
fprintf('   • Atractor de Lorenz en el espacio de estados completo\n');
fprintf('   • Combina velocidad del fluido y ambas temperaturas\n\n');

fprintf('=== SIMULACIÓN COMPLETADA ===\n');
fprintf('El modelo representa la convección atmosférica con comportamiento caótico.\n');
fprintf('Los gráficos muestran la dinámica no lineal del sistema de fluidos.\n');
