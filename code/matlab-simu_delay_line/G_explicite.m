function [p_plus] = G_explicite(p_moins,gamma, zeta)
%traduction du code de Jeffery (ligne_a_retard_jeff.ipynb)
%p : vector
%gamma, zeta : scalar

%change of variables
Y = gamma + 2 .* p_moins;
X = zeros(1, length(Y));

%extra useful variables
psi= 1 ./ zeta .^ 2;
eta = (3 + psi) .^ (1 / 2);
mu = 9 ./ 2 .* (3 .* Y - 1);

%case 1: 1 <= Y
cond = (1 <= Y);
X(cond) = Y(cond);

%case 2: 0 < Y < 1
cond=(0<Y)&(Y<1);
X(cond) = (- 2/3 .* eta .* sin(1 ./ 3 .* asin((psi - mu(cond)) ./ (zeta .* eta .^ 3))) + 1 ./ (3 * zeta)) .^ 2;

%case 3 : Y < 0
cond = Y < 0;
q = 1 / 9 .* (3 - psi);
r = - (psi + mu) ./ (27 .* zeta);
discr = q .^ 3 + r .^ 2;
cond_discr = discr > 0;

%discriminant is positive
cond_tot = cond & cond_discr;
s1 = (r(cond_tot) + discr(cond_tot) .^ (1 / 2)) .^ (1 / 3);
X(cond_tot) = -(s1 - q ./ s1 - 1 ./ (3 .* zeta)) .^ 2;

%discriminant is negative
cond_tot = cond & not(cond_discr);
eta_prime = (-3 + psi) .^ (1 / 2);
X(cond_tot) = -(2 / 3 .* eta_prime .* cos(1 / 3 .* acos(-(psi + mu(cond_tot)) / (zeta .* eta_prime .^ 3))) - 1 / (3 .* zeta)) .^ 2; 

%change variables back
p_plus = -X + gamma + p_moins;

end

