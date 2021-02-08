function [svm_saved] = make_one_map(res, x1_min, x1_max, x2_min, x2_max, N_init_samples, N_edsd, title_plot, svm_saved, index)
%MAKE_ONE_MAP Summary of this function goes here
%   Detailed explanation goes here

    init_samples = lhsdesign(N_init_samples,2);
    init_samples(:,1) = init_samples(:,1) * (x1_max - x1_min) + x1_min;
    init_samples(:,2) = init_samples(:,2) * (x2_max - x2_min) + x2_min;

    classes = zeros(N_init_samples, 1);
    
    t_end = 2;
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

