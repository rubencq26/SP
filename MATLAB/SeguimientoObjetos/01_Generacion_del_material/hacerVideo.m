
clear, close all, clc;

video = videoinput("winvideo", 1, "YUY2_640x480");

video.ReturnedColorSpace = 'rgb';

fpsMaximaWebCam = 30;
fpsTrabajoWebCam = 7;

video.FrameGrabInterval = round(fpsMaximaWebCam/fpsTrabajoWebCam);
video.FramesPerTrigger = Inf;
video.TriggerRepeat;

nombre = 'video.avi';
ruta = ['01_Generacion_del_material/MaterialGenerado/' nombre];

aviobjOut = VideoWriter(ruta, "Motion JPEG AVI");
aviobjOut.FrameRate = fpsTrabajoWebCam;


numSegundos = 20;

duracionGrabacion = numSegundos * fpsTrabajoWebCam;

open(aviobjOut);

start(video);


for i = 1 : duracionGrabacion
    I = imresize(getdata(video,1), 0.5);
    writeVideo(aviobjOut, I);
end

close(aviobjOut);

stop(video);

implay(ruta);



