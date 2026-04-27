clear, close all, clc;

load("01_Generacion_del_material\FramesVideo.mat", "FramesVideo");

%Extraccion del fondo

ImagenesFondo = FramesVideo(:,:,:,[1 5 10]);

DatosFondo = zeros(0,3,"uint8");

for i = 1 : 3
    Ib = roipoly(ImagenesFondo(:,:,:,i));
    R = ImagenesFondo(:,:,1, i);
    G = ImagenesFondo(:,:,2, i);
    B = ImagenesFondo(:,:,3, i);

    DatosFondo = [DatosFondo ; R(Ib), G(Ib), B(Ib)];
end

save("02_Extraer_RepresentarDatos\VariablesGeneradas\Fondo.mat", "DatosFondo");

% Extraccion del color

ImagenesColor = FramesVideo(:,:,:,[28:3:140]);
n = size(ImagenesColor, 4);

DatosColor = zeros(0,3, "uint8");

for i = 1:n
    R = ImagenesColor(:,:, 1, i);
    G = ImagenesColor(:,:, 2, i);
    B = ImagenesColor(:,:, 3, i);

    Ib = roipoly(ImagenesColor(:,:,:,i));
    
    DatosColor = [ DatosColor ; R(Ib), G(Ib), B(Ib)];
end

save("02_Extraer_RepresentarDatos\VariablesGeneradas\DatosColor.mat", "DatosColor")


% Generar X e Y

DatosColor = unique(DatosColor, "rows");
DatosFondo = unique(DatosFondo, "rows");

nFondo = size(DatosFondo, 1);
nColor = size(DatosColor, 1);

Y0 = zeros(nFondo, 1, "uint8");
Y1 = ones(nColor, 1, "uint8");
Y = [Y0 ; Y1];
X = [ DatosFondo ; DatosColor];



save("02_Extraer_RepresentarDatos\conjunto_original.mat", "X", "Y");

% Representacion de los datos

FoI = Y == 0;

plot3(X(FoI,1), X(FoI,2), X(FoI, 3), "*r");

hold on;

FoI = Y == 1;
plot3(X(FoI,1), X(FoI,2), X(FoI, 3), "*b");
xlabel("Rojo");
ylabel("Verde");
zlabel("Azul");
legend("Fondo", "Colores");

hold off;

% Eliminacion de los valores atipicos

addpath("02_Extraer_RepresentarDatos\funciones\");

posOutliersColor = funcion_detecta_outliers(X,Y,1);

FoI = Y == 1;

Color = X(FoI,:);

posNoOuliers = posOutliersColor == 0;

Xo = Color(posNoOuliers,:);

Yo = ones(size(Xo, 1), 1);

FoI = Y == 0;
Fondo = X(FoI, :);

Yfondo = zeros(size(Fondo,1),1);

Y = [Yo ; Yfondo];
X = [Xo ; Fondo];

save("02_Extraer_RepresentarDatos\conjunto_modificado.mat","X","Y");

% Representacion de los datos

FoI = Y == 0;

plot3(X(FoI,1), X(FoI,2), X(FoI, 3), "*r");

hold on;

FoI = Y == 1;
plot3(X(FoI,1), X(FoI,2), X(FoI, 3), "*b");
xlabel("Rojo");
ylabel("Verde");
zlabel("Azul");
legend("Fondo", "Colores");

hold off;


