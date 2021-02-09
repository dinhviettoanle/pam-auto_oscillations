function [is_fast] = descriptor_attack_time(gamma, zeta, res, t_end, Fs, FILL)

[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);
mirobject = miraudio(p, Fs);

char_computed = mirattacktime(mirobject);
feature = mirgetdata(char_computed);

if isempty(feature)
    is_fast = 1;
    fprintf("No attack");
else
    attack_first_note = feature(1);

    if FILL
        is_fast = attack_first_note;
    else
        if attack_first_note < 0.04
            is_fast = 1;
        else
            is_fast = -1;
        end
    end

    fprintf("Attack time : %f -> %i\n", attack_first_note, (attack_first_note < 0.04));
end

end

