function gamma = gamma_evol(t)
%GAMMA_EVOL 

TOT_T = 6;

% if t < 2
%     gamma = 0.7/2 * t;
% elseif t < 4
%     gamma = 0.7;
% else
%     gamma = -0.7/2 * (t-6);

% Constant
gamma = 0.8;

% Oscill
% f = 0.5;
% gamma = 0.3 * sin(2*pi*f*t) + 0.4;

% Linear up 
% gamma = 0.1 + 0.8/6 * t;

% From - to
% gamma0 = 0.5;
% gamma1 = 0.9;
% gamma = gamma1*(t/TOT_T) + gamma0*(1 - t/TOT_T);
end

