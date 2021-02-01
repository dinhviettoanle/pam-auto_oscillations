function [has_oscillations] = descriptor_has_oscillations(gamma, zeta, res, t_end, Fs)

[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

fprintf("Max final amplitude : %f \n", max(p(0.75*end:end)));

oscillates = max(p(0.75*end:end)) > 0.1; % TODO : condition a revoir

if oscillates
    has_oscillations = 1;
else
    has_oscillations = -1;
end

end

