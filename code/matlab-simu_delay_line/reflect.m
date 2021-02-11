function p_i=reflect(f_plus, f_moins, n, a, c, te)
    %applique la fonction de réflexion avec un shéma en différences finies
    %à gauche
    %f_moins : vecteur
    %f_plus:vecteur
    %n=indice
    %a:rayon
    %Zc:impédance caractéristique
    h= 1/te;
    h2=(1/te)^2;
    a1=-2*0.6133*(a/c)*h-5*(-0.25)*((a/c)^2)*h2;
    a2=0.5*0.6133*(a/c)*h+4*(-0.25)*((a/c)^2)*h2;
    a3=-1*(-0.25)*((a/c)^2)*h2;
    A=1+(3/2)*h*0.6133*(a/c)-2*h2*0.25*((a/c)^2);
    p_i=(E_f_plus(f_plus, n, a, c, te)-a1*delay(f_moins, 1, n)-a2*delay(f_moins, 2, n)-a3*delay(f_moins, 3, n))/A;
    %p_i=p_i/Zc;
end