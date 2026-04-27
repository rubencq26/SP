function centroides = funcion_calcula_centroides(IEtiq)
    
    N = max(IEtiq(:));
    % Inicializamos: N objetos, cada uno con [X, Y]
    centroides = zeros(N, 2); 
    
    for i = 1 : N
        Ib = (IEtiq == i);
        
        % find devuelve [filas, columnas]
        [filas, cols] = find(Ib);
        
        if ~isempty(filas)
            % IMPORTANTE: 
            % La coordenada X es el promedio de las COLUMNAS
            % La coordenada Y es el promedio de las FILAS
            centroides(i, 1) = round(mean(cols)); % X
            centroides(i, 2) = round(mean(filas)); % Y
        end
    end
end