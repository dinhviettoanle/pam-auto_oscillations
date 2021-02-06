%% Preprocess lengths notes

load lengths;
lengths = lengths(1:3);
%%
all_res = zeros(3, 5, 3);

R = 3e-2;

for i = 1:length(lengths)
    l = lengths(i);
    all_res(i,:,:) = init_resonator_fun(l, R);
end
