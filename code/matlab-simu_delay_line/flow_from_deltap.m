function flow = flow_from_deltap(u_A, delta_p, p_M)
% Input -> delta_p = différence pression dans bouche vs bec
% Output -> u_dp = débit 

if delta_p > p_M
    flow = 0;
else
    flow = u_A .* (1 - delta_p./p_M) .* sqrt(abs(delta_p)./p_M) .* sign(delta_p);
end
end

