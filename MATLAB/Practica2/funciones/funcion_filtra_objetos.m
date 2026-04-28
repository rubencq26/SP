function IbFilt = funcion_filtra_objetos (Ib , numPix)
    Ib = Ib > 0;
    IEtiq = funcion_etiquetar(Ib,8);
    IbFilt = Ib;
    N = max(IEtiq(:));

    areas = funcion_calcula_areas(IEtiq);

    for i = 1 : N
        if areas(i) < numPix;
            Ic = IEtiq == i;
            IbFilt(Ic) = 0;
        end
    end

end