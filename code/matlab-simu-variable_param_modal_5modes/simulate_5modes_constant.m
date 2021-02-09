function [t, X] = simulate_5modes_constant(gamma, zeta, res, t_end, Fs)

%GET_SIGNAL_5_MODES Summary of this function goes here
%   Detailed explanation goes here

fprintf("Simulation with gamma = %f ; zeta = %f \n", gamma, zeta)
sigma = 1e-9;

options = odeset('AbsTol',1e-4, 'OutputFcn',@odetpbar);
% options = odeset('AbsTol',1e-4, 'OutputFcn',@odeplot);

X0 = [0.01;0; 0.01;0; 0.01;0; 0.01;0; 0.01;0; 0.4;0.1]; % Condition init, gamma, zeta
% X0 = [0.01;0; 0.01;0; 0;0];

tspan = linspace(0, t_end, t_end*Fs);
 

ode = @(t,p) systdyn_5modes(t, p, res, gamma, zeta, sigma);
[t, X] = ode45(ode, tspan, X0, options);
end

