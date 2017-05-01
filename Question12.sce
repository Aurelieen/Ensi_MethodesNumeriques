// Question 12

function [result_J] = calcul_J(x_d)
    result_J = norm(flux(x_d) - [-0.1, -0.18])/norm([-0.1; -0.18]); 
endfunction

echantillonage = 50;
result_courbe = zeros(echantillonage, 1);
xd = -6; 

for i = 1:echantillonage
    result_courbe(i) = calcul_J(xd); 
    xd = xd + 9/echantillonage; 
end

plot(result_courbe); 
