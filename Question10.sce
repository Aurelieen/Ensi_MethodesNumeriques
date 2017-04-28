// programme pour la question 10

exec("Q3_Factorisation_Cholesky.sce"); 
exec("Q5_Remontee_Cholesky.sce"); 
exec("Q4_Descente_Cholesky.sce"); 
exec("Q7.sce"); 

// Calcul de la matrice M
function [result_matrice_M] = matrice_M(n, theta, mu)
    [diag_sup_A, diag_inf_A] = calcul_A(n); 
    result_matrice_M = zeros(n, n); 
    
    for i = 1:n-1
        result_matrice_M(i, i) = diag_sup_A(i) * theta * mu + 1;
        result_matrice_M(i+1, i) = diag_inf_A(i) * theta * mu;
        result_matrice_M(i, i+1) = diag_inf_A(i) * theta * mu;
    end 
    
    result_matrice_M(n, n) = diag_sup_A(n) * theta * mu + 1;
    
endfunction

// Calcul de la matrice N
function [result_matrice_N] = matrice_N(n, theta, mu)
    [diag_sup_A, diag_inf_A] = calcul_A(n); 
    result_matrice_M = zeros(n, n); 
    
    for i = 1:n-1
        result_matrice_M(i, i) = diag_sup_A(i) * (theta - 1) * mu + 1;
        result_matrice_M(i+1, i) = diag_inf_A(i) * (theta - 1) * mu;
        result_matrice_M(i, i+1) = diag_inf_A(i) * (theta - 1) * mu;
    end 
    
    result_matrice_M(n, n) = diag_sup_A(n) * (theta - 1) * mu + 1;
    
endfunction

// Calcul de B
function[result_B] = calcul_B (n, mu, u0)
    result_A = calcul_A(n); 
    result_B = zeros(n, 1); 
    result_B(1) = u0(0) * calcul_A(1); 
    
endfunction

//u0 donnée initiale, vecteur de taille n. 
// theta, mu constantes.
// n nombre d'itérations. 
u0 = ?; 
theta = ?; 
mu = ?; 
n = ?; 

m_factorise = factorise(matrice_M(n, theta, mu)); 
n

for k = 1:nt-1
    u0 = 
    
    
end
