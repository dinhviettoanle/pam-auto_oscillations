clear all;
close all;

fileName="realTimedelayLine.wav";
SAVEAUDIO=1;
N_SAMPLE=100000;
SAVEAUDIO=1
BUFFER_SIZE=2048
N_BUFFER=100;
N_samples=N_BUFFER*BUFFER_SIZE;
%% Delay line, real time
%pour l'instant sans buffer
fe=44e3;
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

%% Fonction de réflexion
wc=0.02;%fait à la main, sonne plutôt bien
b=fir1(46, wc, 'low');
[r_t, t]=impz(b, 1, BUFFER_SIZE);
% win=gausswin(BUFFER_SIZE);
% r_t=-win(length(win)/2:end).';
% r_t=r_t/abs(sum(r_t));
%r_t=-[1, zeros(1,20)];
r_t=-r_t;
figure()

plot(r_t)
xlabel('temps (s)'), ylabel('r_t(t)')
title('Fonction de réflexion')
figure()
freqz(b,1,BUFFER_SIZE)
drawnow()
%pas utilisé dans la simulation
%
%b = 1/(2*sigma^2);
%a = -1/(sigma*sqrt(2*pi)); % a is negative so int(r(t)) equals -1 (eq (6) MCINTYRE)
% w=2*pi*linspace(-fe/2, fe/2, 1000);
% k=w/c;
% Zr=Zc.*(0.25.*(k.*a).^2+0.6133j.*k.*a/16);
% Rw=(Zr-Zc)./(Zr+Zc);
% figure()
% % %plot(w, 10*log10(abs(Rw)/max(abs(Rw))))
% plot(w, abs(Rw))
% ylabel("|R(w)|"), xlabel("w")
% drawnow()
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
q_o=zeros(1,BUFFER_SIZE); % Initial output pressure
q_refl=zeros(1,BUFFER_SIZE);%initial incoming pressure
q_refl_=zeros(1,BUFFER_SIZE);
q_i=zeros(1,BUFFER_SIZE);
q=0;%initial total pressure
q_n=0;
n=0;%indice du buffer
ind=1;%indice du sample
out=zeros(1, N_BUFFER);

while n < N_BUFFER
    q_o(ind)=interp1(G.x, G.y, -q_n);
    q_refl=(cconv(q_o, r_t, BUFFER_SIZE));
    q_i=circshift(q_refl, N_delay);
    q_n=q_i(ind);
%     points_p_minus(n) = p_n;
%     p_n = G(p_n, p_minus_list, p_plus_list);
%     points_p_plus(n) = p_n;
    %q_refl=(cconv(q_o, r_t, BUFFER_SIZE));
    %q_refl(ind)=q_refl(ind);
    %q_refl=cconv(q_o, r_t, BUFFER_SIZE);
    %q_i(ind)=q_refl(ind);
    %q_i=circshift(q_refl, N_delay);
    %q_delay=circshift(q_i, N_delay);
    %new_q_o=interp1(G.x, G.y, -q_i(ind));
    
    %q_o(mod(ind, BUFFER_SIZE)+1)=new_q_o;
    ind=mod(ind, BUFFER_SIZE)+1;
    if ind==1
        "1"
    end
    if ind==BUFFER_SIZE
        "BUFFER_SIZE"
        
    end
        
    if mod(ind, BUFFER_SIZE)==0
        out=cat(2, out, q_o);
        n=n+1
    end
%     if mod(ind+1, BUFFER_SIZE)==0
%         q_o(ind+1)=new_q_o;
%         out=cat(2, out, q_o);
%         ind=BUFFER_SIZE;
%         n=n+1;
%     else
%        q_o(ind+1)=new_q_o;
%        ind=mod(ind+1, BUFFER_SIZE)+1; 
%     end
        
end

%out = out/max(abs(out));
%soundsc(q_o,fe)
figure()
plot(out)

if SAVEAUDIO
    audiowrite(fileName, out, fe);
    
end

%% FFT
S=fftshift(fft(q_o));
SS=abs(S);
figure()
f=linspace(-fe/2, fe/2, length(S));
plot(f, 10*log10(SS/max(SS)))
















