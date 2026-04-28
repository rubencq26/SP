% Ejercicio 1. - Visualice una secuencia RGB de video a 10 fps que muestre:
% 1.1.- La escena aclarándose hasta hacerse blanca por completo (el mínimo valor de nivel de
% gris de los píxeles de cualquier canal es 255); posteriormente, la escena debe oscurecerse
% hasta hacerse negra (el máximo valor es 0). Para ello, la manipulación del brillo de los frames
% deber realizarse sumando o restando valores enteros en el rango [0,255] con pasos de unidad. 


clear all, clc, close all

video=videoinput('winvideo',1,'YUY2_640x480'); 


video.TriggerRepeat = 0;

video.FrameGrabInterval = 3;

video.FramesPerTrigger = Inf;

video.ReturnedColorSpace = "rgb";

N = 0;

seguir = true;
start(video);

while seguir
    I = getdata(video,1);

    I = I + N;

    imshow(I);
    Ib = I < 255;

    if sum(Ib(:)) == 0
        seguir = false;
    end  
    N = N + 1;
end

seguir = true;

while seguir
    I = getdata(video,1);
    I = I + N;

    imshow(I);
    Ib = I > 0;

    if sum(Ib(:)) == 0
        seguir = false;
    end  
    N = N - 1;

end

stop(video);
close all;

