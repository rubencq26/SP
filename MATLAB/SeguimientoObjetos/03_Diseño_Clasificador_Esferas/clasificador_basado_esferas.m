% Clasificador de 1 esfera
clear, close all, clc;

load("02_Extraer_RepresentarDatos\conjunto_modificado.mat");

addpath("03_Diseño_Clasificador_Esferas\");

FoI = Y == 1;
XColor = X(FoI, :);

FoI = Y == 0;
XFondo = X(FoI,:);

datosEsfera = calcula_datos_esfera(XColor, XFondo);

FoI = Y == 0;

plot3(X(FoI,1), X(FoI,2), X(FoI, 3), "*r");

hold on;

FoI = Y == 1;
plot3(X(FoI,1), X(FoI,2), X(FoI, 3), "*b");
xlabel("Rojo");
ylabel("Verde");
zlabel("Azul");
legend("Fondo", "Colores");

C = datosEsfera(1:3);
R = datosEsfera(4);
representa_esfera(C, R);

save("03_Diseño_Clasificador_Esferas\centroradio.mat","C", "R");


% Prueba en video

load("01_Generacion_del_material\FramesVideo.mat");
addpath("Funciones\");

Ib = roipoly(FramesVideo(:,:,:,75));
NumPix = round(0.5 * sum(Ib(:)));

save("03_Diseño_Clasificador_Esferas\umbral_conectividad.mat", "NumPix");

[Filas, Columnas, Canales, nImagenes] = size(FramesVideo)

C_prof = reshape(C,1,1,3);





for i = 1 : nImagenes
    I = FramesVideo(:,:,:,i);

    

    Mascara2D = calcula_deteccion_1esfera(I, [C R]');
    
    Ietiq = bwlabel(Mascara2D,8);

    Ietiq = bwareaopen(Ietiq, NumPix);

    Centroides = regionprops(Ietiq, "Centroid");
    
    imshow(I);
    hold on;
    for k = 1:length(Centroides)
        plot(Centroides(k).Centroid(1), Centroides(k).Centroid(2), "*r");
    end
    hold off;
    drawnow;
end






