function f_seconde=d_2(f, n, te)
%%Retourne la dérivée seconde de f au point n en différence finie à gauche
%f:vecteur
%n>=1 : indice
n
f_seconde=2*f(n) - 5*delay(f, 1, n) + 4*delay(f, 2, n)-delay(f, 3, n);
f_seconde=f_seconde*(1/(te^2));
end