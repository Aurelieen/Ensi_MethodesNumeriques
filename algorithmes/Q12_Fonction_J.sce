// :::::::::::::::::::::::::::::::::::::::::
// ::                                     ::
// ::       Question 12. Fonction J       ::
// ::                                     ::
// :::::::::::::::::::::::::::::::::::::::::
funcprot(0);
exec("Q11_Flux.sce");

// CONSTANTES
flux_cible = [-0.1, -0.18];

// Calcul de la norme euclidienne au carré
function res = n2_carre(c1, c2)
    res = c1^2 + c2^2
endfunction

// Calcul de la fonction J
function res = J(x_d)
    [f_inter, f_fin] = flux(x_d);
    // res = (norm((-0.1 - f_inter, -0.18 - f_fin))/norm((-0.1, -0.18)))^2;
    res = n2_carre(f_inter - flux_cible(1), f_fin - flux_cible(2)) / n2_carre(-0.1, -0.18);
    // disp(x_d, res);
endfunction


// Question 12
function question12()
    xd_gauche = -10
    xd_droite = 10
    xd_nb_pas = 200

    xd_pas = (xd_droite - xd_gauche) / (xd_nb_pas)
    intervalle_xd = xd_gauche:xd_pas:xd_droite

    plot(intervalle_xd, J)
endfunction

// A DECOMMENTER POUR TESTER LA QUESTION
// question12()
