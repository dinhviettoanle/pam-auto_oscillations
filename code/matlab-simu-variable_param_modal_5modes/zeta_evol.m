function zeta = zeta_evol(t)
%ZETA_EVOL 
% Linear up to 0.7, constant, linear down to 0
% if t < 2
%     zeta = 0.7/2 * t;
% elseif t < 4
%     zeta = 0.7;
% else
%     zeta = -0.7/2 * (t-6);

% Linear down from 0.7 to 0.1
% zeta = 0.7 - 0.6/6*t;

% Linear up from 0.1 to 0.7
zeta = 0.1 + 0.9/6*t;

% zeta = 0.4;
end

