close all, clear, clc;
addpath("funciones\")
addpath("Imagenes\")

I = imread("P1.jpg");
Io = I
I_sin_color = uint8(mean(I,3));

Ib =  I_sin_color <= 25 | I_sin_color >= 230;

IEtiq = funcion_etiquetar(Ib,8);

areas = funcion_calcula_areas(IEtiq);

[areas_sort, orden_original] = sort(areas(:), 1, "descend");
areas_sort = areas_sort';
orden_original = orden_original';


N = length(areas);

if N > 5
    N = 5;
end

centroides = funcion_calcula_centroides(IEtiq);

for i = 1 : N
    pos = orden_original(i);
    
    I3 = IEtiq == pos;
    
    R = Io(:,:,1);
    G = Io(:,:,2);
    B = Io(:,:,3);
    
    R(I3) = 255;
    G(I3) = 0;
    B(I3) = 0;

    

    Io = cat(3,R,G,B);

    
end

figure, imshow(Io);

hold on, plot(centroides(orden_original(1:N), 1), centroides(orden_original(1:N), 2), "*k");





