function [] = plot_spectrum(X, Fs)

figure;
L = length(X);

x_frq = Fs*(0:(L/2))/L;

Y = fft(X);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

plot(x_frq, 10*log(P1));

xlim([0 2500]);
xlabel("f(Hz)");
ylabel("log(|P|)");
curtick = get(gca, 'XTick');
set(gca, 'XTickLabel', cellstr(num2str(curtick(:))));

end

