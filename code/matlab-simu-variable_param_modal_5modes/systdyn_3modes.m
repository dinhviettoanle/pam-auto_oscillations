function dydt = systdyn_3modes(t, y, res, g, z)
%SYSTDYN_5MODES Fonction de mise a jour des p et dp pour un systeme a 5
%modes
% g : gamma
% z : zeta
% s : sigma, pour pas diviser par 0

w1 = res(1,1); F1 = res(1,2); Q1 = res(1,3);
w2 = res(2,1); F2 = res(2,2); Q2 = res(2,3);
w3 = res(3,1); F3 = res(3,2); Q3 = res(3,3);

p_tot = y(1) + y(3) + y(5);
dp_tot = y(2) + y(4) + y(6);

% dudt = ((g-p_tot) <= 0) ? 
% -dp_tot*z*sqrt(p_tot-g) - dp_tot*z*(1-g+p_tot)/(2*sqrt(p_tot-g)) 
% : ((g-p_tot) >= 1) ? 0 : dp_tot*z*sqrt(g-p_tot) - dp_tot*z*(1-g+p_tot)/(2*sqrt(g-p_tot));

if (g - p_tot) > 1
    dudt = 0;
elseif (0 <= (g - p_tot)) && ((g - p_tot) <= 1)
    dudt = dp_tot*z*sqrt(g - p_tot) - dp_tot*z*(1 - g + p_tot)/(2*sqrt(g - p_tot));
elseif (g - p_tot) < 0
    dudt = -dp_tot*z*sqrt(-g + p_tot) - (dp_tot)*z*(1 - g + p_tot)/(2*sqrt(-g + p_tot));
else
    dudt = -1;
end
    
% fprintf("%f \n", (g - p_tot));

dydt1 = [y(2); -(w1/Q1)*y(2) - w1^2*y(1) + F1*dudt];
dydt2 = [y(4); -(w2/Q2)*y(4) - w2^2*y(3) + F2*dudt];
dydt3 = [y(6); -(w3/Q3)*y(6) - w3^2*y(5) + F3*dudt];

dydt = [dydt1;dydt2;dydt3;g;z];
end