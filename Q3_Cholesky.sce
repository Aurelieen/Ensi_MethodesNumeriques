// :::::::::::::::::::::::::::::::::::::::::::::
// ::                                         ::
// ::  Question 3. Factorisation de Cholesky  ::
// ::                                         ::
// :::::::::::::::::::::::::::::::::::::::::::::
funcprot(0)

// Factorisation de Cholesky
// =========================
// Préconditions :
//  - La matrice M est symétrique et définie positive ;
//  - La matrice M est tridiagonale ;
// =========================
// Post-conditions :
//  - La matrice résultat L est bidiagonale (cf. TD5, Exercice 1, question 1) ;
// =========================
//  - "m_diag"      diagonale de la matrice M ;
//  - "m_inf"       sous-diagonale de la matrice M ;
// 
//  + "l_diag"      diagonale de la matrice résultat L ;
//  + "l_inf"       sous-diagonale de la matrice résultat L ;

function [l_diag, l_inf] = factorise(m_diag, m_inf)
    n = length(m_diag);
    l_diag = zeros(n, 1);
    l_inf = zeros(n, 1);
    
    // On utilise la formule de récurrence du TD5 :
    //   L[1, 1] = sqrt(M[1, 1])
    //   L[j + 1, j] = M[j + 1, j]/L[j, j]
    //   L[j + 1, j + 1] = sqrt(M[j + 1, j + 1] - L[j + 1, j]²)
    l_diag(1) = sqrt(m_diag(1));
    
    for j = 2:n
        l_inf(j) = m_inf(j - 1)/l_diag(j - 1);
        l_diag(j) = sqrt(m_diag(j) - l_inf(j) ** 2);
    end
endfunction


// EXEMPLES D'UTILISATION
// Exemple du TD5, Exercice 1, Question 3
// Entrées :
m_diag_td5 = [1, 2, 2, 2, 2];
m_inf_td5 = [-1, -1, -1, -1];
[l_diag_td5, l_inf_td5] = factorise(m_diag_td5, m_inf_td5);

