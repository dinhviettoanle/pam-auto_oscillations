%% Test fonction de réflexion


rho0 = 1.225;
c = 340;
mu = 18.5e-6; 

a = 2.5e-2;
S = pi*a^2;

N = 10000;
fe = 44100;
te = 1/fe;
w = linspace(1, pi*fe, N);
k = w/c;
l = 0.5;
Zc = rho0*c/S;
Zr = rho0 .* c ./ S .* (0.25*(k .* a).^2 + 0.6133j .* k.*a);

R = (Zr - Zc)./(Zr + Zc) .* exp(-2j.*k.*l);

%% Bode

Rabs = abs(R) / max(abs(R));
figure;
subplot(2,1,1);
plot(w/(2*pi), 10*log(Rabs));
subplot(2,1,2);
plot(w/(2*pi), angle(R));


%% Temporel

r = irfft(R);
t = linspace(0, length(r)*te, length(r));

figure;
plot(t, r);
xlim([0 0.01]);

fprintf("Temps aller-retour : %f \n", 2*l/c);
fprintf("Intégrale : %f \n", sum(r));