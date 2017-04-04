// ::::::::::::::::::::::::::::::::::::::::::::::
// ::                                          ::
// ::  Question 4. Descente (Cholesky, suite)  ::
// ::                                          ::
// ::::::::::::::::::::::::::::::::::::::::::::::
funcprot(0)

// Méthode de Cholesky, phase de descente
// ======================================
// Préconditions :
//  - L est une matrice bidiagonale
//  - Y est une matrice-colonne de taille n
// ======================================
// Postconditions :
//  - Z est une matrice-colonne résultat de taille n
// ======================================
//  - "l_diag"      diagonale (taille n) de la matrice L ;
//  - "l_inf"       sous-diagonale (taille n - 1) de la matrice L ;
//  - "y"           membre droit du système Lz = y, matrice-colonne ;

//  + "z"           matrice-colonne de taille n, résultat du système Lz = y ;

function z = descente(l_diag, l_inf, y)
    n = length(l_diag);
    z = zeros(n, 1);
    
    // Comme L est une matrice bidiagonale, la résolution du système
    // s'en trouve encore très simplifiée : coût en temps de Θ(n). La
    // relation de la récurrence est définie de la façon suivante :
    // z[1] = y[1] / L[1, 1]
    // z[j] = (y[j] - L[j + 1, j] * z[j - 1]) / L[j, j]
    z(1) = y(1) / l_diag(1);
    
    for j = 2:n
        z(j) = (y(j) - l_inf(j - 1) * z(j - 1)) / l_diag(j);
    end
endfunction


// EXEMPLES D'UTILISATION
// TODO. Ecrire un test !
