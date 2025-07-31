clear; clf;
% Regla 110: en formato binario de 8 bits
rule = [0 1 1 1 0 1 1 0];

% Condición inicial: cruz
initial = [ ...
   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0;
   0 0 0 1 1 1 1 1 1 0 0 0 0 1 1 1 1 1 1 0 0 0;
   0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0;
   0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0;
   0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0;
   0 0 0 1 1 1 1 1 1 0 0 0 0 1 1 1 1 1 1 0 0 0;
   0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

% Inicialización de variables
[filas, columnas] = size(initial);
acel = initial;
bcel = zeros(filas, columnas);
mcel = zeros(filas, columnas);  % Para guardar resultado final (opcional)

% Evolución usando Regla 110 con frontera toroidal
for j = 1:filas
    for i = 1:columnas
        % Vecinos de la MISMA fila (no fila anterior)
        izq = i - 1;
        der = i + 1;
        if izq < 1, izq = columnas; end      % Si columna < 1, usa la última (toroidal)
        if der > columnas, der = 1; end     % Si columna > max, usa la primera (toroidal)

        % Obtener el patrón de 3 bits de la MISMA fila
        suma = acel(j, izq)*4 + acel(j, i)*2 + acel(j, der)*1;

        % Aplicar la regla 110
        bcel(j, i) = rule(suma + 1);  % +1 porque MATLAB/Octave indexa desde 1
    end
end

mcel = bcel;  % Guardar el resultado final si se desea

% Mostrar imagen 1: condición inicial
figure;
imshow(initial, 'InitialMagnification', 'fit');
title('Imagen 1: Condición inicial (Cruz)');
colormap([1 1 1; 0 0 0]);  % 0: blanco, 1: negro

% Mostrar imagen 2: resultado aplicando Regla 110
figure;
imshow(mcel, 'InitialMagnification', 'fit');
title('Imagen 2: Resultado aplicando Regla 110 (vecinos misma fila)');
colormap([1 1 1; 0 0 0]);
