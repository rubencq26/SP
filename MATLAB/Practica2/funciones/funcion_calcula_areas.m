function areas = funcion_calcula_areas(IEtiq)
    N = max(IEtiq(:));

    areas = zeros(1,N);

    for i=1:N 
        Ib = IEtiq == i;
        areas(i) = sum(Ib(:));
    end

end