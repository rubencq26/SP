% Ejercicio3:
% a) Genera dos matrices A y B, 5x5, de números enteros aleatorios entre 0 y 10
A = round(10*rand(5,5)); B = round(10*rand(5,5));
media = mean(A(B>5))

% b) Calcula la media de los valores de A en aquellos puntos donde B es > 5
media = mean(A(B>5))