% 4.1  Visualizar sobre el frame original los centroides de las agrupaciones que tengan el número
%mínimo de píxeles dado por el umbral de conectividad. El centroide debe visualizarse mediante
%una caja blanca 7x7.

clc, clear, close all;

load("01_Generacion_del_material\FramesVideo.mat");
load("02_Extraer_RepresentarDatos\conjunto_modificado.mat");
load("03_Diseño_Clasificador_Esferas\centroradio.mat");
load("03_Diseño_Clasificador_Esferas\umbral_conectividad.mat");

addpath("Funciones\");

siz = size(FramesVideo);

XCol = X(Y==1,:);
XFondo = X(Y==0,:);
esferas = funcion_kmeans(XCol, XFondo, 8);

for i = 1 : siz(4)
    I = FramesVideo(:,:,:,i);
    
    Mascara2D = calcula_deteccion_multiples_esferas(I, esferas);
    
    % Filtrar por conectividad
    Ietiq = bwlabel(Mascara2D, 8);
    Ietiq = bwareaopen(Ietiq, round(NumPix), 8);

    stats = regionprops(Ietiq, 'Area');
    if ~isempty(stats)
        % 1. Ordenamos las áreas de mayor a menor
        % Ord(1) nos da el número de etiqueta del objeto con más área
        [~, Ord] = sort([stats.Area], 'descend');
    
        % 2. Filtramos la imagen de etiquetas para quedarnos SOLO con el más grande
        % Buscamos los píxeles cuyo valor de etiqueta sea Ord(1)
        Iet = (Ietiq == Ord(1)); 
    
        % 3. Ahora sacamos el centroide de esta nueva máscara limpia
        Centroides = regionprops(Iet, "Centroid");
    
        if ~isempty(Centroides)
            Cx = round(Centroides(1).Centroid(1));
            Cy = round(Centroides(1).Centroid(2));
        
            % Dibujar caja 7x7
            rangoY = max(1, Cy-3) : min(siz(1), Cy+3);
            rangoX = max(1, Cx-3) : min(siz(2), Cx+3);
            I(rangoY, rangoX, 1) = 255;
            I(rangoY, rangoX, 2:3) = 0;
        end
    end
    
    imshow(I);
    drawnow;
end


