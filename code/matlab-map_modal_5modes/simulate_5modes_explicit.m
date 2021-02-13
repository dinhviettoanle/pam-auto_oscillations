function [t, X] = simulate_5modes_explicit(gamma, zeta, res, t_end, Fs)
%SIMULATE_5MODES Simule le son de l'instrument a 5 modes a paramtres constants
% Resolution Runge-Kutta 4 ou Euler explicite (mais bof)
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
%   t : Pas de temps calcules
%   X : Vecteur de taille n_samples x 10 tel que
%       X(t, 1) : Pression du mode 1 (idem pour 3,5,7,9)
%       X(t, 2) : Dérivée de la pression du mode 1 (idem pour 4,6,8,10)


X0 = [0.01;0; 0.01;0; 0.01;0; 0.01;0; 0.01;0]; % Condition init, gamma, zeta

% -- Pour un resonateur fixe --
ode = @(t,p) systdyn_5modes(t, p, res, gamma, zeta, 1e-3);

h = 1/Fs;

X = zeros(t_end*Fs, 10);
t = linspace(0, t_end, t_end*Fs)';
 

X(1,:) = X0;
Nsteps = t_end*Fs;

for n = 1:Nsteps-1
    tn = n/Fs;
    Xn = X(n,:);
    
    % RK4
%     k1 = ode(tn, Xn)';
%     k2 = ode(tn + 0.5*h, Xn + 0.5*h*k1)';
%     k3 = ode(tn + 0.5*h, Xn + 0.5*h*k2)';
%     k4 = ode(tn + h, Xn + h*k3)';
%     X(n+1, :) = Xn + h/6 * (k1 + 2*k2 + 2*k3 + k4);
    
    % Euler forward
    X(n+1,:) = Xn + h*ode(tn, Xn)'; 
end


end

