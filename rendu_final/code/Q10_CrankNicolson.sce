// :::::::::::::::::::::::::::::::::::::::::
// ::                                     ::
// ::     Question 10. Crank-Nicolson     ::
// ::                                     ::
// :::::::::::::::::::::::::::::::::::::::::
funcprot(0);
exec("Q3_Factorisation_Cholesky.sce");
exec("Q4_Descente_Cholesky.sce");
exec("Q5_Remontee_Cholesky.sce");

// CONSTANTES DE LA SIMULATION
// Demi-longueur de la barre métallique
l = 13;

// Fonction de conductivité
function res = C(x)
    res = exp(-x / l);
endfunction

// Solution exacte de l'équation différentielle au point x
function res = probleme_stationnaire(x)
    res = (%e * (%e - exp(x/l)))/(exp(2) - 1);
endfunction

// Fonction u0(t)
function res = u0(t)
    res = 1
endfunction

// Fonction u^(0)(x)
function res = u_p0(x)
    res = 0
endfunction


// Matrice A
function [matrice_A_diag, matrice_A_inf] = calcul_A(n)
    matrice_A_diag = zeros(n, 1);
    matrice_A_inf = zeros(n-1, 1);

    delta_x = (2 * l)/(n + 1);
    i = 1;

    for x = -l+delta_x:delta_x:l-2*delta_x
        // n ajoute les coefficients dans la matrice
        matrice_A_diag(i) = C(x + delta_x / 2) + C(x - delta_x / 2);
        matrice_A_inf(i) = -C(x + delta_x / 2);

        i = i + 1
    end

    matrice_A_diag(n) = C(l - delta_x / 2) + C(l - 3 * (delta_x / 2));
endfunction

// Matrice B
function [matrice_B] = calcul_B(k, n)
    delta_x = (2 * l)/(n + 1);

    matrice_B = zeros(n, 1);
    matrice_B(1) = C(-l + (delta_x/2));
endfunction


// Matrice M
function [matrice_M_diag, matrice_M_inf] = calcul_M(n, theta, mu)
    [diag_sup_A, diag_inf_A] = calcul_A(n);
    matrice_M_inf = zeros(n - 1, 1);
    matrice_M_diag = zeros(n, 1);

    for i = 1:n-1
        matrice_M_diag(i) = diag_sup_A(i) * theta * mu + 1;
        matrice_M_inf(i) = diag_inf_A(i) * theta * mu;
    end

    matrice_M_diag(n) = diag_sup_A(n) * theta * mu + 1;
endfunction


// Matrice N
function [matrice_N_diag, matrice_N_inf] = calcul_N(n, theta, mu)
    [diag_sup_A, diag_inf_A] = calcul_A(n);
    matrice_N_inf = zeros(n - 1, 1);
    matrice_N_diag = zeros(n, 1);

    for i = 1:n-1
        matrice_N_diag(i) = diag_sup_A(i) * (theta - 1) * mu + 1;
        matrice_N_inf(i) = diag_inf_A(i) * (theta - 1) * mu;
    end

    matrice_N_diag(n) = diag_sup_A(n) * (theta - 1) * mu + 1;
endfunction


// Calcul du vecteur second membre N*U^(k) + \mu * B^(k)
function [sm] = calcul_second_membre(N_diag, N_inf, U, mu, k, n)
    sm = zeros(n, 1);
    B = calcul_B(k, n);

    // Produit N * U
    sm(1) = N_diag(1) * U(1) + N_inf(1) * U(2)
    sm(n) = N_diag(n) * U(n) + N_inf(n - 1) * U(n - 1)
    for i = 2:n-1
        sm(i) = N_diag(i) * U(i) + N_inf(i - 1) * U(i - 1) + N_inf(i) * U(i + 1)
    end

    // Ajout du second membre \mu * B^k
    for i = 1:n
        sm(i) = sm(i) + mu * B(i)
    end
endfunction


function question_10()
    clf;

    n = 100;                            // Nombre de pas d'espace
    n_t = 6000;                         // Nombre d'itérations
    T = 500;                            // Temps total
    theta = 1/2;                        // Crank-Nicolson

    delta_t = T / n_t;                  // Pas d'espace
    delta_x = (2 * l)/(n + 1);          // Pas de temps
    mu = delta_t / (delta_x^2);         // Rapport des pas
    intervalle_x = -l:delta_x:l         // Intervalle discrétisé

    // Pré-calcul de M et de N, fait une seule fois
    [M_diag, M_inf] = calcul_M(n, theta, mu);
    [F_diag, F_inf] = factorise(M_diag, M_inf);
    [N_diag, N_inf] = calcul_N(n, theta, mu);

    // Affichage de la solution
    U = zeros(n, 1);

    // Itérations
    for k = 0:n_t - 1
        NU_p_muB = calcul_second_membre(N_diag, N_inf, U, mu, k, n);

        // Décomposition de Cholesky
        v_descente = descente(F_diag, F_inf, NU_p_muB);
        U = remonte(F_diag, F_inf, v_descente);

        // On affiche certaines valeurs
        if modulo(k, 200) == 0 then
            plot((-l+delta_x:delta_x:l-delta_x)', U, '.r');
        end
    end

    // Affichage graphique
    plot(intervalle_x, probleme_stationnaire);
    xtitle("Représentation à différents pas de temps de la solution numérique convergeant vers la solution graphique");
endfunction

// APPEL DE LA QUESTION 10
question_10()
