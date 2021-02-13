function [has_oscillations] = descriptor_has_oscillations(gamma, zeta, res, t_end, Fs, FILL)
%DESCRIPTOR_HAS_OSCILLATIONS Descripteur d'existence d'un régime oscillant
%   Renvoie 1 si l'amplitude finale est > 0.1
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

[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

final_amp = max(p(0.75*end:end));


if FILL
    has_oscillations = final_amp;
else
    if final_amp > 0.1
        has_oscillations = 1;
    else
        has_oscillations = -1;
    end
end

fprintf("Max final amplitude : %f -> %i\n", final_amp, (final_amp > 0.1));

end

