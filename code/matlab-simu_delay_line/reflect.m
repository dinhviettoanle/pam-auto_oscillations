function p_i=reflect(f_plus, f_moins, n, a, c, Zc)
    %applique la fonction de réflexion avec un shéma en différences finies
    %à gauche
    %f_moins : vecteur
    %f_plus:vecteur
    %n=indice
    %a:rayon
    %Zc:impédance caractéristique
    a1=-2*0.6133*(a/c)-5*(-0.25)*((a/c)^2);
    a2=0.5*0.6133*(a/c)+4*(-0.25)*((a/c)^2);
    a3=-1*(-0.25)*((a/c)^2);
    A=1+(3/2)*0.6133*(a/c)-2*0.25*((a/c)^2);
    p_i=(E_f_plus(f_plus, n, a, c)-a1*delay(f_moins, 1, n)-a2*delay(f_moins, 2, n)-a3*delay(f_moins, 3, n))/A;
    %p_i=p_i;
end