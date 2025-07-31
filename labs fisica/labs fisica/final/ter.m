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

% Punto medio para segunda condición inicial
mitad = 75;

% FOR 1: Generar primera condición inicial aleatoria (parte superior)
for i = 1:c
    acel(i) = round(rand);  % Primera fila aleatoria
end

% FOR 2: Evolucionar primera parte (filas 1 a 75)
for j = 1:mitad
    mcel(j, :) = acel;  % Guardar generación actual

    % Calcular siguiente generación
    for i = 1:c
        % Determinar vecinos con frontera circular
        l = i - 1;
        r = i + 1;
        if l < 1, l = c; end
        if r > c, r = 1; end

        % Crear patrón de vecindario (3 bits)
        patron = acel(l) * 4 + acel(i) * 2 + acel(r);

        % Aplicar Regla 110: 01101110 binario
        switch patron
            case 7  % 111 -> 0
                bcel(i) = 0;
            case 6  % 110 -> 1
                bcel(i) = 1;
            case 5  % 101 -> 1
                bcel(i) = 1;
            case 4  % 100 -> 0
                bcel(i) = 0;
            case 3  % 011 -> 1
                bcel(i) = 1;
            case 2  % 010 -> 1
                bcel(i) = 1;
            case 1  % 001 -> 1
                bcel(i) = 1;
            case 0  % 000 -> 0
                bcel(i) = 0;
        end
    end

    acel = bcel;  % Actualizar para siguiente iteración
end

% Generar segunda condición inicial aleatoria (parte intermedia)
for i = 1:c
    acel(i) = round(rand);  % Nueva fila aleatoria independiente
end

% Evolucionar segunda parte (filas 76 a 150)
for j = (mitad + 1):c
    mcel(j, :) = acel;  % Guardar generación actual

    % Calcular siguiente generación
    for i = 1:c
        % Determinar vecinos con frontera circular
        l = i - 1;
        r = i + 1;
        if l < 1, l = c; end
        if r > c, r = 1; end

        % Crear patrón de vecindario (3 bits)
        patron = acel(l) * 4 + acel(i) * 2 + acel(r);

        % Aplicar Regla 110: 01101110 binario
        switch patron
            case 7  % 111 -> 0
                bcel(i) = 0;
            case 6  % 110 -> 1
                bcel(i) = 1;
            case 5  % 101 -> 1
                bcel(i) = 1;
            case 4  % 100 -> 0
                bcel(i) = 0;
            case 3  % 011 -> 1
                bcel(i) = 1;
            case 2  % 010 -> 1
                bcel(i) = 1;
            case 1  % 001 -> 1
                bcel(i) = 1;
            case 0  % 000 -> 0
                bcel(i) = 0;
        end
    end

    acel = bcel;  % Actualizar para siguiente iteración
end

hold on;

% FOR 3: Dibujar forma de cruz filtrando las celdas activas
for j = 1:c  % Recorrer filas
    for k = 1:c  % Recorrer columnas
        % Definir regiones de la cruz
        en_cabeza = (j >= 1 && j <= 50 && k >= 50 && k <= 100);
        en_brazos = (j >= 51 && j <= 100 && k >= 1 && k <= 150);
        en_base = (j >= 101 && j <= 150 && k >= 50 && k <= 100);

        % Dibujar si está en cruz y celda activa
        if (en_cabeza || en_brazos || en_base) && mcel(j, k) == 1
            plot(k, c - j + 1, '.k');  % Punto negro
        end
    end
end
