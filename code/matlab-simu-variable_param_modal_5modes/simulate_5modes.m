function [t, X] = simulate_5modes(t_end, Fs)

%GET_SIGNAL_5_MODES Summary of this function goes here
%   Detailed explanation goes here

load all_res.mat all_res;
fprintf("Pre-process done ! \n ");

% fprintf("Simulation with gamma = %f ; zeta = %f \n", gamma, zeta)
sigma = 1e-9;

options = odeset('AbsTol',1e-4, 'OutputFcn',@odetpbar);
% options = odeset('AbsTol',1e-4, 'OutputFcn',@odeplot);

X0 = [0.01;0; 0.01;0; 0.01;0; 0.01;0; 0.01;0; 0.4;0.1]; % Condition init, gamma, zeta
% X0 = [0.01;0; 0.01;0; 0;0];

tspan = linspace(0, t_end, t_end*Fs);
 
% res = init_resonator_fun(0.5, 3e-2);

ode = @(t,p) systdyn_5modes(t, p, res_evol(t, all_res), gamma_evol(t), zeta_evol(t), sigma);
[t, X] = ode45(ode, tspan, X0, options);
end

