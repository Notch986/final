% FUNCIÓN DE DIEGO - AUTÓMATA CELULAR (MÉTODO 1: Análisis por a₋₁)
clear, clf, hold off
c = 150;
axis([0 c 0 c])

% Inicialización correcta
acel = zeros(1, c);  % Inicializar como vector
bcel = zeros(1, c);  % Inicializar como vector

for i = 1:c
    acel(i) = round(rand);
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

        if acel(l) == 0          % Si célula izquierda es 0
            bcel(i) = 1;         % Siempre activa
        else                     % Si célula izquierda es 1
            if acel(i) == 1 && acel(r) == 0  % Solo 110
                bcel(i) = 1;
            else
                bcel(i) = 0;
            end
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

% Alternativa para visualizar como imagen:
figure;
imagesc(mcel);
colormap(gray);
xlabel('Posición');
ylabel('Tiempo');
axis image;
