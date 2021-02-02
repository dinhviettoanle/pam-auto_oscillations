function [is_periodic] = descriptor_periodic(gamma, zeta, res, t_end, Fs)

[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

relevant_p = p(0.75*end:end);

power_p = relevant_p.^2;
var_power_enveloppe = var(power_p)/mean(power_p);

fprintf("epsilon : %f \n", var_power_enveloppe);

if (var_power_enveloppe > 1e-2) && (var_power_enveloppe < 1e2)
    is_periodic = -1;
else
    is_periodic = 1;
end

end