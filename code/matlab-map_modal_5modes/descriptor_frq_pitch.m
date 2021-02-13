function [main_frq] = descriptor_frq_pitch(gamma, zeta, res, t_end, Fs, FRQ_REF, NOTES)
%DESCRIPTOR_FRQ_PITCH Descripteur de valeur de la fréquence fondamentale du signal
%   Renvoie la fréquence fondamentale du signal (via mirpitch) 
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

fprintf("Frq : %f \n", main_frq);
end

