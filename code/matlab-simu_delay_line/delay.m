function newVal = delay(vector,n, i)
%applique un delay de n échantillons
%pour éviter de changer la teille du vecteur à chaque échantillon, on
%"simule" le temps réel en précisant l'indice i du temps courant
%retourne 0 si n>i
if (i-n)<1
    newVal=0;
else
    newVal=vector(i-n);
end
end

