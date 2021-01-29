function irfft = irfft(x)
     n = 0; % the output length
     s = 0; % the variable that will hold the index of the highest
            % frequency below N/2, s = floor((n+1)/2)
     even = true;
     if (even)
        n = 2 * (length(x) - 1 );
        s = length(x) - 1;
     else
        n = 2 * (length(x) - 1 )+1;
        s = length(x);
     end
     xn = zeros(1,n);
     xn(1:length(x)) = x;
     xn(length(x)+1:n) = conj(x(s:-1:2));
     irfft  = ifft(xn);
end
