clear; clf; hold off;

% Tamaño del autómata (máximo 20x20)
c = 20;

% Configurar el gráfico
axis([0 c 0 c]);
set(gca, "xtick", [], "ytick", []);

% Inicialización
acel = zeros(1, c);
bcel = zeros(1, c);
mcel = zeros(c, c);

% Generar estado inicial aleatorio
for i = 1:c
    acel(i) = round(rand);
end

% FASE 1: Evolución con regla 110 modificada para generar "cabeza"
fprintf('Generando cabeza de cruz con regla 110 modificada...\n');

% Regla optimizada para formar cuadrados/rectángulos (cabeza de cruz)
rule_cabeza = [1 0 1 1 0 1 1 0];

hold on;
j = c;

while j > 0
    mcel(c - j + 1, :) = acel;

    for i = 1:c
        l = i - 1;
        r = i + 1;
        if l < 1, l = c; end
        if r > c, r = 1; end

        config = acel(l)*4 + acel(i)*2 + acel(r)*1;
        bcel(i) = rule_cabeza(config + 1);
    end

    for k = 1:c
        if bcel(k) == 1
            plot(k, j, '.k');
        end
    end

    acel = bcel;
    j = j - 1;
end

% FASE 2: Crear cruz por rotación de la cabeza específica
fprintf('Aplicando rotación perpendicular de la cabeza para formar cruz completa...\n');

% Definir la "cabeza" específica exacta
cabeza = [
    0 1 1 1 0;
    0 1 0 1 0
];

[filas_cabeza, cols_cabeza] = size(cabeza);
centro = round(c/2);

% Crear matriz final para la cruz
cruz_final = zeros(c, c);

% Función para rotar matriz 90 grados en sentido horario
function matriz_rotada = rotar90(matriz)
    [f, c] = size(matriz);
    matriz_rotada = zeros(c, f);
    for i = 1:f
        for j = 1:c
            matriz_rotada(j, f+1-i) = matriz(i, j);
        end
    end
end

% Generar las 4 rotaciones de la cabeza
cabeza_0 = cabeza;                    % Original
cabeza_90 = rotar90(cabeza_0);        % 90°
cabeza_180 = rotar90(cabeza_90);      % 180°
cabeza_270 = rotar90(cabeza_180);     % 270°

% COLOCAR CABEZA 0° (ARRIBA)
offset = 3;
pos_i = centro - offset - size(cabeza_0, 1);
pos_j = centro - round(size(cabeza_0, 2)/2);
if pos_i >= 1 && pos_i + size(cabeza_0, 1) - 1 <= c && pos_j >= 1 && pos_j + size(cabeza_0, 2) - 1 <= c
    for i = 1:size(cabeza_0, 1)
        for j = 1:size(cabeza_0, 2)
            cruz_final(pos_i + i - 1, pos_j + j - 1) = cabeza_0(i, j);
        end
    end
end

% COLOCAR CABEZA 90° (DERECHA)
pos_i = centro - round(size(cabeza_90, 1)/2);
pos_j = centro + offset;
if pos_i >= 1 && pos_i + size(cabeza_90, 1) - 1 <= c && pos_j >= 1 && pos_j + size(cabeza_90, 2) - 1 <= c
    for i = 1:size(cabeza_90, 1)
        for j = 1:size(cabeza_90, 2)
            cruz_final(pos_i + i - 1, pos_j + j - 1) = max(cruz_final(pos_i + i - 1, pos_j + j - 1), cabeza_90(i, j));
        end
    end
end

% COLOCAR CABEZA 180° (ABAJO)
pos_i = centro + offset;
pos_j = centro - round(size(cabeza_180, 2)/2);
if pos_i >= 1 && pos_i + size(cabeza_180, 1) - 1 <= c && pos_j >= 1 && pos_j + size(cabeza_180, 2) - 1 <= c
    for i = 1:size(cabeza_180, 1)
        for j = 1:size(cabeza_180, 2)
            cruz_final(pos_i + i - 1, pos_j + j - 1) = max(cruz_final(pos_i + i - 1, pos_j + j - 1), cabeza_180(i, j));
        end
    end
end

% COLOCAR CABEZA 270° (IZQUIERDA)
pos_i = centro - round(size(cabeza_270, 1)/2);
pos_j = centro - offset - size(cabeza_270, 2);
if pos_i >= 1 && pos_i + size(cabeza_270, 1) - 1 <= c && pos_j >= 1 && pos_j + size(cabeza_270, 2) - 1 <= c
    for i = 1:size(cabeza_270, 1)
        for j = 1:size(cabeza_270, 2)
            cruz_final(pos_i + i - 1, pos_j + j - 1) = max(cruz_final(pos_i + i - 1, pos_j + j - 1), cabeza_270(i, j));
        end
    end
end

% Mostrar las rotaciones generadas para debug
fprintf('Cabeza original:\n');
disp(cabeza_0);
fprintf('Cabeza 90°:\n');
disp(cabeza_90);
fprintf('Cabeza 180°:\n');
disp(cabeza_180);
fprintf('Cabeza 270°:\n');
disp(cabeza_270);

% Refinar la cruz aplicando una vez más la regla 110
fprintf('Refinando la cruz con regla 110...\n');
cruz_refinada = zeros(c, c);

for i = 1:c
    for j = 1:c
        if j == 1
            izq = c;
        else
            izq = j - 1;
        end

        if j == c
            der = 1;
        else
            der = j + 1;
        end

        config = cruz_final(i, izq)*4 + cruz_final(i, j)*2 + cruz_final(i, der)*1;

        % Aplicar regla 110 original para refinamiento
        rule_110 = [0 1 1 1 0 1 1 0];
        cruz_refinada(i, j) = rule_110(config + 1);
    end
end

% Mostrar solo la imagen final
figure;
imshow(cruz_refinada, 'InitialMagnification', 'fit');
title('Cruz formada por rotación perpendicular de cabeza (Regla 110)');
colormap([1 1 1; 0 0 0]);

fprintf('Cruz de %dx%d generada por rotación perpendicular\n', c, c);
fprintf('Basada en regla 110: [0 1 1 1 0 1 1 0]\n');

% Mostrar información del proceso
fprintf('\nProceso realizado:\n');
fprintf('1. Generación de cabeza con regla modificada\n');
fprintf('2. Rotación perpendicular en 4 orientaciones\n');
fprintf('3. Combinación para formar cruz completa\n');
fprintf('4. Refinamiento final con regla 110 pura\n');
