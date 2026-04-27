% Ejercicio 2.- Visualice una secuencia de video de 100 frames a una tasa de 5 fps que muestre
% las siguientes cuatro representaciones de forma simultánea en una misma ventana tipo figure
% (utiliza subplot con una configuración de dos filas y dos columnas de gráficas):
% - Gráfica 1.- Frames de entrada: deben ser las imágenes capturadas de intensidad
% - Gráfica 2.- Frames de imagen diferencia en valor absoluto entre los distintos frames
% de intensidad consecutivos que captura la webcam (utilizar la instrucción imabsdiff
% para hacer la diferencia entre el frame actual y el adquirido previamente).
% - Gráfica 3.- Frames de imagen de intensidad de entrada donde se muestren en azul
% todos los píxeles cuyas diferencias de intensidad sean significativas (considerar un
% umbral de 75 para establecer de diferencias de intensidad significativas). En caso de
% no detectarse movimiento significativo, debe mostrar únicamente el frame de entrada.
% - Gráfica 4.- Frames de intensidad de entrada con el centroide (asterisco de color rojo)
% de la agrupación mayor de píxeles conectados de las diferencias de intensidad
% significativas. En caso de no detectarse movimiento significativo, el centroide debe
% situarse en la posición (x,y) = (1,1). 

close all, clear, clc;

video = videoinput("winvideo");

video.FrameGrabInterval = 6;
video.TriggerRepeat = 0;
video.FramesPerTrigger = Inf;

video.ReturnedColorSpace = "grayscale";

start(video);
I2a = getdata(video,1);

for i=1:100

    I1 = getdata(video,1);
    subplot(2,2,1);
    imshow(I1);

    I2 = imabsdiff(I2a, I1);
    subplot(2,2,2);
    imshow(I2);
    I2a = I1;
    
    Ib = I2 > 75;
    R = I1;
    G = I1;
    B = I1;
    R(Ib) = 0;
    G(Ib) = 0;
    B(Ib) = 255;
    I3 = cat(3,R,G,B);
    subplot(2,2,3);
    imshow(I3);
    
    subplot(2,2,4);
    imshow(I1); 
    hold on; % Para poder poner el asterisco encima
    
    [IEtiq, N] = bwlabel(Ib, 8);
    
    if N == 0 % Si no se detecta movimiento significativo
        % REQUISITO: El centroide debe situarse en (1,1)
        plot(1, 1, 'r*', 'MarkerSize', 10);
    else
        stats = regionprops(IEtiq, 'Area', 'Centroid');
        
        % Buscamos el de mayor área
        [~, indice] = sort([stats.Area], "descend");
        centroid = stats(indice(1)).Centroid;
        
        % Dibujamos el centroide de la agrupación mayor
        plot(centroid(1), centroid(2), 'r*', 'MarkerSize', 10);
    end
    hold off; % Importante para que el siguiente frame empiece limpio
    
    drawnow;
end

stop(video);
close all;