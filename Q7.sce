// Réponse à la question 7

exec("Q3_Factorisation_Cholesky.sce"); 
exec("Q5_Remontee_Cholesky.sce"); 
exec("Q4_Descente_Cholesky.sce"); 

// Calcul des C(x)
// n : nombre de pas => pas de discrétisation = (2*l)/(n+1)
// l longueur de l'intervalle / 2
l = 10; 

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

function [result_equa_diff] = equa_diff(n)
    result_equa_diff = zeros(n, 1); 
    
    for i = 1:n
        // On calcule le résultat de l'équation différentielle pour chaque pas
        result_equa_diff(i) = - (exp(1)/(exp(-1)-exp(1))) + (1/(exp(-1)-exp(1)))*exp((-l + i*(2*l)/(n+1))/l)
    end
endfunction

n = 1000; 
vecteur_C = calcul_C(n);
B = zeros(n, 1);
B(1) = vecteur_C(1);

[res_calc1, res_calc2] = calcul_A(n);
[res_fact1, res_fact2] = factorise(res_calc1, res_calc2);
result_descente = descente(res_fact1, res_fact2, B); 
result_remonte =  remonte(res_fact1, res_fact2, result_descente)

//disp(result_remonte)
result_equa = equa_diff(n)
//plot(result_remonte)
//plot(result_equa)

i = 2; 
j = 2; 
result = zeros(20, 1)
result_i = zeros(20, 1)

while j < 20
    n = i;
    vecteur_C = calcul_C(n);
    B = zeros(n, 1);
    B(1) = vecteur_C(1);
    
    [res_calc1, res_calc2] = calcul_A(n);
    [res_fact1, res_fact2] = factorise(res_calc1, res_calc2);
    result_descente = descente(res_fact1, res_fact2, B); 
    result_remonte =  remonte(res_fact1, res_fact2, result_descente);
    
    result_equa = equa_diff(n);
    result(j) = norm(result_remonte - result_equa, 'inf'); 
    
    i = i + i; 
    disp(i)
    j = j+1;
end

//disp(result)
plot(result)
