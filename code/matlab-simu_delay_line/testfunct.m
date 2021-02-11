clear all, close all
%% petit script pour vérifier que reflect rend bien -1 quand on lui passe un dirac
%medium
rho0=1.225;     % Densite air
c=340;          % Vitesse son

a=2e-2;         % Rayon tube
S=pi*a^2;       % Section tube
l=50e-2;        % Longueur tube
Zc=rho0*c/S;
fe=10e3;
te=1/fe;

wc=0.27;
b=fir1(3, wc, 'low');
[h, t]=impz(b, 1);

n=1:1024;
dir=[1, zeros(1, length(n)-1)];
p_o=conv(dir, h);

plot(p_o)

b=fir1(2, 0.20, 'low');
[r_t, t]=impz(b, 10);
figure()
plot(t, r_t)
xlabel('temps (s)'), ylabel('r_t(t)')
title('Fonction de réflexion')