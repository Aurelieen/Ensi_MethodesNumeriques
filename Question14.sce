// Question 14

exec("Q11_Flux.sce");

// Estimation initiale x0 ? 
flux_cible = [-0.1, -0.18]; 

function [result_int] = mult_vecteurs(vecteur1, vecteur2)
    result_int = vecteur1(1) * vecteur2(1) + vecteur1(2) * vecteur2(2); 
    
    
endfunction

function [xk] = minJ (x0)
    xk = x0; 
    k = 0; 
    J_xk = 1; 
    while abs(J_xk) >= 10^(-5)
        [flux_xk_inter, flux_xk_fin] = flux(xk); 
        flux_xk = [flux_xk_inter, flux_xk_fin]; 
        [flux_derive_xk_inter, flux_derive_xk_fin] = numderivative(flux, xk); 
        flux_xk_derive = [flux_derive_xk_inter, flux_derive_xk_fin]; 
        delta_k = mult_vecteurs(-flux_xk_derive, ([flux_xk(1) - flux_cible(1), flux_xk(2) - flux_cible(2)]))/mult_vecteurs(flux_xk_derive, flux_xk_derive); 
        xk = xk + delta_k; 
        k = k+1; 
        J_xk = 2* mult_vecteurs(flux_xk_derive, ([flux_xk(1) - flux_cible(1), flux_xk(2) - flux_cible(2)]))/(0.1^2 + 0.18^2);
        disp("xk " + string(xk)); 
    end
    disp(k);
endfunction

minJ(-5); 
minJ(-4);
minJ(-3); 
minJ(-2); 
