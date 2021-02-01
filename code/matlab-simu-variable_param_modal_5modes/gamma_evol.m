function gamma = gamma_evol(t)
%GAMMA_EVOL 
% if t < 2
%     gamma = 0.7/2 * t;
% elseif t < 4
%     gamma = 0.7;
% else
%     gamma = -0.7/2 * (t-6);

f = 0.5;
gamma = 0.3 * sin(2*pi*f*t) + 0.4;
end

