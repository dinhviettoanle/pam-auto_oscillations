function [t, X] = simulate_5modes(t_end, Fs)
%SIMULATE_5MODES Simule le son de l'instrument a 5 modes a paramtres possiblement variables
% Resolution via ode45
% Inputs :
%   t_end : Temps de fin de simulation
%   Fs : Fréquence d'échantillonnage
% Outputs :
%   t : Pas de temps calcules (pas forcement équitablement répartis)
%   X : Vecteur de taille n_samples x 12 tel que
%       X(t, 1) : Pression du mode 1 (idem pour 3,5,7,9)
%       X(t, 2) : Dérivée de la pression du mode 1 (idem pour 4,6,8,10)
%       ...
%       X(t, 11) : Integrale du temps de gamma
%       X(t, 12) : Integrale du temps de zeta

load all_res.mat all_res;
fprintf("Pre-process done ! \n ");

options = odeset('AbsTol',1e-4, 'OutputFcn',@odetpbar);

X0 = [0.01;0; 0.01;0; 0.01;0; 0.01;0; 0.01;0; 0.4;0.1]; % Condition init, gamma, zeta

tspan = linspace(0, t_end, t_end*Fs);
 
% -- Pour un resonateur variable --
% ode = @(t,p) systdyn_5modes(t, p, res_evol(t, all_res), gamma_evol(t), zeta_evol(t), sigma);

% -- Pour un resonateur fixe --
res = init_resonator_fun(0.37, 3e-2);
ode = @(t,p) systdyn_5modes(t, p, res, gamma_evol(t), zeta_evol(t));


[t, X] = ode45(ode, tspan, X0, options);
end

