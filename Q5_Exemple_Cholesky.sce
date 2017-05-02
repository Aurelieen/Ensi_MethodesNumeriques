// :::::::::::::::::::::::::::::::::::::::::
// ::                                     ::
// ::    Question 5. Cholesky, exemple    ::
// ::                                     ::
// :::::::::::::::::::::::::::::::::::::::::
funcprot(0);
exec("Q3_Factorisation_Cholesky.sce");
exec("Q4_Descente_Cholesky.sce");
exec("Q5_Remontee_Cholesky.sce");

// On résout MX = B
function exemple5()
    matrice_M_diag = [1, 2, 2, 2, 2];
    matrice_M_inf = [-1, -1, -1, -1];
    matrice_B = [10, 20, 30, 40, 50];

    [matrice_F_diag, matrice_F_inf] = factorise(matrice_M_diag, matrice_M_inf);
    m_descente = descente(matrice_F_diag, matrice_F_inf, matrice_B);
    matrice_X = remonte(matrice_F_diag, matrice_F_inf, m_descente);

    disp("La matrice résultat est : ");
    disp(matrice_X);
    disp("Le résultat attendu en comparaison est :");
    disp([350, 340, 310, 250, 150]);
endfunction

exemple5()
