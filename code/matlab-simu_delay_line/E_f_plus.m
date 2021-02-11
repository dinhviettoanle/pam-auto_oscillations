function E_n = E_f_plus(f,n,a, c, te)
%calcul 
E_n=-0.25*((a/c)^2)*d_2(f, n, te)+0.6133*(a/c)*d_1(f, n, te)-f(n);
end

