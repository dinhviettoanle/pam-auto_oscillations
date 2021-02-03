function r = reflectionFunction(a,b, dt, te, ind)
%Fonction de r�flection
%retourne r(t)=a*exp(-b*dt)^2)
%forme simplifi�e utilis�e dans McIntyre
%dt:pas de temps (=2*L/c)
%te=p�fiode d'�chantillonnage
%ind:indice courant
r=a*exp(-b*(te*ind-dt)^2);
end

