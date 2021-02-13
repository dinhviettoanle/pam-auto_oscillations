function [t, X] = simulate_5modes_explicit(t_end, Fs)
%SIMULATE_5MODES_EXPLICIT Simule le son de l'instrument a 1/3/5 modes a paramtres possiblement variables
% Resolution via Euleur explicite, RK2 ou RK4
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



% -- Pour un resonateur variable --
% ode = @(t,p) systdyn_5modes(t, p, res_evol(t, all_res), gamma_evol(t), zeta_evol(t), sigma);

% -- Pour un resonateur fixe --
res = init_resonator_pole(0.66, 3e-2);

% 1 mode
% ode = @(t,p) systdyn_1mode(t, p, res, gamma_evol(t), zeta_evol(t));
% X0 = [0.01;0; 0;0]; % Condition init, gamma, zeta
% X = zeros(t_end*Fs, 4);

% 3 modes
% ode = @(t,p) systdyn_3modes(t, p, res, gamma_evol(t), zeta_evol(t));
% X0 = [0.01;0; 0.01;0; 0.01;0; 0;0]; % Condition init, gamma, zeta
% X = zeros(t_end*Fs, 8);

% 5 modes
ode = @(t,p) systdyn_5modes(t, p, res, gamma_evol(t), zeta_evol(t));
X0 = [0.01;0; 0.01;0; 0.01;0; 0.01;0; 0.01;0; 0;0]; % Condition init, gamma, zeta
X = zeros(t_end*Fs, 12);



t = linspace(0, t_end, t_end*Fs)';
X(1,:) = X0;
Nsteps = t_end*Fs;
h = 1/Fs;

textprogressbarconsole('Computing simulation... ');
for n = 1:Nsteps-1
    tn = n/Fs;
    Xn = X(n,:);
    
    % Euler forward
%     X(n+1,:) = Xn + h*ode(tn, Xn)'; 


    % RK2
    k1 = ode(tn, Xn)';
    k2 = ode(tn + h, Xn + h*k1)';
    X(n+1,:) = Xn + h/2 * (k1 + k2);
    
    
    % RK4
%     k1 = ode(tn, Xn)';
%     k2 = ode(tn + 0.5*h, Xn + 0.5*h*k1)';
%     k3 = ode(tn + 0.5*h, Xn + 0.5*h*k2)';
%     k4 = ode(tn + h, Xn + h*k3)';
%     X(n+1, :) = Xn + h/6 * (k1 + 2*k2 + 2*k3 + k4);
    
    textprogressbarconsole(n/Nsteps);
end
textprogressbarconsole('Done',true);

res

end

