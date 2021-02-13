%% Generation d'une carte par SVM et EDSD

%% Init
close all;
clear;

t_end = 6;
Fs = 44100;
N_init_samples = 25;
N_edsd = 75;

x1_min = 0; % En pratique, gamma_min
x1_max = 1;
x2_min = 0; % En pratque, zeta_min
x2_max = 1;


%% Constants
% Forcément deux initialisations qui ne servent à rien  
R = 3e-2;
gamma = 0.42;
zeta = 0.15;
l = 0.37;
res = init_resonator_fun(l, R);
[FRQ_REF, NOTES] = utils_generate_frq_notes();

%% Init samples

init_samples = lhsdesign(N_init_samples,2);
init_samples(:,1) = init_samples(:,1) * (x1_max - x1_min) + x1_min;
init_samples(:,2) = init_samples(:,2) * (x2_max - x2_min) + x2_min;

classes = zeros(N_init_samples, 1);

% >>> Changer ici l'axe et le descripteur <<<
% Descripteurs OK
% descriptor = @(x) descriptor_has_oscillations(x(:,1), x(:,2), res, t_end, Fs, false);
% descriptor = @(x) descriptor_periodic(x(:,1), x(:,2), res, t_end, Fs, false);
% descriptor = @(x) descriptor_attack_time(x(:,1), x(:,2), res, t_end, Fs, false);
% Descripteurs en test
descriptor = @(x) descriptor_in_tune(x(:,1), x(:,2), res, t_end, Fs, 164.8137784564349, false);
% descriptor = @(x) descriptor_diverge(x(:,1), x(:,2), res, t_end, Fs, false);


for i=1:N_init_samples
    classes(i) = descriptor(init_samples(i,:));
    fprintf("INITIAL : %i / %i done\n", i, N_init_samples);
end

%% Plot initial map + SVM
figure;
svm = CODES.fit.svm(init_samples, classes);
svm.isoplot;
xlabel("$\gamma$", "Interpreter", "latex");
ylabel("$\zeta$", "Interpreter", "latex");
axis equal;
drawnow();

%% Adaptive samples

svm_col = CODES.sampling.edsd(descriptor, svm, [x1_min x2_min], [x1_max x2_max], 'iter_max', N_edsd, 'conv', false);
svm_final = svm_col{end};

%% Plot final SVM + EDSD
figure;
svm_final.isoplot;
xlabel("$\gamma$", "Interpreter", "latex");
ylabel("$\zeta$", "Interpreter", "latex");
axis equal;

%%%%% !! Save if needed !! %%%%%

%% Test unique

t_end = 6;
Fs = 44100;

% gamma = 0.9; zeta = 0.4; % Periodique
gamma = 0.5; zeta = 0.7; % Quasi periodique ??

res = init_resonator_fun(l, R);

[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

figure;
plot(linspace(0, t_end, t_end*Fs), p)

figure;
plot(linspace(0, t_end, t_end*Fs), p.^2);
hold on;
plot([0.75*t_end, 0.75*t_end], [0, max(p.^2)]);

descriptor_periodic(gamma, zeta, res, t_end, Fs, false);