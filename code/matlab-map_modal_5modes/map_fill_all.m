%% Init
close all;
clear;

t_end = 2;
Fs = 44100;

N_SPLIT1 = 20;
N_SPLIT2 = 20;

COMPUTE_ALL = false;

% !!!! Si un des axes est la longueur, l_min = 18cm (sinon, partiels trop
% aigus, hors de portée pour l'impédance
x1_min = 0;
x1_max = 1;
x2_min = 0;
x2_max = 1;

x1_list = linspace(x1_min, x1_max, N_SPLIT1);
x2_list = linspace(x2_min, x2_max, N_SPLIT2);

%% Constants

R = 3e-2;
gamma = 0.42;
zeta = 0.15;
% l = 0.4934;
l = 0.37; % apparemment que du quasi periodique
[FRQ_REF, NOTES] = utils_generate_frq_notes();

%% Main loop

feature = zeros(N_SPLIT2, N_SPLIT1) * nan;
feature_ex = zeros(N_SPLIT2, N_SPLIT1) * nan;

load("saved maps/descriptor_has_oscillations-svm.mat");

figure(1);
figure(2);
for i = 1:N_SPLIT1
    for j = 1:N_SPLIT2
        % >>> Change here to choose different axis <<<
        gamma = x1_list(i);
        zeta = x2_list(j);
        fprintf("x1 = %f | x2 = %f\n", x1_list(i), x2_list(j));
        
        if COMPUTE_ALL || (svm_final.eval([gamma, zeta]) > 0)
            res = init_resonator_fun(l, R);

            % >>> Change here to choose another descriptor <<<
%             [feature(j,i), feature_ex(j,i)] = descriptor_nearest_pitch(gamma, zeta, res, t_end, Fs, FRQ_REF, NOTES);
%             feature(j,i) = descriptor_periodic(gamma, zeta, res, t_end, Fs, true);
%             feature(j,i) = descriptor_in_tune(gamma, zeta, res, t_end, Fs, 164.8137784564349, true);
            feature(j,i) = descriptor_mir(gamma, zeta, res, t_end, Fs);

            % === PLOTS ===
            figure(1);
            plot_char_map(x1_list, x2_list, feature);
%             figure(2);
%             plot_char_map(x1_list, x2_list, feature_ex);
% 
%               figure(1);
%               plot_2d_curve(x1_list, feature);
%               figure(2);
%               plot_2d_curve(x1_list, feature_ex);
        end
    end
end



%% Plot Colormap 

figure;
plot_char_map(x1_list, x2_list, feature);

[X1, X2] = meshgrid(x1_list, x2_list);
figure;
scatter3(reshape(X1, [1,N_SPLIT1 * N_SPLIT2]), reshape(X2, [1,N_SPLIT1 * N_SPLIT2]), ...
    reshape(feature, [1, N_SPLIT1 * N_SPLIT2]), '.');

%% Plot 2D Curve

figure(1);
plot_2d_curve(x1_list, feature);
figure(2);
plot_2d_curve(x1_list, feature_ex);

%% Test unique

% Periodique
gamma = 0.7; 
zeta = 0.3;

gamma = 0.747998947602689; % Limite de domaine
zeta = 0.444117533634140;

gamma = 0.8;
zeta = 0.3;

% Quasi periodique
gamma = 0.4;
zeta = 0.89;

gamma = 0.766339983140049;
zeta = 0.494809986252063;

% pour l =0.37
% gamma = 0.641025602817535;
% zeta = 0.205128192901611;

% Frequence chelou
% gamma = 0.42;
% zeta = 0.15;

l = 0.37;
R = 3e-2;
%%
res = init_resonator_fun(l, R);

[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

figure;
plot(p);

figure;
snd_plot = (p.^2)/mean(p.^2);
plot(snd_plot);
hold on;
plot([0.75*length(snd_plot), 0.75*length(snd_plot)], [0, max(snd_plot)]);
descriptor_periodic(gamma, zeta, res, t_end, Fs, true);

% --- MIR Toolbox ---
% mirgetdata(mirscalar) -> ce qu'on veut
% a = miraudio(p,Fs) -> MIRobject
% mirattacktime


%%
function [] = plot_char_map(gamma_list, zeta_list, characteristics)
    % data = (characteristics - 164.814)/164.814;
    data = characteristics;
    p = imagesc(gamma_list, zeta_list, data);
    xlabel('$x_1$', 'Interpreter', 'latex');
    ylabel('$x_2$', 'Interpreter', 'latex');
    set(p,'AlphaData',~isnan(data));
    set(gca,'YDir','normal');
    colorbar;
    drawnow();
end


function [] = plot_2d_curve(gamma_list, characteristics)
    plot(gamma_list, characteristics, "o");
    xlabel('$x_1$', 'Interpreter', 'latex');
    xlim([gamma_list(1), gamma_list(end)]);
    drawnow();
end