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
esferas = funcion_kmeans(XCol, XFondo, 20);

for i = 1 : siz(4)
    I = FramesVideo(:,:,:,i);
    
    Mascara2D = calcula_deteccion_multiples_esferas(I, esferas);
    
   
    Ietiq = bwareaopen(Mascara2D, round(NumPix), 8);
    [Ietiq, N] = bwlabel(Ietiq, 8);
    

    Centroides = regionprops(Ietiq, "Centroid");
    
    for j = 1 : N
        Cx = round(Centroides(1).Centroid(1));
        Cy = round(Centroides(1).Centroid(2));
        
     
        rangoY = max(1, Cy-3) : min(siz(1), Cy+3);
        rangoX = max(1, Cx-3) : min(siz(2), Cx+3);
        I(rangoY, rangoX, :) = 255;
     end
    
    
    imshow(I);
    drawnow;
end



%4.2.- Visualizar sobre el frame original todos los píxeles y el centroide de la agrupación con
%mayor número de píxeles. Para visualizar los píxeles se debe utilizar un color que los distinga.
% El centroide debe visualizarse mediante una caja blanca 7x7.

clc, clear, close all;

load("01_Generacion_del_material\FramesVideo.mat");
load("02_Extraer_RepresentarDatos\conjunto_modificado.mat");
load("03_Diseño_Clasificador_Esferas\centroradio.mat");
load("03_Diseño_Clasificador_Esferas\umbral_conectividad.mat");

addpath("Funciones\");

siz = size(FramesVideo);

XCol = X(Y==1,:);
XFondo = X(Y==0,:);
esferas = funcion_kmeans(XCol, XFondo, 20);

for i = 1 : siz(4)
    I = FramesVideo(:,:,:,i);
    
    Mascara2D = calcula_deteccion_multiples_esferas(I, esferas);
    
    
    Ietiq = bwlabel(Mascara2D, 8);
    Ietiq = bwareaopen(Ietiq, round(NumPix), 8);

    stats = regionprops(Ietiq, 'Area');
    if ~isempty(stats)
        
        [~, Ord] = sort([stats.Area], 'descend');
    
       
        Iet = (Ietiq == Ord(1)); 
    
        
        Centroides = regionprops(Iet, "Centroid");
    
        if ~isempty(Centroides)
            Cx = round(Centroides(1).Centroid(1));
            Cy = round(Centroides(1).Centroid(2));
        
            rangoY = max(1, Cy-3) : min(siz(1), Cy+3);
            rangoX = max(1, Cx-3) : min(siz(2), Cx+3);
            I(rangoY, rangoX, :) = 255;
            
        end
    end
    
    imshow(I);
    drawnow;
end


% 4.3.- Visualizar sobre el frame original las siguientes agrupaciones y centroides:
% − En cian: los píxeles de todas las agrupaciones detectadas. No hay que visualizar ningún centroide.
% − En azul, la agrupación mayor de píxeles y su centroide mediante una caja blanca 7x7.
% − En verde: la segunda agrupación mayor de píxeles y su centroide mediante una caja blanca 7x7.
clc, clear, close all;

load("01_Generacion_del_material\FramesVideo.mat");
load("02_Extraer_RepresentarDatos\conjunto_modificado.mat");
load("03_Diseño_Clasificador_Esferas\centroradio.mat");
load("03_Diseño_Clasificador_Esferas\umbral_conectividad.mat");

addpath("Funciones\");

siz = size(FramesVideo);

XCol = X(Y==1,:);
XFondo = X(Y==0,:);
esferas = funcion_kmeans(XCol, XFondo, 20);

for i = 1 : siz(4)
    I = FramesVideo(:,:,:,i);
    %cian
    Mascara2D = calcula_deteccion_multiples_esferas(I, esferas);
    Ib = logical(Mascara2D);
    
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);

    R(Ib) = 0;
    G(Ib) = 255;
    B(Ib) = 255;
    
    I = cat(3,R,G,B);
    % azul
    Ietiq = bwlabel(Ib, 8);
    stats = regionprops(Ietiq, 'Area');
      if ~isempty(stats)
        
        [~, Ord] = sort([stats.Area], 'descend');
        Iet = (Ietiq == Ord(1)); 
        if size(Ord,1) > 1
            Iet2 = (Ietiq == Ord(2)); 
        end
        Centroides = regionprops(Iet, "Centroid");
        
        R = I(:,:,1);
        G = I(:,:,2);
        B = I(:,:,3);

        R(Iet) = 0;
        G(Iet) = 0;
        B(Iet) = 255;
        if size(Ord,1) > 1
            R(Iet2) = 0;
            G(Iet2) = 255;
            B(Iet2) = 0;
        end
        

    
        I = cat(3,R,G,B);

        if ~isempty(Centroides)
            Cx = round(Centroides(1).Centroid(1));
            Cy = round(Centroides(1).Centroid(2));
        
            rangoY = max(1, Cy-3) : min(siz(1), Cy+3);
            rangoX = max(1, Cx-3) : min(siz(2), Cx+3);
            I(rangoY, rangoX, :) = 255;
            
        end
      end

    
    imshow(I);
    drawnow;
end


