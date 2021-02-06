%% Init
close all;
clear;

t_end = 2;
Fs = 44100;
N_init_samples = 50;

x1_min = 0;
x1_max = 1;
x2_min = 0;
x2_max = 1;


%% Constants

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
% descriptor = @(x) descriptor_has_oscillations(x(:,1), x(:,2), res, t_end, Fs, false);
descriptor = @(x) descriptor_periodic(x(:,1), x(:,2), res, t_end, Fs, false);
% descriptor = @(x) descriptor_has_oscillations(gamma_i, zeta_i, init_resonator_fun(x(:,1), init_resonator_fun(x(:,2), t_end, Fs);


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

%% Adaptive samples

N_edsd = 100;
svm_col = CODES.sampling.edsd(descriptor, svm, [x1_min x2_min], [x1_max x2_max], 'iter_max', N_edsd, 'conv', false);
svm_final = svm_col{end};

%%
figure;
svm_final.isoplot;
xlabel("$\gamma$", "Interpreter", "latex");
ylabel("$\zeta$", "Interpreter", "latex");
axis equal;

%%%%% !! Save if needed !! %%%%%

%% 