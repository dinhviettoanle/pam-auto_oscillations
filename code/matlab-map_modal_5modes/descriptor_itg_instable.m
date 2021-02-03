function [is_instable] = descriptor_itg_instable(gamma, zeta, res, t_end, Fs)
% !!! USELESS !!!  
warning('error', 'MATLAB:ode15s:IntegrationTolNotMet');
 
try
    [t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
%     p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);
    is_instable = -1;
catch
    is_instable = 1;    
end

end

