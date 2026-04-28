clear, close all, clc
addpath("01_Generacion_del_material\MaterialGenerado\")

aviObjOut = VideoReader("video.avi");

FramesVideo = uint8(zeros(aviObjOut.Height, aviObjOut.Width, 3, aviObjOut.NumFrames));

FramesVideo = read(aviObjOut, [1 inf]);

save("FramesVideo.mat", "FramesVideo");


