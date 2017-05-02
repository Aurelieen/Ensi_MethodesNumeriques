// :::::::::::::::::::::::::::::::::::::::::
// ::                                     ::
// ::       Question 13. Dichotomie       ::
// ::                                     ::
// :::::::::::::::::::::::::::::::::::::::::
funcprot(0)
exec("Q12_Fonction_J.sce");
// Réponse à la question 13, fonction dichotomie.

// Calcule trois flux à la fois
function [J1, J2, J3] = trois_flux(liste_flux)
    J1 = J(flux(liste_flux(1)));
    J2 = J(flux(liste_flux(2)));
    J3 = J(flux(liste_flux(3)));

    disp("J1J2J3", J1, J2, J3);
endfunction

// xd réultat
// epsilon précision.
// a, b bornes de l'intervalle
function [xd] = dichotomie(epsilon, fJ, J_depart, intervalle)
    J1 = J_depart(1);
    J2 = J_depart(2);
    J3 = J_depart(3);
    // [J1, J2, J3] = repmat([J_depart(1), J_depart(2), J_depart(3)]);

    while abs(intervalle(1) - intervalle(2)) > epsilon
        Jmin = min(J1, J2, J3);
        if Jmin == J1 then
            intervalle(2) = intervalle(1) + (intervalle(2)-intervalle(1))/2;
        end
        if Jmin == J2 then
            intervalle(1) = intervalle(1) + (intervalle(2)-intervalle(1))/4;
            intervalle(2) = intervalle(2) - (intervalle(2)-intervalle(1))/4;
        end
         if Jmin == J3 then
            intervalle(1) = intervalle(1) + (intervalle(2)-intervalle(1))/2;
        end

        disp(intervalle);
        delta = (intervalle(2) - intervalle(1)) / 4
        [J1, J2, J3] = fJ([intervalle(1) + delta * 1, intervalle(1) + delta * 2, intervalle(1) + delta * 3]);
    end

    xd = (intervalle(2) + intervalle(1))/2;
endfunction

function question13()
    epsilon = 10^-5
    intervalle = [-6; 3]         // Pré-condition : J(x) est unimodale sur I
    delta = (intervalle(2) - intervalle(1)) / 4

    [J1, J2, J3] = trois_flux([-6 + delta * 1, -6 + delta * 2, -6 + delta * 3]);
    x_d = dichotomie(epsilon, trois_flux, [J1, J2, J3], intervalle);

    // Résultat
    disp("x_d*", x_d);
endfunction

question13()
