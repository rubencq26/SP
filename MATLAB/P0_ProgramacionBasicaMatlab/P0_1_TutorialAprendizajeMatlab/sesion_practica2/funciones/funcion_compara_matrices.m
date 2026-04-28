function var = funcion_compara_matrices(m1, m2)

    m1 = double(m1); m2 = double(m2);
    [nF1, nC1] = size(m1);
    [nF2, nC2] = size(m2);

    if nF1==nF2 & nC1 == nC2

        dif = m1-m2;
        vMin = min(dif(:)); vMax = max(dif(:));
        
        if vMin==vMax & vMin==0
            var = true;
            disp('matrices iguales')
        else
            var = false;
            disp('matrices diferentes')
        end





    else
        var = false;
        disp('matrices diferentes por distinta dimension')



    end




end