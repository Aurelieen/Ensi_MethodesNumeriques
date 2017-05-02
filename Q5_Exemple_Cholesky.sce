// :::::::::::::::::::::::::::::::::::::::::
// ::                                     ::
// ::    Question 5. Cholesky, exemple    ::
// ::                                     ::
// :::::::::::::::::::::::::::::::::::::::::
funcprot(0);
exec("Q3_Factorisation_Cholesky.sce");
exec("Q4_Descente_Cholesky.sce");
exec("Q5_Remontee_Cholesky.sce");

// On résout le système MX = B
// où M, X et B sont les matrices définies dans
// la réponse à la question 5 du compte-rendu.
function exemple5()
    matrice_M_diag = [1, 2, 2, 2, 2];
    matrice_M_inf = [-1, -1, -1, -1];
    matrice_B = [10, 20, 30, 40, 50];

    // On procède classiquement en trois phases :
    //      - Factorisation (rapide car M est tridiagonale) ;
    //      - Descente (idem, facilitée par la structure de la factorisation) ;
    //      - Remontée (idem, facilitée par la structure de la factorisation) ;
    [matrice_F_diag, matrice_F_inf] = factorise(matrice_M_diag, matrice_M_inf);
    m_descente = descente(matrice_F_diag, matrice_F_inf, matrice_B);
    matrice_X = remonte(matrice_F_diag, matrice_F_inf, m_descente);

    disp("La matrice résultat est : ");
    disp(matrice_X);
    disp("Le résultat attendu en comparaison est :");
    disp([350; 340; 310; 250; 150]);

    // Vérification sommaire sur une calculatrice externe.
    // Taper la ligne ci-dessous sur WolframAlpha :
    // {{1, -1, 0, 0, 0}, {-1, 2, -1, 0, 0}, {0, -1, 2, -1, 0}, {0, 0, -1, 2, -1}, {0, 0, 0, -1, 2}} . {{a}, {b}, {c}, {d}, {e}} = {{10}, {20}, {30}, {40}, {50}}
endfunction

exemple5()
