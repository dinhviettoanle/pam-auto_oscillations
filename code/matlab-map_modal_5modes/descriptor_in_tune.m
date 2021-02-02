function [is_in_tune] = descriptor_in_tune(gamma, zeta, res, t_end, Fs)

[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

main_frq = mirgetdata(mirpitch(miraudio(p, Fs)));

f_tampered = 164.81;
ratio_tampered = abs(main_frq/f_tampered);

if abs(1200 * log(ratio_tampered)/log(2)) < 10
    is_in_tune = 1;
else
    is_in_tune = -1;
end


fprintf("delta cents : %f \n", 1200 * log(ratio_tampered)/log(2));

end