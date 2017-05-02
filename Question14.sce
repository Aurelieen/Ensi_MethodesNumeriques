// Question 14

exec("Q11_Flux.sce");

// Estimation initiale x0 ? 
flux_cible = [-0.1, -0.18]; 

function [] = minJ ()
    xk = -6; 
    k = 0; 
    J_xd = 1; 
    while J_xd > 10^(-5)
        flux_xk = flux(xk); 
        flux_derive_xk = numderivative(flux, xk); 
        delta_k = -flux_derive_xk'*(flux_xk - flux_cible)/(flux_xk' flux_derive_xk); 
        xk = xk + delta_k; 
        k = k+1; 
        J_xd = 2* flux_derive_xd' (flux_xk - flux_cible)/(norm(-0.1,-0.18)); 
    end
    disp(xk); 
endfunction
