clear all, close all
%% petit script pour vérifier que reflect rend bien -1 quand on lui passe un dirac
%medium
rho0=1.225;     % Densite air
c=340;          % Vitesse son

a=2e-2;         % Rayon tube
S=pi*a^2;       % Section tube
l=50e-2;        % Longueur tube
Zc=rho0*c/S;

n=0:100;
dir=[1, zeros(1, length(n)-1)];
p_o=zeros(1, length(n));

for ind =n+1
    p_o(ind)=reflect(dir,p_o, ind, a, c, Zc);
    
end

plot(p_o)