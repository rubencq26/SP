clear, close all, clc

video = videoinput('winvideo', 1, 'YUY2_640x480');


video.FramesPerTrigger = Inf;
video.TriggerRepeat = 0;
video.ReturnedColorSpace = 'rgb';


fpsMaximaWebCam = 30;

fpsTrabajoWebCam = 15;

video.FrameGrabInterval = round(fpsMaximaWebCam/fpsTrabajoWebCam);

nombre = 'Ejemplo1.avi';
ruta = ['./videoGenerados/' nombre];

formatoVideo = 'Motion JPEG AVI';

aviobjOut = VideoWriter(ruta, formatoVideo);

aviobjOut.FrameRate = fpsTrabajoWebCam;

duracionGrabacion = 100/fpsTrabajoWebCam;

numFramesGrabacion = duracionGrabacion*fpsTrabajoWebCam;
open(aviobjOut)

start(video);

for i = 1:numFramesGrabacion
    I = imresize(getdata(video,1), 0.5);
    writeVideo(aviobjOut,I);
end


stop(video);

close(aviobjOut);
implay(ruta);
