
// Programme pour la question 11 

exec("Q3_Factorisation_Cholesky.sce"); 
exec("Q5_Remontee_Cholesky.sce"); 
exec("Q4_Descente_Cholesky.sce"); 

// Calcul des valeurs de C
// n taille du vecteur résultat
// Résultat sous forme de vecteur. 
function [vecteur_result] = calcul_C(n)
    vecteur_result = zeros(n+1, 1); 
    
    for i = 1:n+1
        // A chaque fois, on calcul C_{i+1/2}
        vecteur_result(i) = exp(-(-l + i*(2*l)/(n+1))/l);
    end
endfunction

// Creation de la matrice A
// n taille de la matrice A
function [matrice_A_diag, matrice_A_inf] = calcul_A(n)
    matrice_A_diag = zeros(n, 1);
    matrice_A_inf = zeros(n-1, 1);
    vecteur_C = calcul_C(n);
    
    for i = 1:n-1
        // n ajoute les coefficients dans la matrice
        matrice_A_diag(i) = vecteur_C(i) + vecteur_C(i+1);
        matrice_A_inf(i) = -vecteur_C(i+1);
    end
    matrice_A_diag(n-1) = vecteur_C(n-1) + vecteur_C(n);
endfunction

T = 60; 
a = 0.8; 
l = 10; 
n = 2000; 
delta_x = 20/2001; 
n_t = 3000; 
delta_t = 60/3000; 
theta = 1/2; 

t_inter = 2/3 * T;
t_fin = T; 

// TODO; trouver u(x1, t), u(x0, t)
function [result_flux_inter, result_flux_fin] = flux(xd)
    result_C = calcul_C(2); 
    result_flux_inter = calcul_C(1)*()/delta_x - delta_x*t_inter/T^2;
    result_flux_fin = calcul_C(1)*()/delta_x - delta_x*t_fin/T^2;
endfunction
