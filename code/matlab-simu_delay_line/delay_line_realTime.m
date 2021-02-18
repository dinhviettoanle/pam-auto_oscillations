clear all;
close all;

fileName="realTimedelayLine.wav";
SAVEAUDIO=0;
N_SAMPLE=10000;

%% Delay line, real time
%pour l'instant sans buffer
fe=20e3;
te=1/fe;
%N=3*fe;

%% parameters
%medium
rho0=1.225;     % Densite air
c=340;          % Vitesse son

%playing
u_A = 200;      % Debit entrant
p_M = 75e3;     % Pression de placage

gamma_const=0.47;
%gamma = ones(1, N)*0.01;
%gamma(N/2:N)=0; 
zeta_const=0.15;
%zeta = ones(1, N)*0.6;
%zeta(N/2:N)=0;

%instrument
a=2e-2;         % Rayon tube
S=pi*a^2;       % Section tube
l=50e-2;        % Longueur tube
Zc=rho0*c/S;    % Impedance caracteristique
dt=2*l/c;       % Temps de retour de l'onde retour
N_delay=round(dt/te);

%% Reflection function

%FWHM = 0.25 * dt; % Full Width at Half Maximum (cf MCINTYRE after eq. (19))

% FWHM = 2*sqrt(2*log(2))*sigma = 2.35482*sigma % cf https://en.wikipedia.org/wiki/Full_width_at_half_maximum
%sigma = FWHM / 2.35482; % standard deviation of the function

%% Fonction de réflexion
wc=0.47;%correspond à la fréquence (normalisée) à laquelle Rw commence à faire n'importe quoi
b=fir1(20,wc, 'low');
[r_t, t]= impz(b, 1, 20, fe);
r_t=-1;
figure()
plot(t, r_t)
xlabel('temps (s)'), ylabel('r_t(t)')
title('Fonction de réflexion')
drawnow()
%b = 1/(2*sigma^2);
%a = -1/(sigma*sqrt(2*pi)); % a is negative so int(r(t)) equals -1 (eq (6) MCINTYRE)
w=2*pi*linspace(-fe/2, fe/2, 1000);
k=w/c;
Zr=Zc.*(0.25.*(k.*a).^2+0.6133j.*k.*a/16);
Rw=(Zr-Zc)./(Zr+Zc);
figure()
plot(w, 10*log10(abs(Rw)/max(abs(Rw))))
plot(2*pi*w(w>0), abs(Rw(w>0)))
ylabel("|R(f)|"), xlabel("Fréquence (Hz)")
drawnow()
% 
% r_t=ifftshift(ifft(Rw, 'nonsymmetric'));
% figure()
% plot(real(r_t))
% r_n=real(r_t);
% drawnow()
%% Calcul de G(-p^-)
%tiré de delay_line.m
p_list = linspace(-1.5, 1.5, 10000);

figure;

p_plus_list = zeros(length(p_list),1);
p_minus_list = zeros(length(p_list),1);
for i = 1:length(p_list)
    [p_minus_list(i), p_plus_list(i)] = G_plot(p_list(i), gamma_const, zeta_const);
end

G=struct("x", p_minus_list, "y", p_plus_list);
plot(G.x, G.y);
xlim([-.5 .5]);
ylim([-.5 .5]);
xlabel("p-"), ylabel("p+")
drawnow()

%% delay line
%initialisation
t = 0:te:1-te;
q_o=zeros(1,N_SAMPLE); % Initial output pressure
q_refl=zeros(1,N_SAMPLE);%initial incoming pressure
q_i=0;

q=0;%initial total pressure
f=0;

for ind = 1:N_SAMPLE-1
%     q=q_o(ind)+reflectionFunction(a, b, dt, te, ind)*delay(q_o, n, ind);
%     q_refl(ind)=reflect(q_o, q_refl, ind, a/16, c, te);
%     refl=real(conv(q_o, r_t, 'same'));
%     q_refl(ind)=refl(length(refl));
    refl=conv(q_refl, r_t);
    q_refl(ind)=refl(ind+length(r_t)-1);
    q_i=delay(q_refl,N_delay,ind);
    q_o(ind+1)=interp1(G.x, G.y, -q_i);
    ind
    
end

q_o = q_o/max(abs(q_o));
soundsc(q_o,fe)
figure()
plot(q_o)

if SAVEAUDIO
    audiowrite(fileName, q_o, fe);
    
end

%% FFT
% S=fftshift(fft(q_o));
% SS=abs(S);
% figure()
% f=linspace(-fe/2, fe/2, length(S));
% plot(f, 10*log10(SS/max(SS)))
















