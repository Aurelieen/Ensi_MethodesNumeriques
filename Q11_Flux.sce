// :::::::::::::::::::::::::::::::::::::::::
// ::                                     ::
// ::     Question 11. Mesure du flux     ::
// ::                                     ::
// :::::::::::::::::::::::::::::::::::::::::
funcprot(0);
exec("Q3_Factorisation_Cholesky.sce");
exec("Q4_Descente_Cholesky.sce");
exec("Q5_Remontee_Cholesky.sce");


// Fonction u0(t)
function res = u0(t, T)
    res = (t / T)^2
endfunction

// Fonction u0'(t)
function res = derivee_en_t_u0(t, T)
    res = (2 * t) / (T^2)
endfunction

// Fonction u^(0) = u_p_0(x)
function res = u_p_0(x)
    res = 0
endfunction

// Fonction C(x)
function res = C(x, xd, a)
    res = 1 - a * exp(-(x - xd)^2/(4));
endfunction


// Matrice A
function [matrice_A_diag, matrice_A_inf] = calcul_A(n, x_d, l, a)
    matrice_A_diag = zeros(n, 1);
    matrice_A_inf = zeros(n-1, 1);

    delta_x = (2 * l)/(n + 1);
    i = 1;

    for x = -l+delta_x:delta_x:l-2*delta_x
        // n ajoute les coefficients dans la matrice
        matrice_A_diag(i) = C(x + delta_x / 2, x_d, a) + C(x - delta_x / 2, x_d, a);
        matrice_A_inf(i) = -C(x + delta_x / 2, x_d, a);

        i = i + 1
    end

    matrice_A_diag(n) = C(l - delta_x / 2, x_d, a) + C(l - 3 * (delta_x / 2), x_d, a);
endfunction

// Matrice B
function [matrice_B] = calcul_B(k, n, x_d, l, a, theta, delta_t, delta_x, T)
    matrice_B($ + 1) = C(-l + (delta_x/2), x_d, a) * (theta * u0(delta_t * (k + 1), T) + (1 - theta) * u0(delta_t * k, T));
endfunction


// Matrice M
function [matrice_M_diag, matrice_M_inf] = calcul_M(n, theta, mu, x_d, l, a)
    [diag_sup_A, diag_inf_A] = calcul_A(n, x_d, l, a);
    matrice_M_inf = zeros(n - 1, 1);
    matrice_M_diag = zeros(n, 1);

    for i = 1:n-1
        matrice_M_diag(i) = diag_sup_A(i) * theta * mu + 1;
        matrice_M_inf(i) = diag_inf_A(i) * theta * mu;
    end

    matrice_M_diag(n) = diag_sup_A(n) * theta * mu + 1;
endfunction


// Matrice N
function [matrice_N_diag, matrice_N_inf] = calcul_N(n, theta, mu, x_d, l, a)
    [diag_sup_A, diag_inf_A] = calcul_A(n, x_d, l, a);
    matrice_N_inf = zeros(n - 1, 1);
    matrice_N_diag = zeros(n, 1);

    for i = 1:n-1
        matrice_N_diag(i) = diag_sup_A(i) * (theta - 1) * mu + 1;
        matrice_N_inf(i) = diag_inf_A(i) * (theta - 1) * mu;
    end

    matrice_N_diag(n) = diag_sup_A(n) * (theta - 1) * mu + 1;
endfunction


// Calcul du vecteur second membre N*U^(k) + \mu * B^(k)
function [sm] = calcul_second_membre(N_diag, N_inf, U, mu, k, n, x_d, l, a, theta, delta_t, delta_x, T)
    sm = zeros(n, 1);
    B = calcul_B(k, n, x_d, l, a, theta, delta_t, delta_x, T);

    // Produit N * U
    sm(1) = N_diag(1) * U(1) + N_inf(1) * U(2) + mu * B(1)
    sm(n) = N_diag(n) * U(n) + N_inf(n - 1) * U(n - 1)

    for i = 2:n-1
        sm(i) = N_diag(i) * U(i) + N_inf(i - 1) * U(i - 1) + N_inf(i) * U(i + 1)
    end
endfunction


// Fonction FLUX
function [F_t_inter, F_t_fin] = flux(x_d)
    // Définition de tous les paramètres
    n = 1000; n_t = 3000;
    l = 10; T = 60; a = 0.8; theta = 1/2;

    // Valeurs temporelles auxquelles on récupère le flux
    t_inter = 2/3 * T;
    t_fin = T;

    F_t_inter = 5;
    F_t_fin = 5;

    // Pas après discrétisation
    delta_x = (2 * l) / (n + 1);
    delta_t = T / n_t;
    mu = delta_t / (delta_x)^2;

    // Pré-calculs, effectués une seule fois
    [M_diag, M_inf] = calcul_M(n, theta, mu, x_d, l, a);
    [F_diag, F_inf] = factorise(M_diag, M_inf);
    [N_diag, N_inf] = calcul_N(n, theta, mu, x_d, l, a);

    U = zeros(n, 1);

    for k = 0:(n_t - 1)
        NU_p_muB = calcul_second_membre(N_diag, N_inf, U, mu, k, n, x_d, l, a, theta, delta_t, delta_x, T);

        // Décomposition de Cholesky
        v_descente = descente(F_diag, F_inf, NU_p_muB);
        U = remonte(F_diag, F_inf, v_descente);
        t_verif = (k + 1) * delta_t;

        if (t_verif == t_inter) then
            F_t_inter = C(-l + (delta_x / 2), x_d, a) * (U(1) - u0(t_inter, T)) * (1 / delta_x) - (delta_x / 2) * derivee_en_t_u0(t_inter, T)
            //disp("ah");
            //disp(F_t_inter);
            //disp("Inter");
        elseif t_verif == t_fin then
            F_t_fin = C(-l + (delta_x / 2), x_d, a) * (U(1) - u0(t_fin, T)) * (1 / delta_x) - (delta_x / 2) * derivee_en_t_u0(t_fin, T)
            //disp(F_t_fin);
            //disp("Fin");
        end
    end

    //disp((norm(-0.1 - F_t_inter, -0.18 - F_t_fin)/norm(-0.1, -0.18))^2);
endfunction


// Exemple d'appel :
// flux(-10)
