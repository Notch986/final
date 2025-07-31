clear; clf; hold off;

% Constantes
mu0 = 4*pi*1e-7;  % permeabilidad del vacío
I = 1;            % corriente en Amperes

% Parámetros del alambre
x = -5:0.1:5;     % posiciones en x donde calcular el campo
a = 1;            % distancia perpendicular al alambre (distancia mínima)

% Solo 2 longitudes de alambre para comparar
L_values = [5, 100];  % alambre corto vs largo
colores = ['r', 'b'];

figure(1);
hold on;

for k = 1:length(L_values)
    L = L_values(k);  % longitud actual del alambre
    
    B_campo = zeros(size(x));  % inicializar campo magnético
    
    for i = 1:length(x)
        % Geometría: alambre de -L/2 a +L/2, punto de observación en (x(i), a)
        
        % Ángulos theta1 y theta2 desde los extremos del alambre
        % theta1: ángulo desde extremo izquierdo (-L/2, 0) al punto (x(i), a)
        % theta2: ángulo desde extremo derecho (+L/2, 0) al punto (x(i), a)
        
        % Vectores desde extremos del alambre al punto de observación
        r1_x = x(i) - (-L/2);  % componente x del vector r1
        r1_y = a;              % componente y del vector r1
        r1 = sqrt(r1_x^2 + r1_y^2);  % magnitud de r1
        
        r2_x = x(i) - (+L/2);  % componente x del vector r2  
        r2_y = a;              % componente y del vector r2
        r2 = sqrt(r2_x^2 + r2_y^2);  % magnitud de r2
        
        % Senos de los ángulos
        sen_theta1 = r1_y / r1;  % sen(theta1) = componente perpendicular / hipotenusa
        sen_theta2 = r2_y / r2;  % sen(theta2) = componente perpendicular / hipotenusa
        
        % Determinar signos según la posición
        if r1_x < 0
            sen_theta1 = -sen_theta1;
        end
        if r2_x > 0
            sen_theta2 = -sen_theta2;
        end
        
        % Ley de Biot-Savart para segmento finito
        B_campo(i) = (mu0 * I / (4*pi*a)) * (sen_theta1 - sen_theta2);
    end
    
    % Graficar
    plot(x, B_campo*1e6, colores(k), 'LineWidth', 2, 'DisplayName', sprintf('L = %g m', L));
end

% Campo magnético teórico para alambre infinito
B_infinito = (mu0 * I / (2*pi*a)) * ones(size(x));
plot(x, B_infinito*1e6, 'k--', 'LineWidth', 3, 'DisplayName', 'Alambre Infinito');

xlabel('Posición x (m)');
ylabel('Campo Magnético B (μT)');
title('Campo Magnético vs Longitud del Alambre');
legend('show', 'Location', 'best');
grid on;

% Gráfica 2: Visualización del campo vectorial
figure(2);
clear; clf; hold off;

xa = -3:0.3:3;
ya = 0.5:0.3:3;
[x_grid, y_grid] = meshgrid(xa, ya);

% Solo 2 longitudes para simulación vectorial
L_sim = [5, 100];  % longitudes para simulación vectorial

for subplot_idx = 1:2
    subplot(1,2,subplot_idx);
    
    L = L_sim(subplot_idx);
    
    Bx_total = zeros(size(x_grid));
    By_total = zeros(size(x_grid));
    
    for i = 1:numel(x_grid)
        x_obs = x_grid(i);
        y_obs = y_grid(i);
        
        % Evitar puntos muy cerca del alambre
        if abs(y_obs) < 0.1
            continue;
        end
        
        % Calcular campo usando Biot-Savart
        r1_x = x_obs - (-L/2);
        r1_y = y_obs;
        r1 = sqrt(r1_x^2 + r1_y^2);
        
        r2_x = x_obs - (+L/2);
        r2_y = y_obs;
        r2 = sqrt(r2_x^2 + r2_y^2);
        
        sen_theta1 = r1_y / r1;
        sen_theta2 = r2_y / r2;
        
        if r1_x < 0, sen_theta1 = -sen_theta1; end
        if r2_x > 0, sen_theta2 = -sen_theta2; end
        
        % Campo magnético (solo componente perpendicular al plano)
        B_mag = (mu0 * I / (4*pi*abs(y_obs))) * (sen_theta1 - sen_theta2);
        
        % Dirección del campo (tangencial, usando regla mano derecha)
        Bx_total(i) = -B_mag * sign(y_obs);  % componente x
        By_total(i) = 0;                     % componente y (alambre en x)
    end
    
    quiver(x_grid, y_grid, Bx_total*1e6, By_total*1e6, 'b');
    hold on;
    
    % Dibujar el alambre
    plot([-L/2, L/2], [0, 0], 'r-', 'LineWidth', 4);
    
    title(sprintf('L = %g m', L));
    xlabel('x (m)'); ylabel('y (m)');
    axis equal; grid on;
    xlim([-3 3]); ylim([0 3]);
end

sgtitle('Campo Magnético para Diferentes Longitudes de Alambre');

% Información
fprintf('Parámetros:\n');
fprintf('Corriente I = %.1f A\n', I);
fprintf('Distancia perpendicular a = %.1f m\n', a);
fprintf('μ₀ = %.2e H/m\n', mu0);