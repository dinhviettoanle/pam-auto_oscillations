clear all, close all

fileName="realTimedelayLine.wav"
SAVEAUDIO=1
BUFFER_SIZE=512
N_BUFFER=100;
N_samples=N_BUFFER*BUFFER_SIZE;
%% Delay line, real time
%pour l'instant sans buffer
fe=44000;
te=1/fe;
%N=3*fe;
%% parameters
%medium
rho0=1.225;
c=340;

%playing
u_A = 200;
p_M = 75e3;
gamma_const=0.62;
zeta_const=0.6;

%vecteurs
%gamma = ones(1, N)*gamma_const;%pas encore utilisé
%gamma(N/2:N)=0; 
%zeta = ones(1, N)*zeta_const;%pas encore utilisé
%zeta(N/2:N)=0;

%instrument
r=2.5e-2;
S=pi*r^2;
l=0.3;
Zc=rho0*c/S;
dt=2*l/c;
N_delay=round(dt/te); %nombre d'échantillons de delay, en première approche on arrondi à l'entier inférieur
%r_t=-[1; zeros(BUFFER_SIZE-1,1)];%premier essai : -dirac

if (N_delay==BUFFER_SIZE)
    "increase buffer size"
end

%% fonction de réflexion
w=2*pi*linspace(-fe/2, fe/2, BUFFER_SIZE);
k=w/c;
Zr=Zc.*(0.25.*(k.*r).^2+0.6133j.*k.*r);
Rw=(Zr-Zc)./(Zr+Zc).*exp(-2.*1j.*k.*l);% remplacé par le delay?
figure()
%plot(w, 10*log10(abs(Rw)/max(abs(Rw))))
plot(w, abs(Rw))
ylabel("|R(w)|"), ylabel("w")
drawnow()
refl=irfft((Rw));
r_t=real(refl);
r_t=r_t(1:512);
figure()
plot((0:length(r_t)-1)*te, r_t)
ylabel("r(t)"), xlabel('t(s)')
drawnow()

%% Calcul de G(-p^-)
%tiré de delay_line.m
p_list = linspace(-1.5, 1.5, 10000);

figure;

p_plus_list = zeros(length(p_list),1);
p_minus_list = zeros(length(p_list),1);
for i = 1:length(p_list)
    [p_minus_list(i), p_plus_list(i)] = G_plot(p_list(i), gamma_const, zeta_const);
end

G=struct("x", p_minus_list, "y", p_plus_list);
plot(G.x, G.y);
xlim([-.5 .5]);
ylim([-.5 .5]);
xlabel("p-"), ylabel("p+")

%% delay line
%initialisation
q_o=zeros(1,BUFFER_SIZE-1);%Buffer output_pressure
output=zeros(1, BUFFER_SIZE);
ind=0;
n=1;
while (ind<N_BUFFER)
    qi_buffer=conv(circshift(q_o, N_delay), r_t);
    qi_buffer=qi_buffer(1:BUFFER_SIZE);
    q_o(n+1)=interp1(G.x, G.y, qi_buffer(BUFFER_SIZE));
    n=mod(n+1, BUFFER_SIZE);
    if n==0
        output=cat(2, output, q_o);
        ind=ind+1
    end
end

q_=q_o/max(abs(q_o));
figure();
i=(0:length(output)-1)*te;
plot(i,output)
xlabel("Temps(s)"),ylabel("p_o(t) (ua)")
if SAVEAUDIO
    audiowrite(fileName, output, fe)
    
end




















