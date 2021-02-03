%% Init resonator
close all;
clear;

% Paramètres instruments
l = 0.5042;
R = 3e-2;

run("init_resonator");

% Inharmonicité des modes
% res(2,1) = 1.5*res(2,1); 
%% Initial samples

min_gamma = 0;
max_gamma = 1;
min_zeta = 0;
max_zeta = 1;

N_init_samples = 50;
t_end = 2;
Fs = 44100;

init_samples = lhsdesign(N_init_samples,2); % [(gamma, zeta)]
init_samples(:,1) = init_samples(:,1) * (max_gamma - min_gamma) + min_gamma;
init_samples(:,2) = init_samples(:,2) * (max_zeta - min_zeta) + min_zeta;

classes = zeros(N_init_samples, 1);

% warning('off', 'MATLAB:ode15s:IntegrationTolNotMet');

descriptor = @(x) descriptor_has_oscillations(x(:,1), x(:,2), res, t_end, Fs);
% descriptor = @(x) descriptor_itg_instable(x(:,1), x(:,2), res, t_end, Fs);
% descriptor = @(x) descriptor_periodic(x(:,1), x(:,2), res, t_end, Fs);
% descriptor = @(x) descriptor_in_tune(x(:,1), x(:,2), res, t_end, Fs);


for i=1:N_init_samples
    classes(i) = descriptor(init_samples(i,:));
    fprintf("INITIAL : %i / %i done\n", i, N_init_samples);
end

disp("*** Done ! ***")

%% Plot initial map + SVM
figure;
svm = CODES.fit.svm(init_samples, classes);
svm.isoplot;
xlabel("$\gamma$", "Interpreter", "latex");
ylabel("$\zeta$", "Interpreter", "latex");
axis equal;

%% Adaptive samples

N_edsd = 100;
svm_col = CODES.sampling.edsd(descriptor, svm, [min_gamma min_zeta], [max_gamma max_zeta], 'iter_max', N_edsd, 'conv', false);

%%
figure;
svm_col{end}.isoplot;
xlabel("$\gamma$", "Interpreter", "latex");
ylabel("$\zeta$", "Interpreter", "latex");
axis equal;

%%%%% !! Save if needed !! %%%%%

%% Test unique

gamma = 0.04;
zeta = 0.8;

[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

figure;
plot(linspace(0, t_end, t_end*Fs), p)

figure;
plot(linspace(0, t_end, t_end*Fs), p.^2);



