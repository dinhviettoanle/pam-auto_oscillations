clear all;
close all;

fileName="realTimedelayLine.wav";
SAVEAUDIO=0;

%% Delay line, real time
%pour l'instant sans buffer
fe=40e3;
te=1/fe;
N=3*fe;

%% parameters
%medium
rho0=1.225;     % Densite air
c=340;          % Vitesse son

%playing
u_A = 200;      % Debit entrant
p_M = 75e3;     % Pression de placage

gamma = ones(1, N)*0.01;
gamma(N/2:N)=0; 
zeta = ones(1, N)*0.6;
zeta(N/2:N)=0;

%instrument
a=2e-2;         % Rayon tube
S=pi*a^2;       % Section tube
l=50e-2;        % Longueur tube
Zc=rho0*c/S;    % Impedance caracteristique
dt=2*l/c;       % Temps de retour de l'onde retour

%reflection parameters
%b=(0.005*dt/(2*sqrt(log(2))))^(-2);
%a=b*2;

%% Reflection function

FWHM = 0.25 * dt; % Full Width at Half Maximum (cf MCINTYRE after eq. (19))

% FWHM = 2*sqrt(2*log(2))*sigma = 2.35482*sigma % cf https://en.wikipedia.org/wiki/Full_width_at_half_maximum
sigma = FWHM / 2.35482; % standard deviation of the function

% Reflection parameters
b = 1/(2*sigma^2);
a = -1/(sigma*sqrt(2*pi)); % a is negative so int(r(t)) equals -1 (eq (6) MCINTYRE)

%% delay line
%initialisation
t = 0:te:1-te;
q_o=sin(2*pi*440*t); % Initial output pressure
q_i=zeros(1,N);%initial incoming pressure
n=round(dt/te);%nombre d'échantillons de delay, en première approche on arrondi à l'entier inférieur
q=0;%initial total pressure
f=0;

for ind = 1:N-1
    %q=q_o(ind)+reflectionFunction(a, b, dt, te, ind)*delay(q_o, n, ind);
    
    q=q_o(ind)+1*delay(q_o, n, ind);
    f=F(q, gamma(ind), zeta(ind));
    q_o(ind+1)=Zc*f;
    
end

q_o = q_o/max(abs(q_o));
soundsc(q_o,fe)

if SAVEAUDIO
    audiowrite(fileName, q_o, fe);
    
end

















