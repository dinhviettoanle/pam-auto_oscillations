function [is_periodic] = descriptor_periodic(gamma, zeta, res, t_end, Fs, FILL)
%DESCRIPTOR_PERIODIC Descripteur de périodicité / quasi-périodicite
% Est quasi-periodique si la variance de la puissance en régime établi est grande
% Renvoie 1 si c'est périodique et -1 si c'est quasi-periodique
% Inputs :
%   gamma : Paramètre de pression dans la bouche adim
%   zeta : Paramètre d'anche adim
%   res : Matrice de taille N_MODES x 3 tel que :
%       res(i,1) : pulsation du mode i
%       res(i,2) : coeff de qualite du mode i
%       res(i,3) : facteur modal du mode i
%   t_end : Temps de fin de simulation
%   Fs : Fréquence d'échantillonnage

[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

relevant_p = p(0.75*end:end);

power_p = relevant_p.^2;
var_power_enveloppe = var(power_p/mean(power_p));

if FILL
    is_periodic = var_power_enveloppe;
else
    if (var_power_enveloppe > 0.21)
        is_periodic = -1;
    else
        is_periodic = 1;
    end
end

fprintf("epsilon : %f \n", var_power_enveloppe);

end