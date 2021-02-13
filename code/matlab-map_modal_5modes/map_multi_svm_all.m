%% Génération de plusieurs map pour des resonateurs différents
% Donc pour des longueurs de tubes différents

%% Init
close all;
clear;

% Liste de longueurs tels que la fréquence fondamentale est a peu pres in tune
load in_tune_lengths.mat lengths_list;

N_init_samples = 25;
N_edsd = 75;

x1_min = 0;
x1_max = 1;
x2_min = 0;
x2_max = 1;


%% Constants

R = 3e-2;
svm_saved = {}; % Si on commence une nouvelle etude, pour stocker les differents svm
load("descriptor_quasi_periodic-multi_svm.mat", "svm_saved"); % Sinon, charger ce qui a déjà été fait
[FRQ_REF, NOTES] = utils_generate_frq_notes();


%% Main loop
for i = 1:length(lengths_list)
    l = lengths_list(i);
    res = init_resonator_fun(l, R);
    svm_saved = make_one_map(res, x1_min, x1_max, x2_min, x2_max, N_init_samples, N_edsd, "l = " + l, svm_saved, i);
    save("descriptor_quasi_periodic-multi_svm.mat", "svm_saved");
end


%% Plot all in different windows
close all;

% load descriptor_quasi_periodic-multi_svm.mat svm_saved
% load in_tune_lenghts lengths_list

for i = 1:length(svm_saved)
    if ~isempty(svm_saved{i})
        figure;
        svm_saved{i}.isoplot;
        xlabel("$\gamma$", "Interpreter", "latex");
        ylabel("$\zeta$", "Interpreter", "latex");
        title("l = " + lengths_list(i));
        axis equal;
        drawnow();
    end

end

%% Plot all in subplot

figure('units','normalized','outerposition',[0 0 1 1])
for i = 1:length(svm_saved)
    if ~isempty(svm_saved{i})
        subplot(6,5,i);
        svm_saved{i}.isoplot('legend', false, 'mpsty', 'r.', 'ppsty', 'b.', 'msvsty', 'r.', 'psvsty', 'b.');
        xlabel("$\gamma$", "Interpreter", "latex");
        ylabel("$\zeta$", "Interpreter", "latex");
        title("l = " + lengths_list(i));
%         axis equal;
%         drawnow();
    end

end