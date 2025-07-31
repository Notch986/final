% REGLA 156 - AUTÓMATA CELULAR CORREGIDO PARA OCTAVE
clear, clf, hold off
c = 150;
axis([0 c 0 c])
% Inicialización correcta
acel = zeros(1, c);  % Inicializar como vector
bcel = zeros(1, c);  % Inicializar como vector
patron = [1 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0];
patron_rep = repmat(patron, 1, ceil(c/length(patron)));
for i = 1:c
    acel(i) = patron_rep(i);
end
hold on;
j = c;
mcel = zeros(c, c);
while j > 0
    mcel(c-j+1, :) = acel;
    for i = 1:c
        l = i - 1;
        r = i + 1;
        if l < 1
            l = c;
        end
        if r > c
            r = 1;
        end
        suma = acel(l) + acel(i) + acel(r);
        switch suma
            case 0
                bcel(i) = 0;  % 000 → 0
            case 1
                bcel(i) = 0;  % 001, 010 → 0
                if acel(i) == 0
                    bcel(i) = 1;  % 100 → 1
                end
            case 2
                bcel(i) = 1;  % 011, 110 → 1
                if acel(l) == 1 && acel(r) == 1
                    bcel(i) = 0;  % 101 → 0
                end
            case 3
                bcel(i) = 1;  % 111 → 1
        end
    end
    for k = 1:c
        if bcel(k) == 1
            plot(k, j, '.k');
        end
    end
    acel = bcel;
    j = j - 1;
end
% Mostrar matriz final
mcel;
% Generar imagen (opcional - comentado porque puede no funcionar en todas las versiones)
% Imagen = mat2gray(mcel);
% imshow(Imagen);
% Alternativa para visualizar como imagen:
figure;
imagesc(mcel);
colormap(gray);
title('Regla 156 - Autómata Celular');
xlabel('Posición');
ylabel('Tiempo');
axis image;
