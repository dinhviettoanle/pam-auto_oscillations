function [is_in_tune] = descriptor_in_tune(gamma, zeta, res, t_end, Fs)

[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

is_in_tune = 1;


end