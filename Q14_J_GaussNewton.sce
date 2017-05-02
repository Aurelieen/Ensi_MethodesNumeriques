// Question 14

exec("Q11_Flux.sce");

flux_cible = [-0.1, -0.18];


function [xk] = minJ_2(x0)
    xk = x0
    k = 0
    arret_xk = 1;

    // Pour l'affichage graphique
    xk_avant = 0

    while abs(arret_xk) > 10^-5
        flux_xk = (flux_vecteur(xk)');
        flux_deriv = numderivative(flux_vecteur, xk)';

        delta_k = (-flux_deriv) * ((flux_xk - flux_cible)') / (flux_deriv * flux_deriv');
        xk = xk + delta_k;

        arret_xk = (2 * flux_deriv * (flux_xk - flux_cible)') / (flux_cible(1)^2 + flux_cible(2)^2);
        k = k + 1;

        disp("- x_k vaut " + string(xk));
    end
endfunction

minJ_2(0);
