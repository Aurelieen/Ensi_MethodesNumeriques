// ::::::::::::::::::::::::::::::::::::::::::::::
// ::                                          ::
// ::  Question 5. Remontee (Cholesky, suite)  ::
// ::                                          ::
// ::::::::::::::::::::::::::::::::::::::::::::::
funcprot(0)

// Méthode de Cholesky, phase de remontée
// ======================================
// Préconditions :
//  - L est une matrice bidiagonale
//  - z est une matrice-colonne de taille n
// ======================================
// Postconditions :
//  - X est une matrice-colonne résultat de taille n
// ======================================
//  - "l_diag"      diagonale (taille n) de la matrice L ;
//  - "l_inf"       sous-diagonale (taille n - 1) de la matrice L ;
//  - "z"           membre droit du système (tL)x = z, matrice-colonne ;

//  + "x"           matrice-colonne de taille n, résultat du système (tL)x = z;

function x = remonte(l_diag, l_inf, z)
    n = length(l_diag);
    x = zeros(n, 1);
    
    // TODO. A commenter.
    x(n) = z(n) / l_diag(n)
    for j = (n - 1):-1:1
        x(j) = (z(j) - l_inf(j) * x(j + 1)) / l_diag(j);
    end
endfunction


// EXEMPLES D'UTILISATION
// TODO. Ecrire un test !

// EXEMPLE CONNU :
// {{1, -1, 0, 0, 0}, {-1, 2, -1, 0, 0}, {0, -1, 2, -1, 0}, {0, 0, -1, 2, -1}, {0, 0, 0, -1, 2}} . {{a}, {b}, {c}, {d}, {e}} = {{10}, {20}, {30}, {40}, {50}}
// donne comme résultats : a = 350; b = 340; c = 310; d = 250; e = 150
// via WolframAlpha
