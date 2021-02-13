function [svm_saved] = make_one_map(res, x1_min, x1_max, x2_min, x2_max, N_init_samples, N_edsd, title_plot, svm_saved, index)
%MAKE_ONE_MAP Genere une cartographie avec SVM
%   Rajoute a une liste de SVM sauvegardees la nouvelle map
% Inputs :
%   res : Pulsations, Q, F des modes du resonateur
%   x1_min : Valeur minimale en x (en pratique, gamma_min)
%   x1_max : Valeur maximale en x (en pratique, gamma_max)
%   x2_min : Valeur minimale en x (en pratique, zeta_min)
%   x2_max : Valeur maximale en x (en pratique, zeta_max)
%   N_init_samples : Nombre de samples dans le carre latin pour initialiser le SVM
%   N_edsd : Nombre de samples pour affiner le SVM via EDSD
%   title_plot : Titre du plot
%   svm_saved : Liste de SVM cell ou on sauvegarde toutes nos SVM
%   index : Position de la nouvelle map generee dans svm_saved

    init_samples = lhsdesign(N_init_samples,2);
    init_samples(:,1) = init_samples(:,1) * (x1_max - x1_min) + x1_min;
    init_samples(:,2) = init_samples(:,2) * (x2_max - x2_min) + x2_min;

    classes = zeros(N_init_samples, 1);
    
    t_end = 6;
    Fs = 44100;

    % >>> Changer ici l'axe et le descripteur <<<
    % descriptor = @(x) descriptor_has_oscillations(x(:,1), x(:,2), res, t_end, Fs, false);
    descriptor = @(x) descriptor_periodic(x(:,1), x(:,2), res, t_end, Fs, false);
    % descriptor = @(x) descriptor_has_oscillations(gamma_i, zeta_i, init_resonator_fun(x(:,1), init_resonator_fun(x(:,2), t_end, Fs);


    for i=1:N_init_samples
        classes(i) = descriptor(init_samples(i,:));
        fprintf("(%i) INITIAL : %i / %i done\n", index, i, N_init_samples);
    end
  
    try
        % Plot initial map + SVM
        svm = CODES.fit.svm(init_samples, classes);
        
        % Adaptive samples
        svm_col = CODES.sampling.edsd(descriptor, svm, [x1_min x2_min], [x1_max x2_max], 'iter_max', N_edsd, 'conv', false);
        svm_final = svm_col{end};
        
        %
        figure;
        svm_final.isoplot;
        xlabel("$\gamma$", "Interpreter", "latex");
        ylabel("$\zeta$", "Interpreter", "latex");
        title(title_plot);
        axis equal;
        drawnow();

        svm_saved{index} = svm_final;
    catch
        fprintf("ERROR CAUGHT : Needs labels from both class \n"); 
        svm_saved{index} = [];
    end
        

end

