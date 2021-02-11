function q_out=compG(gamma, zeta, q)
    %retourne G(q)
    p_list = linspace(-1.5, 1.5, 10000);
    p_plus_list = zeros(length(p_list),1);
    p_minus_list = zeros(length(p_list),1);
    for i = 1:length(p_list)
        [p_minus_list(i), p_plus_list(i)] = G_plot(p_list(i), gamma, zeta);
    end
    G=struct("x", p_minus_list, "y", p_plus_list);
    q_out=interp1(G.x, G.y, q);
    
end