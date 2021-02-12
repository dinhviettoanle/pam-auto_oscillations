function h=compB(wc, N)
    n=-N:N-1;
    h_n=sinc(n*wc);
    win=0.54+0.46*cos(pi*n/N);
    h=win.*h_n
end

