%% Approche Modale - Système à 5 modes et résolution compatible real-time

close all;
clear;
clear textprogressbarconsole;

%% Simulation

t_end = 6;
Fs = 44100;

[t, X] = simulate_5modes_explicit(t_end, Fs);
% final_pressure = X(:,1);
% final_pressure = X(:,1) + X(:,3) + X(:,5);
final_pressure = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

%% Plots

% figure;
% plot(t, final_pressure);
% xlabel('t');
% ylabel('$\sum p(t)$', 'Interpreter', 'latex');
% title('Simulation 5 modes');
% 
% figure;
% plot((t(2:end)+t(1:(end-1)))/2, diff(X(:,end))./diff(t));
% xlabel('t');
% ylabel('$\gamma$', 'Interpreter', 'latex');


% load("descriptor_has_oscillations-svm");
load("descriptor_quasi_periodic-svm");

t_dlist = (t(2:end)+t(1:(end-1)))/2;
gamma_list = diff(X(:,end-1))./diff(t);
zeta_list = diff(X(:,end))./diff(t);
N_sub = 50;
 % Couleur en fonction du temps
colors = linspace(0, t_dlist(end), length(gamma_list(1:Fs/N_sub:end)));
% Couleur en fonction de l'amplitude de la pression
% colors = final_pressure(1:Fs/N_sub:end-1); 

figure;

subplot(3,1,1);
plot(t, final_pressure);
xlabel('t');
ylabel('$\sum p(t)$', 'Interpreter', 'latex');

subplot(3,1,2);
plot(t_dlist, gamma_list);
xlabel('t');
ylabel('$\gamma$', 'Interpreter', 'latex');
ylim([0 1]);

subplot(3,1,3);
plot(t_dlist, zeta_list);
xlabel('t');
ylabel('$\zeta$', 'Interpreter', 'latex');
ylim([0 1])


figure;
svm_final.isoplot('samples', false, 'legend', false, 'msvsty', 'r.', 'psvsty', 'b.');
plot(gamma_list(1:Fs/N_sub:end), zeta_list(1:Fs/N_sub:end),'k');
hold on;
scatter(gamma_list(1:Fs/N_sub:end), zeta_list(1:Fs/N_sub:end), 10, colors, 'filled');
xlabel('$\gamma$', 'Interpreter', 'latex');
ylabel('$\zeta$', 'Interpreter', 'latex');
xlim([0 1]);
ylim([0 1]);
cbar = colorbar;
ylabel(cbar, 'Time (s)');
% axis equal;

% 
% figure;
% specgram(final_pressure, 2048, Fs);
% 
% plot_spectrum(final_pressure, Fs);
%% Audio Output
% filename = "sys5_modes_var.wav";
% audiowrite(filename, final_pressure, Fs);

%% Audio Play
soundsc(final_pressure, Fs);








