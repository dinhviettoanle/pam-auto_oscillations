function p_plus_next = G(p_n_1, p_minus_list, p_plus_list)
%G Summary of this function goes here
%   Detailed explanation goes here

[min_dist, index_neareast_p_minus] = min(abs(p_minus_list - p_n_1));
p_plus_next = p_plus_list(index_neareast_p_minus);
end

