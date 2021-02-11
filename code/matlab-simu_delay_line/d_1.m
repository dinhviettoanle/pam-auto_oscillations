function f_prime=d_1(f, n, te)
%%Retourne la dérivée première de f au point n en différence finie à gauche
%f:vecteur
%n>=1 : indice
f_prime=(3/2)*f(n)-2*delay(f, 1, n)+0.5*delay(f, 2, n);
f_prime=f_prime*(1/te);
end