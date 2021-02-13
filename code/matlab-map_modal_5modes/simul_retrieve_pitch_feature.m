function [note_name, f_tampered, main_frq, n_cents] = simul_retrieve_pitch_feature(gamma, zeta, res, t_end, Fs, FRQ_REF, NOTES)
%SIMUL_RETRIEVE_PITCH_FEATURE Renvoie des elements de description du signal en termes de pitch
% Inputs :
%   gamma : Paramètre de pression dans la bouche adim
%   zeta : Paramètre d'anche adim
%   res : Matrice de taille N_MODES x 3 tel que :
%       res(i,1) : pulsation du mode i
%       res(i,2) : coeff de qualite du mode i
%       res(i,3) : facteur modal du mode i
%   t_end : Temps de fin de simulation
%   Fs : Fréquence d'échantillonnage
%   FRQ_REF : Fréquences de référence de la gamme tempérée
%   NOTES : Nom des notes
% Outputs : 
%   note_name : Nom de la note en str
%   f_tampered : Fréquence la plus proche de la gamme tempérée
%   main_frq : Fréquence fondamentale du signal
%   n_cents : Nombre de cents de déviation par rapport à la gamme tempérée


[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

% Recherche de la frequence propre
main_frq = mirgetdata(mirpitch(miraudio(p, Fs), 'Total', 1));
% fprintf("main frq : %f| ", main_frq);

% Recherche de la note de la gamma temperee la plus proche
[note_name, f_tampered] = utils_find_note(main_frq, FRQ_REF, NOTES); 

% Calcul de l'out of tuness
ratio_tampered = abs(main_frq/f_tampered);
n_cents = 1200*log(ratio_tampered)/log(2);

% fprintf("delta cents : %f -> %i \n", n_cents, (abs(n_cents) < 10));

end