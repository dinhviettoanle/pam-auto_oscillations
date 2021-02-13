function [feature] = descriptor_mir(gamma, zeta, res, t_end, Fs)
%DESCRIPTOR_MIR Descripteur a partir d'une fonction de la MIRtoolbox
%   Renvoie la valeur de la fonction de la MIRToolbox
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
mirobject = miraudio(p, Fs);

 char_computed = mirbrightness(mirobject, 'CutOff', 1000);
% char_computed = mirattacktime(mirobject);

feature = mirgetdata(char_computed);

feature = feature(1);
mirgetdata(char_computed)
end

