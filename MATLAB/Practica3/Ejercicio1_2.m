% 1.2.- La escena que se captura modificada para mostrar en azul todos los píxeles que tengan
% una intensidad menor que un determinado umbral. Este umbral irá variando para cada frame
% de la siguiente forma: inicialmente toma el valor 0 para ir aumentándolo progresivamente su
% valor con pasos de unidad hasta el 255; una vez llegado a 255, el valor del umbral irá
% disminuyendo hasta 0 con pasos de 2 unidades.

close all, clear, clc;

video = videoinput('winvideo', 1, 'YUY2_640x480');



video.ReturnedColorSpace = "rgb";

video.TriggerRepeat = 0;
video.FramesPerTrigger = Inf;
video.FrameGrabInterval = 3;


start(video);

for i=0:255
    I = getdata(video,1);
    I = fliplr(I);
    Isc = rgb2gray(I);
    Ib = Isc <= i;
    
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
    
  
    R(Ib) = 0;
    G(Ib) = 0;
    B(Ib) = 255;
   
    I_mod = cat(3, R, G, B);
    imshow(I_mod); 
    title(i);
end

for i=255:-2:0
    I = getdata(video,1);
    I = fliplr(I);
    Isc = rgb2gray(I);
    Ib = Isc <= i;
    
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
    
  
    R(Ib) = 0;
    G(Ib) = 0;
    B(Ib) = 255;
   
    I_mod = cat(3, R, G, B);
    imshow(I_mod); 
    title(i);
end

stop(video);

close all;
