function gamma = gamma_evol(t)
%GAMMA_EVOL 
% if t < 2
%     gamma = 0.7/2 * t;
% elseif t < 4
%     gamma = 0.7;
% else
%     gamma = -0.7/2 * (t-6);

% Constant
gamma = 0.7;

% Oscill
% f = 0.5;
% gamma = 0.3 * sin(2*pi*f*t) + 0.4;

% Linear up 
% gamma = 0.1 + 0.8/6 * t;
end

