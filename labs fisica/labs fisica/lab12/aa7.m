function automata_celular_2D_juego_de_la_vida()
    % Dimensiones de la malla
    nfs = 50;
    ncs = 50;

    % Crear malla inicial vacía (todos ceros)
    malla = zeros(nfs,ncs);

    % Insertar patrón inicial en el centro (bloque tetris)
    % Patrón centrado en (25,25):
    % 0100
    % 0110
    % 0010
    centro_f = 25;
    centro_c = 25;

    % Definir el patrón del bloque tetris
    patron = [0 1 0 0;
              0 1 1 0;
              0 0 1 0];

    % Insertar el patrón en la malla
    for i = 1:size(patron, 1)
        for j = 1:size(patron, 2)
            fila = centro_f - 2 + i;  % Ajustar para centrar el patrón
            columna = centro_c - 2 + j;
            if fila >= 1 && fila <= nfs && columna >= 1 && columna <= ncs
                malla(fila, columna) = patron(i, j);
            end
        end
    end

    % Mostrar patrón inicial
    fprintf('Patrón inicial (bloque tetris) en posición (%d,%d):\n', centro_f, centro_c);
    for i = 1:size(patron, 1)
        for j = 1:size(patron, 2)
            fprintf('%d', patron(i, j));
        end
        fprintf('\n');
    end
    fprintf('\n');

    % Guardar estado inicial en archivo
    fid = fopen('juego_vida_una_iteracion.txt', 'w');
    fprintf(fid, 'JUEGO DE LA VIDA - UNA ITERACION\n');
    fprintf(fid, '================================\n\n');

    % Guardar estado inicial
    fprintf(fid, 'ESTADO INICIAL:\n');
    for i = 1:nfs
        for j = 1:ncs
            fprintf(fid, '%d', malla(i, j));
        end
        fprintf(fid, '\n');
    end
    fprintf(fid, '\n');

    % numero de generaciones (solo 1)
    ngen = 3;

    for ng=1:ngen
        % Muestra la malla inicial
        figure(1);
        imagesc(malla);
        colormap([1 1 1; 0 0 0]); % Blanco para 0, Negro para 1
        axis off;
        title('Estado Inicial - Patrón Tetris');
        pause(2); % Pausa para ver el estado inicial

        % Calcular la siguiente generación
        sgte_malla = zeros(nfs, ncs);

        for i = 1:nfs
            for j = 1:ncs
                % Contar vecinos vivos
                vecinos = get_vecinos(malla, i, j);
                num_vecinos = sum(vecinos(:));

                if malla(i, j) == 1 % Célula viva
                    if num_vecinos < 2 || num_vecinos > 3
                        sgte_malla(i, j) = 0; % Muere por soledad o sobrepoblación
                    else
                        sgte_malla(i, j) = 1; % Vive
                    end
                else % Célula muerta
                    if num_vecinos == 3
                        sgte_malla(i, j) = 1; % Nace por reproducción
                    end
                end
            end
        end

        % Mostrar resultado después de una iteración
        figure(2);
        imagesc(sgte_malla);
        colormap([1 1 1; 0 0 0]); % Blanco para 0, Negro para 1
        axis off;
        title('Después de 1 Iteración');

        % Guardar estado después de una iteración
        fprintf(fid, 'DESPUES DE 1 ITERACION:\n');
        for i = 1:nfs
            for j = 1:ncs
                fprintf(fid, '%d', sgte_malla(i, j));
            end
            fprintf(fid, '\n');
        end
        fprintf(fid, '\n');

        % Mostrar información de las células que cambiaron
        cambios = sum(sum(malla ~= sgte_malla));
        fprintf('Número de células que cambiaron: %d\n', cambios);
        fprintf(fid, 'Numero de celulas que cambiaron: %d\n', cambios);

        malla = sgte_malla;
    end

    fclose(fid);
    fprintf('Estados guardados en: juego_vida_una_iteracion.txt\n');
end

% Función para obtener los vecinos de una célula
function vecinos = get_vecinos(malla, f, c)
    nfs = size(malla, 1);
    ncs = size(malla, 2);
    vecinos = [
        malla(mod(f-2, nfs)+1, mod(c-2, ncs)+1),
        malla(mod(f-2, nfs)+1, mod(c-1, ncs)+1),
        malla(mod(f-2, nfs)+1, mod(c,   ncs)+1),
        malla(mod(f-1, nfs)+1, mod(c-2, ncs)+1),
        malla(mod(f-1, nfs)+1, mod(c,   ncs)+1),
        malla(mod(f,   nfs)+1, mod(c-2, ncs)+1),
        malla(mod(f,   nfs)+1, mod(c-1, ncs)+1),
        malla(mod(f,   nfs)+1, mod(c,   ncs)+1)
    ];
end
