function [is_in_tune] = descriptor_in_tune(gamma, zeta, res, t_end, Fs, frq_ref, FILL)
%DESCRIPTOR_IN_TUNE Descripteur de la justesse du signal
%   Compare la fréquence fondamentale à une fréquence de référence
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
%   frq_ref : fréquence de référence à laquelle comparer la fréquence fondamentale

[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

main_frq = mirgetdata(mirpitch(miraudio(p, Fs), 'Total', 1));

ratio_tampered = abs(main_frq/frq_ref);
n_cents = 1200*log(ratio_tampered)/log(2);

if FILL
    is_in_tune = n_cents;
else
   if n_cents < 20
       is_in_tune = 1;
   else
       is_in_tune = -1;
   end
end

fprintf("N cents : %f \n", n_cents); 
end

