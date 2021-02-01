%% Init resonator
close all;
clear;

run("init_resonator");

t_end = 2;
Fs = 44100;
%% Test unique

gamma = 0.8;
zeta = 0.6;

[t, X] = simulate_5modes(gamma, zeta, res, t_end, Fs);
p = X(:,1) + X(:,3) + X(:,5) + X(:,7) + X(:,9);

plot(p)



% --- MIR Toolbox ---
% mirgetdata(mirscalar) -> ce qu'on veut
% a = miraudio(p,Fs) -> MIRobject
%

%% Fill Colormap
N_split = 10;
gamma_list = linspace(0, 1, N_split);
zeta_list = linspace(0, 1, N_split);
characteristics = zeros(N_split);

% descriptor = @(x,y) descriptor_mir_value(x, y, res, t_end, Fs);
descriptor = @(x,y) descriptor_periodic(x, y, res, t_end, Fs);

for i = 1:N_split
    for j = 1:N_split
        gamma = gamma_list(i);
        zeta = zeta_list(j);
        characteristics(j,i) = descriptor(gamma, zeta);
    end
end

%% 
imagesc(gamma_list, zeta_list, log(characteristics));
xlabel('$\gamma$', 'Interpreter', 'latex');
ylabel('$\zeta$', 'Interpreter', 'latex');
colorbar
