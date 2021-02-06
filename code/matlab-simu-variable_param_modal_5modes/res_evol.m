function res = res_evol(t, all_res)
%RES_EVOL 


if (0 <= t) && (t < 2)
    res = reshape(all_res(1,:,:), [5,3]);
elseif (2 <= t) && (t < 4)
    res = reshape(all_res(2,:,:), [5,3]);
elseif (4 <= t) && (t < 6)
    res = reshape(all_res(3,:,:), [5,3]);
else
    fprintf("%f \n", t);
    res = reshape(all_res(3,:,:), [5,3]);
end


end

