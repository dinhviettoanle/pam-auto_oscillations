%% Init resonator
close all;
clear;

run("init_resonator");

%% Initial samples
N_init_samples = 20;
t_end = 2;
Fs = 44100;

init_samples = lhsdesign(N_init_samples,2); % [(gamma, zeta)]
classes = zeros(N_init_samples, 1);

% warning('off', 'MATLAB:ode15s:IntegrationTolNotMet');

% descriptor = @(x) descriptor_has_oscillations(x(:,1), x(:,2), res, t_end, Fs);
% descriptor = @(x) descriptor_itg_instable(x(:,1), x(:,2), res, t_end, Fs);
% descriptor = @(x) descriptor_periodic(x(:,1), x(:,2), res, t_end, Fs);


for i=1:N_init_samples
    classes(i) = descriptor(init_samples(i,:));
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

svm_col = CODES.sampling.edsd(descriptor, svm, [0 0], [1 1], 'iter_max', 50, 'conv', false);

%%
figure;
svm_col{end}.isoplot;
xlabel("$\gamma$", "Interpreter", "latex");
ylabel("$\zeta$", "Interpreter", "latex");
axis equal;

%%%%% !! Save if needed !! %%%%%

%% Test unique

gamma = 0.64;
zeta = 0.46;

[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

figure;
plot(linspace(0, t_end, t_end*Fs), p)

figure;
plot(linspace(0, t_end, t_end*Fs), p.^2);


