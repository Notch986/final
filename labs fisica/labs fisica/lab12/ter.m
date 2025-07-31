function automata_celular_2D_juego_de_la_vida()
    % Dimensiones de la malla
    nfs = 50;
    ncs = 50;
    malla = zeros(nfs,ncs);
    % Insertar solo la célula central activa (semilla inicial)
    malla(25, 25) = 1;
    % numero de generaciones
    ngen = 50;
    for ng=1:ngen
        % Muestra la malla
        imagesc(malla);
        colormap([1 1 1; 0 0 0]); % Blanco para 0, Negro para 1
        axis off;
        title(['Regla 2460 - Iteración: ', num2str(ng)]);
        pause(0.1);
        % Calcular la siguiente generación
        sgte_malla = zeros(nfs, ncs);
        for i = 1:nfs
            for j = 1:ncs
                % Contar vecinos vivos
                vecinos = get_vecinos(malla, i, j);
                num_vecinos = sum(vecinos(:));

                % REGLA 2460:
                if malla(i, j) == 1  % Célula viva
                    if num_vecinos == 2 || num_vecinos == 4
                        sgte_malla(i, j) = 1;  % Sobrevive con 2 o 4 vecinos
                    else
                        sgte_malla(i, j) = 0;  % Muere en otros casos
                    end
                else  % Célula muerta
                    if num_vecinos == 6
                        sgte_malla(i, j) = 1;  % Nace con exactamente 6 vecinos
                    else
                        sgte_malla(i, j) = 0;  % Permanece muerta
                    end
                end
            end
        end
        malla = sgte_malla;
    end
end

% Función para obtener los vecinos de una célula
function vecinos = get_vecinos(malla, f, c)
    nfs = size(malla, 1);
    ncs = size(malla, 2);

    % Calcular índices de los 8 vecinos con bordes toroidales
    vecinos = [
        malla(mod(f-2, nfs)+1, mod(c-2, ncs)+1),  % (f-1, c-1) - arriba izquierda
        malla(mod(f-2, nfs)+1, mod(c-1, ncs)+1),  % (f-1, c)   - arriba centro
        malla(mod(f-2, nfs)+1, mod(c, ncs)+1),    % (f-1, c+1) - arriba derecha
        malla(mod(f-1, nfs)+1, mod(c-2, ncs)+1),  % (f, c-1)   - centro izquierda
        malla(mod(f-1, nfs)+1, mod(c, ncs)+1),    % (f, c+1)   - centro derecha
        malla(mod(f, nfs)+1, mod(c-2, ncs)+1),    % (f+1, c-1) - abajo izquierda
        malla(mod(f, nfs)+1, mod(c-1, ncs)+1),    % (f+1, c)   - abajo centro
        malla(mod(f, nfs)+1, mod(c, ncs)+1)       % (f+1, c+1) - abajo derecha
    ];
end
