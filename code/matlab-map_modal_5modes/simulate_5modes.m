function [t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs)

%GET_SIGNAL_5_MODES Summary of this function goes here
%   Detailed explanation goes here

fprintf("***** Simulation with gamma = %f ; zeta = %f *****\n", gamma, zeta)
sigma = 1e-3;

options = odeset('AbsTol',1e-4, 'RelTol', 1e-4);

X0 = [0.01;0; 0.01;0; 0.01;0; 0.01;0; 0.01;0]; % Condition init

tspan = linspace(0, t_end, t_end*Fs);

ode = @(t,p) systdyn_5modes(t, p, res, gamma, zeta, sigma);
[t, X] = ode45(ode, tspan, X0, options);
end

