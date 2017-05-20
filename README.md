# Ensi_MethodesNumeriques
Ensimag 1A – Étude de la conductivité thermique dans une barre métallique en Scilab.

## Utilisation
```sh
# Tester un script dans Scilab
scilab -f algorithmes/<fichier>

# (!) Par défaut, certains scripts comme Q12_J.sce sont très lents.
# Même en exploitant la forme particulière des matrices issues de la
# discrétisation du problème, on résout pour chacun des 200 points
# d'échantillonnages des systèmes linéaires à 3000 inconnues
# pour 2000 pas de temps successifs >> faire varier les constantes.
```

## Contenu des scripts
+ Résolution de _Ax = b_ avec _A_ tridiagonale, symétrique et définie positive :
  + Factorisation de Cholesky *(Q3)*
  + Phase de descente *(Q4)*
  + Phase de remontée *(Q5)*
  + Application sur un exemple *(Q5)*
+ Modélisation d'un problème stationnaire *(Q7)*
+ Schéma appliqué de Crank-Nicolson *(Q10)*
+ Approximation du flux de conductivité *(Q11)*
  + Fonction J de distance d'un flux au flux cible *(Q12)*
+ Algorithmes d'optimisation numérique :
  + Recherche du minimum par la méthode dichotomique *(Q13)*
  + Recherche du minimum par la méthode de Gauss-Newton *(Q14)*
