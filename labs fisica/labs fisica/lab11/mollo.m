% Regla 110: 01101110 en binario (del 7 al 0)
rule = [0 1 1 1 0 1 1 0];
% Condición inicial (cruz con bordes negros)
initial = [ ...
    0 0 0 0 1 1 1 0 0 0 0;
    0 0 0 0 1 0 1 0 0 0 0;
    0 0 0 0 1 0 1 0 0 0 0;
    0 1 1 1 1 0 1 1 1 1 0;
    0 1 0 0 0 0 0 0 0 1 0;
    0 1 1 1 1 0 1 1 1 1 0;
    0 0 0 0 1 0 1 0 0 0 0;
    0 0 0 0 1 0 1 0 0 0 0;
    0 0 0 0 1 1 1 0 0 0 0];
% Dimensiones
[rows, cols] = size(initial);
final = zeros(rows, cols);
% Aplicar regla 110 fila por fila
for r = 1:rows
   for c = 2:cols-1
       pattern = initial(r, c-1)*4 + initial(r, c)*2 + initial(r, c+1);
       final(r, c) = rule(8 - pattern);
   end
end
% Mostrar imagen 1 (condición inicial)
figure;
imshow(initial, 'InitialMagnification', 'fit');
title('Imagen 1: Condición inicial (Cruz)');
colormap([1 1 1; 0 0 0]); % 0: blanco, 1: negro
% Mostrar imagen 2 (resultado regla 110)
figure;
imshow(final, 'InitialMagnification', 'fit');
title('Imagen 2: Resultado aplicando Regla 110');
colormap([1 1 1; 0 0 0]); % 0: blanco, 1: negro
