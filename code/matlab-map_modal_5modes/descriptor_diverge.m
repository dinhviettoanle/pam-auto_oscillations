function [diverged] = descriptor_diverge(gamma, zeta, res, t_end, Fs, FILL)

[t, X] = simulate_5modes_explicit(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

final_amp = max(abs(p(1:1000)));


if FILL
    diverged = final_amp;
else
    if final_amp > 1000
        diverged = 1;
    else
        diverged = -1;
    end
end

fprintf("Max final amplitude : %f -> %i\n", final_amp, (final_amp > 1000));

end

