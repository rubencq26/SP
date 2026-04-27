function vector_distancia = calcula_distancia_punto_a_nube_puntos(P, NP)
    NP_double = double(NP);
    diferencias_sq = (NP_double - P).^2;
    vector_distancia = sqrt(sum(diferencias_sq, 1));
end