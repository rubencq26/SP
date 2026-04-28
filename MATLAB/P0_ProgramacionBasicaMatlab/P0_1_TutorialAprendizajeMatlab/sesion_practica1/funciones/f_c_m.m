function var = f_c_m(m1,m2)
    if all(size(m1) == size(m2))

        d = m1(:)-m2(:)
        vMin = min(d); vMax = max(d);
        
        if vMin==vMax && vMin==0
            var = true;
            clc,disp("Matrices iguales")
        else
            var = false;
            clc, disp("Matrices diferentes")

        end

    else
        var = false;
        clc, disp("Matrices diferentes dimension")

    end

end