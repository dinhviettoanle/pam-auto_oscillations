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
descriptor = @(x) descriptor_has_oscillations(x(:,1), x(:,2), res, t_end, Fs);

for i=1:N_init_samples
    classes(i) = descriptor(init_samples(i,:));
%     figure;
%     plot(final_pressure);
%     title(["gamma : ", gamma," ; zeta : ", zeta]);
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
figure;
svm_col{end}.isoplot
axis equal;


