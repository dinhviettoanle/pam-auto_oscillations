function [res] = init_resonator_pole(l, R)
N_sub_perce = 2;
Pabsc = linspace(0, l, N_sub_perce);
Prayon = R * (l - Pabsc)/l + R * Pabsc/l; 

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
frq_peaks_th = index_peaks_th * (Fs/2)/length(Z_th);


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
    list_Q(i) = 1/((2*alpha)/R * sqrt(mu*l/(rho0*gamma_n*c)) + 0.5 * (k_n*R)^2/gamma_n);
end
    

%% Attribution frq / Q
list_F = ones(1,12) * (2*c/0.5); % facteurs modaux

res = zeros(5, 3);
for j = 1:5
    res(j,1) = 2*pi*list_frq(j);
    res(j,2) = list_Q(j);
    res(j,3) = list_F(j);
end



end

