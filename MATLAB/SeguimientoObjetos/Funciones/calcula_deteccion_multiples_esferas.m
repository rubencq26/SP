function Ib = calcula_deteccion_multiples_esferas(I , centroidesRadios)
    nCentroides = size(centroidesRadios, 1);
    [nFila, nCol, nDim, nImagenes] = size(I);

    Ib = zeros(nFila, nCol, 'logical');

    for i = 1 : nCentroides
        CR = centroidesRadios(i, :);
         
        
        
        Mat = calcula_deteccion_1esfera(I, CR);
        Ib = Ib + Mat;
       
    end

end