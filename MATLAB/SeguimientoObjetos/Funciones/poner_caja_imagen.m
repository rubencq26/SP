function Ic = poner_caja_imagen(I, Cx, Cy, nX, Color)

    
    
    
    Col = reshape(Color, 1, 1, 3);

    Wmitad = floor(nX/2);
    Ic = I;
    Ic(Cx-Wmitad:Cx+Wmitad, Cy-Wmitad:Cy+Wmitad) = Col;
end