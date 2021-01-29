function Z_e = impedance_ramenee(f, Pabsc, Prayon, SCREEN)
%IMPEDANCE_RAMENEE Summary of this function goes here
%   Detailed explanation goes here

% Constants
rho0 = 1.225;
c = 340;
mu = 18.5e-6;

omega = 2*pi*f;
n_sec = length(Pabsc);

S_out = pi * Prayon(end)^2;
k0 = omega/c;
kv = sqrt(omega * rho0 / mu);

PU = zeros(2, n_sec); % PU(1) : pressure ; PU(2) : velocity

k = k0;
a = Prayon(1);

% Radiation impedance
if SCREEN
    Z_r = rho0 * c / S_out * (0.5 * (k*a)^2 + 8j * k*a / (3*pi));
else
    Z_r = rho0 * c / S_out * (0.25*(k*a)^2 + 0.6133j * k*a);
end

% Out conditions
PU(1, end) = 10e5; % P_atm
PU(2, end) = PU(1, end) / Z_r; 

l_list = sqrt((Pabsc(2:end) - Pabsc(1:end)).^2 + (Prayon(2:end) - Prayon(1:end)).^2);

for i = (n_sec-1):-1:1
    x1 = Pabsc(i);
    x2 = Pabsc(i+1);
    R1 = Prayon(i);
    R2 = Prayon(i+1);
    l = l_list(i);
    
    % Avec pertes (Zegrev4, p.13)
    r_v = kv * (R1 + R2) / 2;
    k = k0 * (1 + 1.044 * sqrt(-2*1j)/r_v);
    rho = rho0 * (1 + 2*sqrt(-1j)/r_v);
    
    % Constante de couplage
    beta = rho * c / (pi * R1 * R2);
    
    % Transfert matrix
    kl = k*l;
    cos_kl = cos(kl);
    sin_kl = sin(kl);
    
    A = cos_kl;
    B = 1j * beta * sin_kl;
    C = 1j / beta * sin_kl;
    D = cos_kl;
    
    transfer_matrix = [[A B];[C D]];
    PU(:,i) = transfer_matrix * PU(:,i+1);
end

Z_e = PU(1,1) / PU(2,1); % Impedance d'entree
end

