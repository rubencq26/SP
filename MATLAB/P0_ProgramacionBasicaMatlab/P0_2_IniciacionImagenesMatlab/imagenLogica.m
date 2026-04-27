[N,M] = size(I);
Ib = false(size(i));
umbral = 100;

for i=1:N
    for j=1:M
        if(I(i,j)<umbral)
            Ib(i,j) = true;
        end
    end
end
