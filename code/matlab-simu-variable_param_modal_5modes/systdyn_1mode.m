function dydt = systdyn_1mode(t, y, res, g, z)
%SYSTDYN_1MODE Fonction de mise a jour des p et dp pour un systeme a 1 mode
% Inputs :
%   t : Temps ou l'on calcule ca (a priori, inutile)
%   y : Vecteur de taille 1 x 4 qui contient p et dp au temps précédent
%   res : Pulsations, Q, facteurs modaux des 5 modes
%   g : gamma
%   z : zeta
% Outputs :
%   dydt : Vecteur de taille 1 x 4 qui continet p et dp au temps suivant
%   ainsi que g et z

w = res(1,1); F = res(1,2); Q = res(1,3);

p = y(1);
dp = y(2);

if ((g - p) <= 0) 
    dudt = -dp*z*sqrt(p-g) - dp*z*(1-g+p)/(2*sqrt(p-g));
elseif ((g - p) >= 1)
    dudt = 0;
else
    dudt = dp*z*sqrt(g-p) - dp*z*(1-g+p)/(2*sqrt(g-p));
end

dydt1 = [dp; -(w/Q)*dp - w*w*p + F*dudt];


dydt = [dydt1;g;z];
end