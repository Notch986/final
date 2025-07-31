function automata_celular_2D_regla110()
    % Dimensiones de la malla
    nfs = 21;  % filas de la cruz
    ncs = 22;  % columnas de la cruz

    % Condición inicial: Cruz
    malla = [ ...
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

    % Número de generaciones
    ngen = 1;

    for ng = 1:ngen
        % Mostrar la malla actual
        imagesc(malla);
        colormap([1 1 1; 0 0 0]); % Blanco = 0, Negro = 1
        axis equal off;
        title(['Generación: ', num2str(ng)]);
        pause(0.5);

        % Calcular la siguiente generación usando Regla 110
        sgte_malla = zeros(nfs, ncs);
        for i = 1:nfs
            for j = 1:ncs
                % Vecinos (torus: frontera periódica)
                izq = malla(i, mod(j-2, ncs)+1);
                cen = malla(i, j);
                der = malla(i, mod(j, ncs)+1);

                % Determinar el nuevo valor según la tabla Regla 110
                if izq==0 && cen==0 && der==0
                    sgte_malla(i,j) = 0; % 000 -> 0
                elseif izq==0 && cen==0 && der==1
                    sgte_malla(i,j) = 1; % 001 -> 1
                elseif izq==0 && cen==1 && der==0
                    sgte_malla(i,j) = 1; % 010 -> 1
                elseif izq==0 && cen==1 && der==1
                    sgte_malla(i,j) = 1; % 011 -> 1
                elseif izq==1 && cen==0 && der==0
                    sgte_malla(i,j) = 0; % 100 -> 0
                elseif izq==1 && cen==0 && der==1
                    sgte_malla(i,j) = 1; % 101 -> 1
                elseif izq==1 && cen==1 && der==0
                    sgte_malla(i,j) = 1; % 110 -> 1
                elseif izq==1 && cen==1 && der==1
                    sgte_malla(i,j) = 0; % 111 -> 0
                end
            end
        end
        malla = sgte_malla; % Actualizar malla
    end
end
