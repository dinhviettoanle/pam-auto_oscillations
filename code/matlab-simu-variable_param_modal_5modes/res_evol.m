function res = res_evol(t, all_res)
%RES_EVOL Evolution du resonateur en fonction du temps
% Inputs :
%   t : Temps de calcul
%   all_res : Résonateurs calculés qui sont in-tune

if t == 0
    chosen_index = 1;
else
    chosen_index = ceil(t);
end

res = reshape(all_res(chosen_index,:,:), [5,3]);

end

