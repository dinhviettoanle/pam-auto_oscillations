function [is_fast] = descriptor_attack_time(gamma, zeta, res, t_end, Fs, FILL)
%DESCRIPTOR_ATTACK_TIME Descripteur de temps d'attaque
%   Renvoie 1 si le temps d'attaque est < 0.04 (par mirattacktime)
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
mirobject = miraudio(p, Fs);

char_computed = mirattacktime(mirobject);
feature = mirgetdata(char_computed);

if isempty(feature)
    is_fast = 1;
    fprintf("No attack");
else
    attack_first_note = feature(1);

    if FILL
        is_fast = attack_first_note;
    else
        if attack_first_note < 0.04
            is_fast = 1;
        else
            is_fast = -1;
        end
    end

    fprintf("Attack time : %f -> %i\n", attack_first_note, (attack_first_note < 0.04));
end

end

