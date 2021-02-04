%% Init
close all;
clear;

t_end = 2;
Fs = 44100;

N_SPLIT1 = 10;
N_SPLIT2 = 10;

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
l = 0.5;
[FRQ_REF, NOTES] = utils_generate_frq_notes();

%% Main loop

feature = zeros(N_SPLIT2, N_SPLIT1) * nan;

for i = 1:N_SPLIT1
    for j = 1:N_SPLIT2
        % >>> Change here to choose different axis <<<
        gamma = x1_list(i);
        zeta = x2_list(j);
        
        res = init_resonator_fun(l, R);
        
        % >>> Change here to choose another descriptor <<<
        feature(j,i) = descriptor_frq_pitch(gamma, zeta, res, t_end, Fs, FRQ_REF, NOTES);
        
        
        plot_char_map(x1_list, x2_list, feature);
    end
end



%% 
figure;
plot_char_map(x1_list, x2_list, feature);

[X1, X2] = meshgrid(x1_list, x2_list);
figure;
scatter3(reshape(X1, [1,N_SPLIT1 * N_SPLIT2]), reshape(X2, [1,N_SPLIT1 * N_SPLIT2]), ...
    reshape(feature, [1, N_SPLIT1 * N_SPLIT2]), '.');
%% Test unique

% Periodique
gamma = 0.8; 
zeta = 0.8;

% Quasi periodique
% gamma = 0.4;
% zeta = 0.5;

[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

figure;
plot(p - mean(p));

figure;
plot((p - mean(p)).^2);


% --- MIR Toolbox ---
% mirgetdata(mirscalar) -> ce qu'on veut
% a = miraudio(p,Fs) -> MIRobject
% mirattacktime


%%
function [] = plot_char_map(gamma_list, zeta_list, characteristics)
    % data = (characteristics - 164.814)/164.814;
    data = characteristics;
    p = imagesc(gamma_list, zeta_list, data);
    xlabel('$\gamma$', 'Interpreter', 'latex');
    ylabel('$\zeta$', 'Interpreter', 'latex');
    set(p,'AlphaData',~isnan(data));
    set(gca,'YDir','normal');
    colorbar;
    drawnow();
end