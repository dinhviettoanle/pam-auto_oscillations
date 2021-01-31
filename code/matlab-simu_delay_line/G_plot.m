function [p_minus, p_plus] = G_plot(p, gamma, zeta)
%G_PLOT Summary of this function goes here
%   Detailed explanation goes here
F_p = F(p, gamma, zeta);
cos45 = sqrt(2)/2;
sin45 = sqrt(2)/2;

p_minus = cos45*F_p - sin45*p;
p_plus = sin45*F_p + cos45*p;
end

