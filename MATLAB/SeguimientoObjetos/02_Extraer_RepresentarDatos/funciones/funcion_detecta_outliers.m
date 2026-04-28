function posOutliers = funcion_detecta_outliers(X, Y, posClaseInteres)
    FoI = Y == posClaseInteres; 

    PosColor = X(FoI,:);
    R = PosColor(:,1);
    G = PosColor(:,2);
    B = PosColor(:,3);

    R = double(R);
    G = double(G);
    B = double(B);

    % componente roja
    Rs = sort(R);
    

    Q1R = Rs(round( 0.25 * length(R)));
    

    Q3R = Rs(round( 0.75 * length(R)));
    

    RiR = Q3R - Q1R;
    

    FoIR = R < Q1R -1.5 *RiR | R > Q3R + 1.5 * RiR;
    
    % componente verde

    MediaG = mean(G);

    DesvG = std(G);

    FoIG  = G < MediaG -2.5 * DesvG | G > MediaG + 2.5 * DesvG;

    % componente azul

    MediaB = mean(B);

    DesvB = std(B);

    FoIB = B <= MediaB - 3 * DesvB;

    posOutliers = FoIR == 1 | FoIG == 1 | FoIB == 1;

    

end
