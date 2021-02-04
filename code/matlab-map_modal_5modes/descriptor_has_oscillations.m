function [has_oscillations] = descriptor_has_oscillations(gamma, zeta, res, t_end, Fs, FILL)

[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

final_amp = max(p(0.75*end:end));


if FILL
    has_oscillations = final_amp;
else
    if final_amp > 0.1
        has_oscillations = 1;
    else
        has_oscillations = -1;
    end
end

fprintf("Max final amplitude : %f -> %i\n", final_amp, (final_amp > 0.1));

end

