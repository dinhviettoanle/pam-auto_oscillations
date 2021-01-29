%% Approche Modale - Système à 5 modes

close all;
clear all;

%% Constants
R = 0.014;
Pabsc = linspace(0, 0.5, 2);
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
[frq_res_esprit, damping_esprit] = esprit(ifft_z, 1500, 10);

frq_res_esprit = frq_res_esprit * Fs + freq_th(1);
Q_esprit = -1./(2*damping_esprit);

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
list_frq = sort(frq_res_esprit(1:2:end), 'ascend'); % tri des frq par ordre croissant
list_Q = sort(Q_esprit(1:2:end), 'descend'); % tri des Q par ordre decroissant
list_F = ones(1,12) * (2*c/0.5); % facteurs modaux

res = zeros(5, 3);
for j = 1:5
    res(j,1) = 2*pi*list_frq(j);
    res(j,2) = list_Q(j);
    res(j,3) = list_F(j);
end



%% Modélisation excitateur
gamma = 0.47;
zeta = 0.15;

t_end = 2;
Fs = 44100;

[t, X] = get_signal_5_modes(gamma, zeta, res, t_end, Fs);
final_pressure = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);


figure;
plot(t, final_pressure);
xlabel('t');
ylabel('$\sum p(t)$', 'Interpreter', 'latex');
title('Simulation 5 modes');

figure;
specgram(final_pressure, 2048, Fs);

%% Audio Output
filename = "sys5_modes.wav";
audiowrite(filename, final_pressure, Fs);

%% Audio Play
soundsc(final_pressure, Fs);









