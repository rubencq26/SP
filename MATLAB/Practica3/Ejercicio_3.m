
close all, clear, clc;

video = videoinput("winvideo");

video.FrameGrabInterval = 4;
video.TriggerRepeat = 0;
video.FramesPerTrigger = Inf;

video.ReturnedColorSpace = "rgb";

start(video);
cW = 11;
cH = cW;

finVideo = 7*8;
I = getdata(video,1);
[W,H,P] = size(I);
vMin = 1+ floor(cW/2);
vMax = W - floor(cW/2);
valoresX = round( vMin+(vMax-vMin) *rand(finVideo,1) );
vMax = H-floor(cW/2);
valoresY = round( vMin+(vMax-vMin)*rand(finVideo,1) );


for i=1:finVideo
    I = getdata(video,1);

    if P == 1
        R = I;
        G = I;
        B = I;

    else
        R = I(:,:,1);
        G = I(:,:,2);
        B = I(:,:,3);
        
    end

       wMitad = floor(cW/2);
       fila = valoresX(i);
       col = valoresY(i);
       R(fila - wMitad:fila+wMitad, col-wMitad:col+wMitad) = 255;
       G(fila - wMitad:fila+wMitad, col-wMitad:col+wMitad) = 0;
       B(fila - wMitad:fila+wMitad, col-wMitad:col+wMitad) = 0;
       Im = cat(3, R, G, B);
       imshow(Im);
end

stop(video);
close all;

