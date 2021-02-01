clear all, close all

fileName="realTimedelayLine.wav"
SAVEAUDIO=1

%% Delay line, real time
%pour l'instant sans buffer
fe=40e3;
te=1/fe;
N=3*fe;
%% parameters
%medium
rho0=1225;
c=340;

%playing
u_A = 200;
p_M = 75e3;

gamma = 0.62;
zeta = 0.6;

%instrument
a=2e-2;
S=pi*a^2;
l=50e-2;
Zc=rho0*c/S;
dt=2*l/c;

%reflection parameters
b=(0.005*dt/(2*sqrt(log(2))))^(-2);
a=b*2;

%% delay line
%initialisation
q_o=zeros(1,N);%intitial output pressure
q_i=zeros(1,N);%initial incoming pressure
n=round(dt/te);%nombre d'échantillons de delay, en première approche on arrondi à l'entier inférieur
q=0;%initial total pressure
f=0;
for ind = 1:N-1
    %q=q_o(ind)+reflectionFunction(a, b, dt, te, ind)*delay(q_o, n, ind);
    q=q_o(ind)+0.8*delay(q_o, n, ind);
    f=F(q, gamma, zeta);
    q_o(ind+1)=Zc*f;
    
end
q_o/max(abs(q_o));
if SAVEAUDIO
    audiowrite(fileName, q_o, fe)
    
end

















