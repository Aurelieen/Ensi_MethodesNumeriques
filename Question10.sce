  // programme pour la question 10

exec("Q3_Factorisation_Cholesky.sce"); 
exec("Q5_Remontee_Cholesky.sce"); 
exec("Q4_Descente_Cholesky.sce"); 
exec("Q7.sce"); 

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

// Calcul de la matrice M
function [result_matrice_M_diag, result_matrice_M_inf] = matrice_M(n, theta, mu)
    [diag_sup_A, diag_inf_A] = calcul_A(n); 
    result_matrice_M_inf = zeros(n, 1); 
    result_matrice_M_diag = zeros(n, 1);
    
    for i = 1:n-1
        result_matrice_M_diag(i) = diag_sup_A(i) * theta * mu + 1;
        result_matrice_M_inf(i) = diag_inf_A(i) * theta * mu;
    end 
    
    result_matrice_M_diag(n) = diag_sup_A(n) * theta * mu + 1;
    
endfunction

// Calcul de la matrice N
function [result_matrice_N] = matrice_N(n, theta, mu)
    [diag_sup_A, diag_inf_A] = calcul_A(n); 
    result_matrice_N = zeros(n, n); 
    
    for i = 1:n-1
        result_matrice_N(i, i) = diag_sup_A(i) * (theta - 1) * mu + 1;
        result_matrice_N(i+1, i) = diag_inf_A(i) * (theta - 1) * mu;
        result_matrice_N(i, i+1) = diag_inf_A(i) * (theta - 1) * mu;
    end 
    
    result_matrice_N(n, n) = diag_sup_A(n) * (theta - 1) * mu + 1;
    
endfunction

// Calcul de B
function[result_B] = calcul_B (n, u0, k, deltaT, theta)
    result_C = calcul_C(n); 
    result_B = zeros(n, 1); 
    result_B(1) = result_C(1) //*(calcul_fonction_vecteur(u0, k+1) * deltaT * theta + calcul_fonction_vecteur(u0, k) * deltaT * (1 - theta)); 
    
endfunction

function [result] = calcul_fonction_vecteur(vecteur, reel)
    result = 0; 
    for i = 1:length(vecteur)
        result = result+vecteur(i)*reel
    end
endfunction

//u0 donnée initiale, vecteur de taille n. 
// theta, mu constantes.
// n nombre d'itérations.

n = 5;  
u0 = zeros(n, 1);
u0(1) = 1;  
theta = 0.5; 
l = 5; 

// Calcul du tk
T = 10; 
k = 12; 
deltaT = (n+1)/T; 
mu = deltaT /(2*l/(n+1))
result = zeros(k, 1); 

for j = 1:k
    for i = 1:n
        [m_diag, m_inf] = matrice_M(n, theta, mu);
        [m_factorise_diag, m_factorise_inf] = factorise(m_diag, m_inf); 
        membre_gauche = matrice_N(n, theta, mu) * u0 + mu * calcul_B(n, u0, j, deltaT, theta); 
        resultat_descente = descente(m_factorise_diag, m_factorise_inf, calcul_B(n, u0, j, deltaT, theta)); 
        resultat_remonte = remonte(m_factorise_diag, m_factorise_inf, calcul_B(n, u0, j, deltaT, theta));
        u0 = resultat_remonte;
    end
    disp(u0);
    result(j) = u0(1);
end

disp(result); 
plot(result); 
