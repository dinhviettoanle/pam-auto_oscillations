function [is_in_tune] = descriptor_in_tune(gamma, zeta, res, t_end, Fs, frq_ref, FILL)

[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

main_frq = mirgetdata(mirpitch(miraudio(p, Fs), 'Total', 1));

ratio_tampered = abs(main_frq/frq_ref);
n_cents = 1200*log(ratio_tampered)/log(2);

if FILL
    is_in_tune = n_cents;
else
   if n_cents < 20
       is_in_tune = 1;
   else
       is_in_tune = -1;
   end
end

fprintf("N cents : %f \n", n_cents); 
end

