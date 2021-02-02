function [feature] = descriptor_mir(gamma, zeta, res, t_end, Fs)
%DESCRIPTOR_FLATNESS Summary of this function goes here
%   Detailed explanation goes here
[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);
mirobject = miraudio(p, Fs);

char_computed = mirpitch(mirobject);

feature = mirgetdata(char_computed);
end

