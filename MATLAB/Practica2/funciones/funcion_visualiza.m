function Io = funcion_visualiza(Ii, Ib, Color, flagRepresenta)
    [nF1, nC1, nP] = size(Ii);
    [nF2, nC2] = size(Ib);
    

    if nargin == 3
        flagRepresenta = false;
    end
    
    if nF1 ~= nF2 | nC1 ~= nC2 | length(Color) ~= 3
        Io = Ii;
        return;
    end

    Ib = Ib > 0;
    
    Ii = uint8(Ii);
    Color = uint8(Color);

    if nP == 1
        R = Ii
        G = Ii
        B = Ii
    else
        R = Ii(:,:,1);
        G = Ii(:,:,2);
        B = Ii(:,:,3);
    end
    
    R(Ib) = Color(1);
    G(Ib) = Color(2);
    B(Ib) = Color(3);
    
    Io = cat(3,R,G,B);

    if flagRepresenta
        figure, imshow(Io)
    end





end