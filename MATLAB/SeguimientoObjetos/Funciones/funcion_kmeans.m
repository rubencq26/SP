function esferas = funcion_kmeans(XCo, XFondo, N)
    
    XCol = double(XCo);
    nXCol = size(XCol,1);
    
    
    esferas = zeros(N, 4, 'double');
    esferasNuevas = zeros(N, 4, 'double');
    
    
    for i = 1 : N
        idx = randi(nXCol);
        esferasNuevas(i, 1:3) = XCol(idx, :);
    end
    
    
    while any(esferasNuevas(:) ~= esferas(:))
        
        esferas = esferasNuevas;
        
        
        Index = zeros(nXCol, 2, 'double');
        
        
        for i = 1 : N
            for j = 1 : nXCol
                dist = sqrt((esferas(i, 1) - XCol(j, 1))^2 + ...
                            (esferas(i, 2) - XCol(j, 2))^2 + ...
                            (esferas(i, 3) - XCol(j, 3))^2 );
                
                if i == 1
                    Index(j,1) = 1;
                    Index(j,2) = dist;
                else
                    if dist < Index(j, 2)
                        Index(j, 1) = i;
                        Index(j, 2) = dist;
                    end
                end
            end
        end
        
        
        for i = 1 : N
            Mb = Index(:,1) == i;
            if any(Mb)
                esferasNuevas(i, 1:3) = round(mean(XCol(Mb, :), 1));
            else
                % Si una esfera se queda huérfana, le damos un nuevo color aleatorio
                esferasNuevas(i, 1:3) = XCol(randi(nXCol), :);
            end
        end
    end
    
    % 3. CÁLCULO DE RADIOS (DISTANCIA AL FONDO)
    % Usamos esferasNuevas porque es la que tiene los centros finales tras el while
    for i = 1 : N
        distanciaFondo = calcula_distancia_punto_a_nube_puntos(esferasNuevas(i, 1:3)', XFondo');
        esferasNuevas(i, 4) = min(distanciaFondo(:));
    end
    
    esferas = esferasNuevas; % Devolvemos el resultado final
end