function automata_celular_2D_juego_de_la_vida()
    % Dimensiones de la malla
    nfs = 50;
    ncs = 50;
        malla = zeros(nfs,ncs)
    malla = randi([0, 1], nfs, ncs);
    % numero de generaciones
    ngen = 50;

    for ng=1:ngen
        % Muestra la malla
        imagesc(malla);
        colormap([1 1 1; 0 0 0]); % Blanco para 0, Negro para 1
        axis off;
        title(['Iteración: ', num2str(ng)]);
        pause(0.1);
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
        malla = sgte_malla;
    end
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
