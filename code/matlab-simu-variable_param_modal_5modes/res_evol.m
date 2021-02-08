function res = res_evol(t, all_res)
%RES_EVOL 

if t == 0
    chosen_index = 1;
else
    chosen_index = ceil(t);
end

res = reshape(all_res(chosen_index,:,:), [5,3]);

end

