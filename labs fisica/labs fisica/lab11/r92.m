% FUNCIÓN DE DIEGO - AUTÓMATA CELULAR CORREGIDO PARA OCTAVE
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

        % TU FUNCIÓN: φ(a₋₁, a₀, a₁) = ā₋₁ā₀a₁ + ā₋₁ā₁ + a₀ā₁ + ā₋₁a₀
        % Resultado: 11110010₂ = 243₁₀

        suma = acel(l) + acel(i) + acel(r);

        switch suma
            case 0          % 000 → 1
                bcel(i) = 1;
            case 1          % 001→1, 010→1, 100→0
                if acel(l) == 1  % 100
                    bcel(i) = 0;
                else  % 001 o 010
                    bcel(i) = 1;
                end
            case 2          % 011→1, 101→0, 110→1
                if acel(l) == 1 && acel(r) == 1  % 101
                    bcel(i) = 0;
                else  % 011 o 110
                    bcel(i) = 1;
                end
            case 3          % 111 → 0
                bcel(i) = 0;
        end
    end  % ¡ESTE END FALTABA!

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
