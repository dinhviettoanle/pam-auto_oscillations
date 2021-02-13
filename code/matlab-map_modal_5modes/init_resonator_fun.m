function [res] = init_resonator_fun(l, R)
% INIT_RESONATOR_FUN Initialise le resonateur
%   Renvoie les 5 premieres pulsations de resonnance, les facteurs de qualite et les facteurs modaux
% Inputs :
%   l : Longueur du tube
%   R : Rayon du tube

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
%% Recherche frequences de resonnance
Fs = 8000;

[height_peaks_th, index_peaks_th] = findpeaks(abs(Z_th));
% frq_peaks_th = index_peaks_th * (Fs/2)/length(Z_th);

%% Calcul des fréquences et facteurs de qualite

ifft_z = real(irfft(Z_th));
[frq_res_esprit, damping_esprit] = esprit(ifft_z, 1500, 10);

frq_res_esprit = frq_res_esprit * Fs + freq_th(1);
Q_esprit = -1./(2*damping_esprit);


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


end

