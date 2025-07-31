function automata_celular_2D_juego_de_la_vida()
    % Dimensiones de la malla
    nfs = 100;
    ncs = 100;
    malla = zeros(nfs,ncs);

    % Insertar solo la célula central activa (semilla de Sierpinski)
    malla(50, 50) = 1;

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

                % célula se activa si vecinos es IMPAR
                if mod(num_vecinos, 2) == 1  % Si número de vecinos es impar
                    sgte_malla(i, j) = 1;    % Se activa
                else                         % Si número de vecinos es par
                    sgte_malla(i, j) = 0;    % Se desactiva
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
