%% Approche Modale - Système à 5 modes

close all;
clear;
clear textprogressbar;

%% Constants
R0 = 3e-2;
R1 = 3e-2;
l = 0.5;

N_sub_perce = 2;
Pabsc = linspace(0, l, N_sub_perce);
Prayon = R0 * (l - Pabsc)/l + R1 * Pabsc/l; 

rho0 = 1.225;
c = 340;

figure;
plot(Pabsc, Prayon, "-o");
hold on;
plot(Pabsc, -Prayon, "-o");


%% Impédance entrée

freq_th = linspace(1, 4000, 5000);
Z_th = zeros(1, 5000);

for i = 1:length(freq_th)
    f = freq_th(i);
    Z_th(i) = impedance_ramenee(f, Pabsc, Prayon, false);
end

S_out = pi * R1^2;
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

list_frq = zeros(1,5);
list_Q = zeros(1,5);

alpha = 1.044;
mu = 1.708e-5;


for i = 1:5
    frq_th = frq_peaks_th(i);
    list_frq(i) = frq_th;
    gamma_n = (2*i-1)*pi/2;
    k_n = gamma_n / l;
    list_Q(i) = 1/((2*alpha)/R0 * sqrt(mu*l/(rho0*gamma_n*c)) + 0.5 * (k_n*R0)^2/gamma_n);
end
    
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


%% Attribution frq / Q
list_F = ones(1,12) * (2*c/0.5); % facteurs modaux

res = zeros(5, 3);
for j = 1:5
    res(j,1) = 2*pi*list_frq(j);
    res(j,2) = list_Q(j);
    res(j,3) = list_F(j);
end



%% Modélisation excitateur
gamma = 0.35;
zeta = 0.4;

t_end = 2;
Fs = 44100;

[t, X] = simulate_5modes_constant(gamma, zeta, res, t_end, Fs);
final_pressure = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);


figure;
plot(t, final_pressure);
xlabel('t');
ylabel('$\sum p(t)$', 'Interpreter', 'latex');
title('Simulation 5 modes');

figure;
specgram(final_pressure, 2048, Fs);

plot_spectrum(final_pressure, Fs);
%% Audio Output
filename = "sys5_modes_simu.wav";
audiowrite(filename, final_pressure, Fs);

%% Audio Play
soundsc(final_pressure, Fs);








