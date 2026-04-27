function conteo = funcion_histograma(I)
    % 1. Convertir a gris haciendo la media de los canales
    % Usamos double para evitar saturación en la suma antes de dividir
    im = uint8(mean(double(I), 3));
    
    % 2. Inicializar el vector de 256 posiciones
    conteo = zeros(1, 256);
    
    % 3. El Bucle corregido
    for i = 0:255
        % El índice debe ser i + 1 porque en MATLAB no existe la posición 0
        conteo(i + 1) = sum(im(:) == i);
    end
    
    % 4. Representación gráfica
    figure;
    % Eje X: niveles de 0 a 255. Eje Y: el vector de conteo.
    stem(0:255, conteo, 'Marker', 'none'); 
    
    title('Histograma de la imagen');
    xlabel('Nivel de Intensidad');
    ylabel('Número de Píxeles');
end