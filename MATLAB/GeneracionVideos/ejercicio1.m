    %% EJERCICIO 1: REPETIR EJEMPLO ANTERIOR PERO ALMACENAR
    % TAMBIÉN EN UN ARCHIO VIDEO LA SECUENCIA DE ENTRADA. AL
    % TRABAJAR CON FRAMES DE INTENSIDAD, LA SECUENCIA DE ENTRADA
    % DEBE ALMACENAR ÚNICAMENTE FRAMES DE INTENSIDAD
    %% GUARDAR DE FORMA AUTOMATICA (sin utilizar WriteVideo)
    % LA SECUENCIA CAPTURA DE VIDEO (VIDEO DE ENTRADA)
    % PARA ELLO, DEBEMOS ES CONFIGURAR EL OBJETO VÍDEO
    % DE CONFIGURACIÓN DE LA WEBCAM, PARA QUE, ADEMÁS DE
    % EN MEMORIA, SE ALMACENEN LOS FRAMES CAPTURADOS, EN
    % UN OBJETO ARCHIVO DE VÍDEO. FORMA DE HACERLO:
    % - Modo de Almacenamiento en memoria y disco
     % video.LoggingMode = "disk&memory";
    % - Especificar el archivo de video donde se deben
    % almacenar los frames en el DiskLogger
     % video.DiskLogger= aviobj;
    % DEBEMOS TENER EN CUENTA:
    % Aunque el campo ReturnedColorSpace esté configuraro como 'Grayscale',
    % los frames que captura la cámara tienen tres canales
    % Si queremos guardar estos frames de forma automática, debemos
    % utilizar un archivo de video cuyo formato de salida esté preparado
    % para contener esos 3 canales.
    % POR TANTO:
    % SOLO PODEMOS GUARDAR SECUENCIAS DE VIDEO DE ENTRADA RGB.
    % AUNQUE LA CAPTURA SEA EN OTRO MODELO DE COLOR (YUY, POR EJEMPLO),
    % EL ARCHIVO DE VIDEO SE GENERA EN RGB SI ASÍ LO INDICAMOS
    % EN LA CREACIÓN DEL OBJETO
    % ADEMÁS LAS SECUENCIAS SE GRABAN EN LA RESOLUCIÓN ORIGINAL DE CAPTURA
    
    
    clear, close all, clc;
    
    video = videoinput('winvideo', 1, 'YUY2_640x480');
    
    fpsMaximaWebCam = 30;
    fpsTrabajoWebCam = 15;
    
    video.FrameGrabInterval = round(fpsMaximaWebCam/fpsTrabajoWebCam);
    video.TriggerRepeat = 0;
    video.FramesPerTrigger = Inf;
    
    video.LoggingMode = "disk&memory";
    
    
    nombre = 'Ejercicio1.avi';
    ruta = ['./videoGenerados/' nombre];
    formatoVideo = 'Motion JPEG AVI';
    
    aviobjOut = VideoWriter(ruta, formatoVideo);
    
    video.DiskLogger = aviobjOut;
    
    duracionGrabacion = round(100/fpsTrabajoWebCam);
    
    open(aviobjOut);
    nFrames = duracionGrabacion * fpsTrabajoWebCam;
    
    start(video);
    for i = 1 : nFrames
        I = imresize(getdata(video,1), 0.5);
    
    end
    
    stop(video);
    
    close(aviobjOut);
    
    implay(ruta);