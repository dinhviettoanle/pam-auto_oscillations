function flow = flow_from_deltap(u_A, delta_p, p_M)
%FLOW_FROM_DELTAP Summary of this function goes here
%   Detailed explanation goes here
if delta_p > p_M
    flow = 0;
else
    flow = u_A .* (1 - delta_p./p_M) .* sqrt(abs(delta_p)./p_M) .* sign(delta_p);
end
end

