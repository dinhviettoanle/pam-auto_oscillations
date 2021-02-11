%% Approche Modale - Système à 5 modes

close all;
clear;
clear textprogressbar;

l = 0.37;
R = 3e-2;

%% Constants
Pabsc = linspace(0, l, 2);
Prayon = ones(1, 2) * R; 

rho0 = 1.225;
c = 340;


%% Impédance entrée

freq_th = linspace(1, 4000, 5000);
Z_th = zeros(1, 5000);

for i = 1:length(freq_th)
    f = freq_th(i);
    Z_th(i) = impedance_ramenee(f, Pabsc, Prayon, false);
end

S_out = pi * R^2;
Z_th = Z_th * S_out/(rho0*c);

figure;
subplot(2,1,1);
plot(freq_th, abs(Z_th));
xlabel('Fréquence (Hz)');
ylabel('Impédance adimensionnée');
title("Impédance d'entrée");
grid on;

subplot(2,1,2); 
plot(freq_th, angle(Z_th));
xlabel('Fréquence (Hz)');
ylabel('Phase');
grid on;

%% Recherche frequences de resonnance
Fs = 8000;

[height_peaks_th, index_peaks_th] = findpeaks(abs(Z_th));
frq_peaks_th = index_peaks_th * (Fs/2)/length(Z_th);

figure;
plot(freq_th, abs(Z_th));
hold on;
scatter(frq_peaks_th, abs(Z_th(index_peaks_th)));
xlabel('Fréquence (Hz)');
ylabel('Impédance adimensionnée');
title("Fréquences de résonnance");
grid on;


%% Calcul des fréquences et facteurs de qualite

ifft_z = real(irfft(Z_th));
[frq_res_esprit, damping_esprit] = esprit(ifft_z, 1500, 30);

frq_res_esprit = frq_res_esprit * Fs + freq_th(1);
Q_esprit = -1./(2*damping_esprit);
    
%%
figure
plot(freq_th, abs(Z_th))
for i = 1:length(frq_res_esprit)
    f = frq_res_esprit(i);
    if f > 0
        hold on;
        plot([f,f], [0,60], '--g');
    end
end
title("Fréquences trouvées par ESPRIT");


%% Attribution frq / Q

list_frq_pos = zeros(length(frq_res_esprit), 1);
list_Q_pos = zeros(length(frq_res_esprit), 1);

% Choix des frequences que positives
n = 1;
for i = 1:length(frq_res_esprit)
    if(frq_res_esprit(i) > 10)
        list_frq_pos(n) = frq_res_esprit(i);
        list_Q_pos(n) = Q_esprit(i);
        n = n + 1;
    end
end

% Suppression des doublons avec tolerance
list_frq = zeros(length(frq_res_esprit), 1);
list_Q = zeros(length(frq_res_esprit), 1);
tol = 50;
n_added = 1;

for i = 1:length(list_frq_pos)
    current_frq = list_frq_pos(i);
    current_Q = list_Q_pos(i);
    for j = 1:length(list_frq)
        if abs(list_frq(j) - current_frq) < tol
            list_frq(j) = mean([current_frq, list_frq(j)]);
            list_Q(j) = mean([current_Q, list_Q(j)]); % Mouais
            break;
        end
        if j == length(list_frq)
            list_frq(n_added) = current_frq;
            list_Q(n_added) = current_Q;
            n_added = n_added + 1;
        end
    end
end


% Tri des listes f et Q
matrix_frq_Q = [list_frq, list_Q];


[~,idx] = sort(matrix_frq_Q(:,1)); % sort just the first column
matrix_frq_Q_sorted = matrix_frq_Q(idx,:);   % sort the whole matrix using the sort indices

%%
figure
plot(freq_th, abs(Z_th))
for i = 1:length(list_frq)
    f = list_frq(i);
    if f > 0
        hold on;
        plot([f,f], [0,60], '--g');
    end
end
title("Fréquences choisies");

%%

res = zeros(5, 3);
n = 1;
for j = 1:length(list_frq)
    if matrix_frq_Q_sorted(j,1) > 50
        res(n,1) = 2*pi*matrix_frq_Q_sorted(j,1);
        res(n,2) = matrix_frq_Q_sorted(j,2);
        res(n,3) = 2*c/l;
        n = n + 1;
    end
    if n > 5
        break
    end
end









