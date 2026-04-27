function datosEsfera = calcula_datos_esfera(XColor, XFondo)
    
    addpath("03_Diseño_Clasificador_Esferas\");
    C = mean(XColor);

    distanciaColor =  calcula_distancia_punto_a_nube_puntos(C', XColor');

    R1 = max(distanciaColor);

    distanciaFondo = calcula_distancia_punto_a_nube_puntos(C', XFondo');

    R2 = min(distanciaFondo);

    R = mean([R1 R2]);
    
    datosEsfera = [ C, R];
end