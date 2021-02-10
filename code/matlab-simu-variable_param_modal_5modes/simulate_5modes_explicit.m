function [t, X] = simulate_5modes_explicit(t_end, Fs)


X0 = [0.01;0; 0.01;0; 0.01;0; 0.01;0; 0.01;0; 0;0]; % Condition init, gamma, zeta


% -- Pour un resonateur variable --
% ode = @(t,p) systdyn_5modes(t, p, res_evol(t, all_res), gamma_evol(t), zeta_evol(t), sigma);

% -- Pour un resonateur fixe --
res = init_resonator_fun(0.37, 3e-2);
ode = @(t,p) systdyn_5modes(t, p, res, gamma_evol(t), zeta_evol(t));

h = 1/Fs;

X = zeros(t_end*Fs, 12);
t = linspace(0, t_end, t_end*Fs)';
 

X(1,:) = X0;
Nsteps = t_end*Fs;

textprogressbarconsole('Computing Runge-Kutta 4... ');
for n = 1:Nsteps-1
    tn = n/Fs;
    Xn = X(n,:);
    
    % RK4
    k1 = ode(tn, Xn)';
    k2 = ode(tn + 0.5*h, Xn + 0.5*h*k1)';
    k3 = ode(tn + 0.5*h, Xn + 0.5*h*k2)';
    k4 = ode(tn + h, Xn + h*k3)';
    X(n+1, :) = Xn + h/6 * (k1 + 2*k2 + 2*k3 + k4);
    
%     X(n+1,:) = Xn + h*ode(tn, Xn)'; % Euler forward

    textprogressbarconsole(n/Nsteps);
end
textprogressbarconsole('Done',true);



end

