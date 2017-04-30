// Réponse à la question 13, fonction dichotomie. 

// xd réultat
// epsilon précision.
// a, b bornes de l'intervalle
 
function [xd] = dichotomie(epsilon, result_functionJ, intervalle)
    [J1, J2, J3] = result_functionJ; 
    while abs(intervalle(0) - intervalle(1)) > epsilon
        J = min(J1, J2, J3); 
        if J == J1 then
            intervalle(1) = intervalle(0) + (intervalle(1)-intervalle(0))/2;
        end
        if J == J2 then 
            intervalle(0) = intervalle(0) + (intervalle(1)-intervalle(0))/4;
            intervalle(1) = intervalle(1) - (intervalle(1)-intervalle(0))/4;
        end
         if J == J3 then 
            intervalle(0) = intervalle(0) + (intervalle(1)-intervalle(0))/2;
        end
        [J1, J2, J3] = functionJ(intervalle); 
    end
    
    xd = (intervalle(1) + intervalle(0))/2; 
endfunction

