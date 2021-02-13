function [frq_esprit, damping_esprit] = esprit(x, n, K)
%ESPRIT Algorithme Esprit
%   Renvoie les fréquence de résonance (en Hz) et les coefficients
%   d'amortissement d'un signal
% Inputs :
%   x : Signal a analyser
%   n : 
%   K : Nombre de modes a trouver

N = length(x);
l = N - n + 1;

% Matrice correlation
x_first = x(1:n);
x_last = x(l:N);

warning('off','MATLAB:hankel:AntiDiagonalConflict');
X = hankel(x_first, x_last);
R_xx = 1/l * X*X';

% Espace image
[U1, l] = eig(R_xx);
W = U1(:,1:K);

% Frq et damping
W_down = W(1:end-1,:);
W_up = W(2:end,:);
Phi = pinv(W_down) * W_up;


eigen_Phi = eig(Phi);

damping_esprit = log(abs(eigen_Phi));
frq_esprit = angle(eigen_Phi) / (2*pi);
end

