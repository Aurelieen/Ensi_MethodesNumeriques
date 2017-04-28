
// Programme pour la question 11 

exec("Q3_Factorisation_Cholesky.sce"); 
exec("Q5_Remontee_Cholesky.sce"); 
exec("Q4_Descente_Cholesky.sce"); 
exec("Q7.sce"); 

T = 60; 
a = 0.8; 
l = 10; 
n = 2000; 
delta_x = 20/2001; 
n_t = 3000; 
delta_t = 60/3000; 
theta = 1/2; 

t_inter = 2/3 * T;
t_fin = T; 

function [result_flux_inter, result_flux_fin] = flux(xd)
    result_C = calcul_C(2); 
    result_flux_inter = calcul_C(1)*()/delta_x - delta_x*t_inter/T^2;
    result_flux_fin = calcul_C(1)*()/delta_x - delta_x*t_fin/T^2;
endfunction
