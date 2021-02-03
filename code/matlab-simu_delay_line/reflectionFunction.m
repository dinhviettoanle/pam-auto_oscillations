function r = reflectionFunction(a,b, dt, te, ind)
%Fonction de réflection
%retourne r(t)=a*exp(-b*dt)^2)
%forme simplifiée utilisée dans McIntyre
%dt:pas de temps (=2*L/c)
%te=péfiode d'échantillonnage
%ind:indice courant
r=a*exp(-b*(te*ind-dt)^2);
end

