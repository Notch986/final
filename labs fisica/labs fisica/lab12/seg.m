function automata_celular_2D_juego_de_la_vida()
    % Dimensiones de la malla
    nfs = 50;
    ncs = 50;

    % Crear malla inicial vacía (todos ceros)
    malla = zeros(nfs, ncs);

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

    % Mostrar información del patrón inicial
    fprintf('Patrón inicial insertado en posición central (%d,%d):\n', centro_f, centro_c);
    fprintf('Patrón tetris:\n');
    for i = 1:size(patron, 1)
        for j = 1:size(patron, 2)
            fprintf('%d', patron(i, j));
        end
        fprintf('\n');
    end
    fprintf('\n');

    % Guardar estado inicial en archivo
    fid = fopen('juego_vida_estados.txt', 'w');
    fprintf(fid, 'JUEGO DE LA VIDA - ESTADOS POR GENERACION\n');
    fprintf(fid, '=========================================\n\n');

    % Guardar estado inicial
    fprintf(fid, 'GENERACION 0 (Estado inicial):\n');
    for i = 1:nfs
        for j = 1:ncs
            fprintf(fid, '%d', malla(i, j));
        end
        fprintf(fid, '\n');
    end
    fprintf(fid, '\n');

    % Número de generaciones
    ngen = 3;  % Reducido para debug

    for ng = 1:ngen
        % Mostrar información de debug para la primera iteración
        if ng == 1
            fprintf('DEBUG: Analizando vecinos de posición (1,1)\n');
            vecinos_debug = get_vecinos_debug(malla, 1, 1);
            fprintf('Vecinos de (1,1): %s\n', mat2str(vecinos_debug));
            fprintf('Suma de vecinos: %d\n', sum(vecinos_debug(:)));
            fprintf('Estado actual de (1,1): %d\n\n', malla(1,1));
        end

        % Muestra la malla en pantalla
        imagesc(malla);
        colormap([1 1 1; 0 0 0]); % Blanco para 0, Negro para 1
        axis off;
        title(['Iteración: ', num2str(ng)]);
        pause(0.5);  % Pausa más larga para ver mejor

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

        % Guardar estado actual en archivo
        fprintf(fid, 'GENERACION %d:\n', ng);
        for i = 1:nfs
            for j = 1:ncs
                fprintf(fid, '%d', sgte_malla(i, j));
            end
            fprintf(fid, '\n');
        end
        fprintf(fid, '\n');

        malla = sgte_malla;
    end

    fclose(fid);
    fprintf('Estados guardados en: juego_vida_estados.txt\n');
end

% Función para obtener los vecinos de una célula (CORREGIDA)
function vecinos = get_vecinos(malla, f, c)
    nfs = size(malla, 1);
    ncs = size(malla, 2);

    % Calcular índices de vecinos con bordes toroidales
    f_arriba = mod(f-2, nfs) + 1;
    f_abajo = mod(f, nfs) + 1;
    c_izq = mod(c-2, ncs) + 1;
    c_der = mod(c, ncs) + 1;

    % Extraer vecinos en orden: arriba-izq, arriba-centro, arriba-der,
    % centro-izq, centro-der, abajo-izq, abajo-centro, abajo-der
    vecinos = [
        malla(f_arriba, c_izq),    % Arriba-izquierda
        malla(f_arriba, c),        % Arriba-centro
        malla(f_arriba, c_der),    % Arriba-derecha
        malla(f, c_izq),           % Centro-izquierda
        malla(f, c_der),           % Centro-derecha
        malla(f_abajo, c_izq),     % Abajo-izquierda
        malla(f_abajo, c),         % Abajo-centro
        malla(f_abajo, c_der)      % Abajo-derecha
    ];
end

% Función de debug para mostrar vecinos claramente
function vecinos = get_vecinos_debug(malla, f, c)
    nfs = size(malla, 1);
    ncs = size(malla, 2);

    fprintf('DEBUG: Posición analizada: (%d,%d)\n', f, c);
    fprintf('DEBUG: Dimensiones malla: %dx%d\n', nfs, ncs);

    % Calcular índices con información de debug
    f_arriba = mod(f-2, nfs) + 1;
    f_abajo = mod(f, nfs) + 1;
    c_izq = mod(c-2, ncs) + 1;
    c_der = mod(c, ncs) + 1;

    fprintf('DEBUG: Índices calculados:\n');
    fprintf('  f_arriba = %d, f_abajo = %d\n', f_arriba, f_abajo);
    fprintf('  c_izq = %d, c_der = %d\n', c_izq, c_der);

    % Mostrar la submatriz 3x3 alrededor del punto
    fprintf('DEBUG: Submatriz 3x3 alrededor de (%d,%d):\n', f, c);
    submatriz = [
        malla(f_arriba, c_izq), malla(f_arriba, c), malla(f_arriba, c_der);
        malla(f, c_izq), malla(f, c), malla(f, c_der);
        malla(f_abajo, c_izq), malla(f_abajo, c), malla(f_abajo, c_der)
    ];
    disp(submatriz);

    % Extraer solo los vecinos (sin el centro)
    vecinos = [
        malla(f_arriba, c_izq),    % Arriba-izquierda
        malla(f_arriba, c),        % Arriba-centro
        malla(f_arriba, c_der),    % Arriba-derecha
        malla(f, c_izq),           % Centro-izquierda
        malla(f, c_der),           % Centro-derecha
        malla(f_abajo, c_izq),     % Abajo-izquierda
        malla(f_abajo, c),         % Abajo-centro
        malla(f_abajo, c_der)      % Abajo-derecha
    ];
end

% Función adicional para crear archivo más legible
function crear_archivo_legible(malla, generacion)
    filename = sprintf('generacion_%02d.txt', generacion);
    fid = fopen(filename, 'w');

    fprintf(fid, 'Generación %d\n', generacion);
    fprintf(fid, '============\n\n');

    % Usar . para 0 y # para 1 para mejor visualización
    for i = 1:size(malla, 1)
        for j = 1:size(malla, 2)
            if malla(i, j) == 1
                fprintf(fid, '#');
            else
                fprintf(fid, '.');
            end
        end
        fprintf(fid, '\n');
    end

    fclose(fid);
end
