clear; clf; hold off;

% Tamaño del autómata
c = 150;

% Configurar el gráfico
axis([0 c 0 c]);
set(gca, "xtick", [], "ytick", []);
title('Autómata celular - Regla 110 (Forma de Cruz)');

% Inicialización de vectores y matriz de evolución
acel = zeros(1, c);
bcel = zeros(1, c);
mcel = zeros(c, c);

% FOR 1: Generar 3 valores aleatorios y mostrarlos
fprintf('Los 3 valores aleatorios generados son:\n');
for i = 1:3
    valor_aleatorio = round(rand);
    fprintf('Valor %d: %d\n', i, valor_aleatorio);
end

% FOR 2: Generar estado inicial aleatorio completo (0s y 1s)
for i = 1:c
    acel(i) = round(rand);
end

hold on;

% FOR 3: Evolución del autómata (explicativo)
fprintf('\nEvolución del autómata con Regla 110:\n');
for j = 1:c
    % Guardar fila actual en la matriz
    mcel(j, :) = acel;

    % Calcular siguiente generación
    for i = 1:c
        % Vecinos con condiciones de frontera periódicas
        l = i - 1;
        r = i + 1;
        if l < 1, l = c; end
        if r > c, r = 1; end

        % Crear patrón de 3 bits (izquierda, centro, derecha)
        patron = acel(l) * 4 + acel(i) * 2 + acel(r);

        % Aplicar Regla 110: 01101110 en binario
        % Patrones: 111=0, 110=1, 101=1, 100=0, 011=1, 010=1, 001=1, 000=0
        switch patron
            case 7  % 111
                bcel(i) = 0;
            case 6  % 110
                bcel(i) = 1;
            case 5  % 101
                bcel(i) = 1;
            case 4  % 100
                bcel(i) = 0;
            case 3  % 011
                bcel(i) = 1;
            case 2  % 010
                bcel(i) = 1;
            case 1  % 001
                bcel(i) = 1;
            case 0  % 000
                bcel(i) = 0;
        end
    end

    % Preparar siguiente iteración
    acel = bcel;

    % Mostrar progreso cada 50 generaciones
    if mod(j, 50) == 0
        fprintf('Generación %d completada\n', j);
    end
end

% Dibujar la cruz usando fors según las especificaciones
fprintf('\nDibujando la forma de cruz...\n');
for j = 1:c  % Recorrer filas (vertical)
    for k = 1:c  % Recorrer columnas (horizontal)
        % Verificar si estamos en la zona de la cruz
        dibujar = false;

        % Cabeza de la cruz: columnas 50-100, filas 1-50
        if j >= 1 && j <= 50 && k >= 50 && k <= 100
            dibujar = true;
        end

        % Brazos horizontales: columnas 1-150, filas 51-100
        if j >= 51 && j <= 100 && k >= 1 && k <= 150
            dibujar = true;
        end

        % Parte inferior: columnas 50-100, filas 101-150
        if j >= 101 && j <= 150 && k >= 50 && k <= 100
            dibujar = true;
        end

        % Dibujar solo si está en la zona de la cruz y la celda está activa
        if dibujar && mcel(j, k) == 1
            plot(k, c - j + 1, '.k');  % Punto negro (invertir j para mostrar correctamente)
        end
    end
end

fprintf('Autómata celular completado con forma de cruz\n');
