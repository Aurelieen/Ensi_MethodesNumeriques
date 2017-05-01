// :::::::::::::::::::::::::::::::::::::::::
// ::                                     ::
// ::       Question 12. Fonction J       ::
// ::                                     ::
// :::::::::::::::::::::::::::::::::::::::::
funcprot(0);
exec("Q11_Flux.sce");

// CONSTANTES
flux_cible = [-0.1, -0.18]

// Calcul de la fonction J
function res = J(x_d)
    [f_inter, f_fin] = flux(x_d); 
    res = (norm(-0.1 - f_inter, -0.18 - f_fin)/norm(-0.1, -0.18))^2;
    //disp(x_d);
    //disp(res);
endfunction

// Question 12
function question12()
    xd_gauche = -6
    xd_droite = 3
    xd_nb_pas = 20

    xd_pas = (xd_droite - xd_gauche) / (xd_nb_pas - 1)
    intervalle_xd = xd_gauche:xd_pas:xd_droite

    plot(intervalle_xd, J)
endfunction

question12()
