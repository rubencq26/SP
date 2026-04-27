function Ib = calcula_deteccion_1esfera(I, centroidesRadio)

 
    Id = double(I);

    Ce = reshape(centroidesRadio(1:3), 1, 1,3);
    R = centroidesRadio(4);
    dist_sq = sum((Id - Ce).^2, 3);
    DistanciaFrameActual = sqrt(dist_sq);

    Ib = DistanciaFrameActual < R;
end