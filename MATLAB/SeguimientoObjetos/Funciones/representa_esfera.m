function representa_esfera(centro, Radio)
    [X,Y,Z] = sphere(100);
    
    Xc = centro(1);
    Yc = centro(2);
    Zc = centro(3);

    x = Radio*X(:)+Xc;
    y = Radio*Y(:)+Yc;
    z = Radio*Z(:)+Zc;
    hold on;
    plot3(x,y,z, '.y');

end