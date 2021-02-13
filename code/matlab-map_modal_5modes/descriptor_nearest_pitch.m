function [f_tampered, n_cents] = descriptor_nearest_pitch(gamma, zeta, res, t_end, Fs, FRQ_REF, NOTES)
%DESCRIPTOR_NEAREST_PITCH Descripteur de la note de la gamme tempérée la plus proche
%   Renvoie la fréquence de la gamme tempérée la plus proche et sa justesse
%   en nombre de cents
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


[note_name, f_tampered, main_frq, n_cents] = simul_retrieve_pitch_feature(gamma, zeta, res, t_end, Fs, FRQ_REF, NOTES);

fprintf("Main frq : %f | Nearest : %s | Delta cents : %f \n", main_frq, note_name, n_cents);
end

