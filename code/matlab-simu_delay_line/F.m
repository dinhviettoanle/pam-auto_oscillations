function u = F(p, gamma, zeta)
%F Summary of this function goes here
%   Detailed explanation goes here
if (gamma - p) >= 1
    u = 0;
else
    u = zeta .* (1-gamma+p).*sqrt(abs(gamma-p)).*sign(gamma-p);
end

end

