// :::::::::::::::::::::::::::::::::::::::::
// ::                                     ::
// ::      Question 14. Gauss-Newton      ::
// ::                                     ::
// :::::::::::::::::::::::::::::::::::::::::
funcprot(0);

exec("Q11_Flux.sce");

flux_cible = [-0.1, -0.18];

// Calcule le minimum de la fonction J, c'est un point de la barre.
function [xk] = minJ(x0)
    xk = x0
    k = 0
    arret_xk = 1;

    while abs(arret_xk) > 10^-5
        flux_xk = (flux_vecteur(xk)');
        flux_deriv = numderivative(flux_vecteur, xk)';

        delta_k = (-flux_deriv) * ((flux_xk - flux_cible)') / (flux_deriv * flux_deriv');
        xk = xk + delta_k;

        // Condition d'arrêt, epsilon est fixé à 10^-5
        arret_xk = (2 * flux_deriv * (flux_xk - flux_cible)') / (flux_cible(1)^2 + flux_cible(2)^2);
        k = k + 1;

        disp("- x_k vaut " + string(xk));
    end
endfunction

// EXEMPLES D'APPEL A ESSAYER
// minJ(0);
// minJ(-5);
// minJ(3);
