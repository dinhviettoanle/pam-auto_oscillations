function [t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs)
%SIMULATE_5MODES Simule le son de l'instrument a 5 modes a paramtres constants
% Resolution via ode45
% Inputs :
%   gamma : Paramètre de pression dans la bouche adim
%   zeta : Paramètre d'anche adim
%   res : Matrice de taille N_MODES x 3 tel que :
%       res(i,1) : pulsation du mode i
%       res(i,2) : coeff de qualite du mode i
%       res(i,3) : facteur modal du mode i
%   t_end : Temps de fin de simulation
%   Fs : Fréquence d'échantillonnage
% Outputs :
%   t : Pas de temps calcules (pas forcement équitablement répartis)
%   X : Vecteur de taille n_samples x 10 tel que
%       X(t, 1) : Pression du mode 1 (idem pour 3,5,7,9)
%       X(t, 2) : Dérivée de la pression du mode 1 (idem pour 4,6,8,10)


fprintf("***** Simulation with gamma = %f ; zeta = %f *****\n", gamma, zeta)
sigma = 1e-3;

options = odeset('AbsTol',1e-4, 'RelTol', 1e-4);

X0 = [0.01;0; 0.01;0; 0.01;0; 0.01;0; 0.01;0]; % Condition init

tspan = linspace(0, t_end, t_end*Fs);

ode = @(t,p) systdyn_5modes(t, p, res, gamma, zeta, sigma);
[t, X] = ode45(ode, tspan, X0, options);
end

