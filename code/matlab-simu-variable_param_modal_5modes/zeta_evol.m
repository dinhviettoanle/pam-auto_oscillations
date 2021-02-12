function zeta = zeta_evol(t)
%ZETA_EVOL 

TOT_T = 6;
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

% Constant
% zeta = 0.44;

% From - to
% zeta0 = 0.7;
% zeta1 = 0.4;
% zeta = zeta1*(t/TOT_T) + zeta0*(1 - t/TOT_T);
end

