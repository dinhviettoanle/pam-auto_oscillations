function [diverged] = descriptor_diverge(gamma, zeta, res, t_end, Fs, FILL)
%DESCRIPTOR_DIVERGE Descripteur de stabilité du schéma numérique
%   Renvoie 1 si l'amplitude finale est > 1000
% Inputs :
%   gamma : Paramètre de pression dans la bouche adim
%   zeta : Paramètre d'anche adim
%   res : Matrice de taille N_MODES x 3 tel que :
%       res(i,1) : pulsation du mode i
%       res(i,2) : coeff de qualite du mode i
%       res(i,3) : facteur modal du mode i
%   t_end : Temps de fin de simulation
%   Fs : Fréquence d'échantillonnage
%   FILL : Booleen tel que si FILL == True : renvoie la valeur au lieu de +/-1)

[t, X] = simulate_5modes_explicit(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

final_amp = max(abs(p(1:1000)));


if FILL
    diverged = final_amp;
else
    if final_amp > 1000
        diverged = 1;
    else
        diverged = -1;
    end
end

fprintf("Max final amplitude : %f -> %i\n", final_amp, (final_amp > 1000));

end

