function IEtiq = funcion_etiquetar(Ib, conn)
    Ib = Ib > 0;
    [nF, nC] = size(Ib);
    % Añadir marco de ceros para evitar problemas de bordes
    Ic = double(zeros(nF + 2, nC + 2));
    Ic(2:end-1, 2:end-1) = Ib;
    
    % Inicialización de etiquetas únicas
    contador = 1;
    for i = 2:nC+1
        for j = 2:nF+1
            if Ic(j,i) == 1
                Ic(j,i) = contador;
                contador = contador + 1;
            end
        end
    end
    
    cambio = true;
    while cambio
        cambio = false;
        
        % Barrido hacia adelante (Top-Left a Bottom-Right)
        for i = 2:nC+1
            for j = 2:nF+1
                if Ic(j,i) > 0
                    if conn == 4
                        V = [Ic(j,i-1), Ic(j-1,i), Ic(j,i)];
                    else
                        V = [Ic(j-1:j+1, i-1)', Ic(j-1,i), Ic(j,i)];
                    end
                    v_min = min(V(V > 0));
                    if Ic(j,i) ~= v_min
                        Ic(j,i) = v_min;
                        cambio = true;
                    end
                end
            end
        end
        
        % Barrido hacia atrás (Bottom-Right a Top-Left) con paso -1
        for i = nC+1 : -1 : 2
            for j = nF+1 : -1 : 2
                if Ic(j,i) > 0
                    if conn == 4
                        V = [Ic(j,i+1), Ic(j+1,i), Ic(j,i)];
                    else
                        V = [Ic(j-1:j+1, i+1)', Ic(j+1,i), Ic(j,i)];
                    end
                    v_min = min(V(V > 0));
                    if Ic(j,i) ~= v_min
                        Ic(j,i) = v_min;
                        cambio = true;
                    end
                end
            end
        end
    end

    % Reetiquetado final y quitar marco
    Ic = Ic(2:end-1, 2:end-1);
    V_unicos = unique(Ic(Ic > 0));
    IEtiq = zeros(size(Ic));
    for iter = 1:length(V_unicos)
        IEtiq(Ic == V_unicos(iter)) = iter;
    end
end