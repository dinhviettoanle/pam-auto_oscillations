%% Preprocess lengths notes

load in_tune_lengths.mat;
%%
all_res = zeros(length(lengths_list), 5, 3);

R = 3e-2;

for i = 1:length(lengths_list)
    l = lengths_list(i);
    fprintf("Processing l = %f (%i / %i) \n", l, i, length(lengths_list));
    all_res(i,:,:) = init_resonator_fun(l, R);
end

%% 
save("all_res.mat", "all_res");