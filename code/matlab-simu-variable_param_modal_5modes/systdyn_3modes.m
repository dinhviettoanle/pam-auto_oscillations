function dydt = systdyn_3modes(t, y, res, g, z)
%SYSTDYN_3MODES Fonction de mise a jour des p et dp pour un systeme a 3 modes
% Inputs :
%   t : Temps ou l'on calcule ca (a priori, inutile)
%   y : Vecteur de taille 1 x 8 qui contient p et dp au temps précédent
%   res : Pulsations, Q, facteurs modaux des 5 modes
%   g : gamma
%   z : zeta
% Outputs :
%   dydt : Vecteur de taille 1 x 8 qui continet p et dp au temps suivant
%   ainsi que g et z

w1 = res(1,1); F1 = res(1,2); Q1 = res(1,3);
w2 = res(2,1); F2 = res(2,2); Q2 = res(2,3);
w3 = res(3,1); F3 = res(3,2); Q3 = res(3,3);

p_tot = y(1) + y(3) + y(5);
dp_tot = y(2) + y(4) + y(6);

if (g - p_tot) > 1
    dudt = 0;
elseif (0 <= (g - p_tot)) && ((g - p_tot) <= 1)
    dudt = dp_tot*z*sqrt(g - p_tot) - dp_tot*z*(1 - g + p_tot)/(2*sqrt(g - p_tot));
elseif (g - p_tot) < 0
    dudt = -dp_tot*z*sqrt(-g + p_tot) - (dp_tot)*z*(1 - g + p_tot)/(2*sqrt(-g + p_tot));
else
    dudt = -1;
end
    
% fprintf("%f \n", (g - p_tot));

dydt1 = [y(2); -(w1/Q1)*y(2) - w1^2*y(1) + F1*dudt];
dydt2 = [y(4); -(w2/Q2)*y(4) - w2^2*y(3) + F2*dudt];
dydt3 = [y(6); -(w3/Q3)*y(6) - w3^2*y(5) + F3*dudt];

dydt = [dydt1;dydt2;dydt3;g;z];
end