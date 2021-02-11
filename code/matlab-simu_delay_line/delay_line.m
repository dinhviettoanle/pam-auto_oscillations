%% Ligne à retard

%% Expression du débit
u_A = 200;
delta_p_list = linspace(-20e3, 150e3, 1000);
p_M = 75e3;

u_dp = zeros(1000,1);
for i = 1:length(delta_p_list)
    u_dp(i) = flow_from_deltap(u_A, delta_p_list(i), p_M);
end
   
figure;
plot(delta_p_list, u_dp );


%% Adimensionnement

p_list = linspace(-1.5, 1.5, 1000);
gamma = 0.62;
zeta = 0.6;

figure;
for gamma = [0.22 0.42 0.65]
    u_p_list = zeros(length(p_list),1);
    for i = 1:length(p_list)
        u_p_list(i) = F(p_list(i), gamma, zeta);
    end
    hold on;
    a = plot(p_list, u_p_list);
end
xlim([-1.5 1.5]);
ylim([-0.4, 0.4]);

%% Rotation F(p)

p_list = linspace(-1.5, 1.5, 1000);

figure;
for gamma = [0.42]
    p_plus_list = zeros(length(p_list),1);
    p_minus_list = zeros(length(p_list),1);
    for i = 1:length(p_list)
        [p_minus_list(i), p_plus_list(i)] = G_plot(p_list(i), gamma, zeta);
    end
    hold on;
    plot(p_minus_list, p_plus_list);
end

xlim([-.5 .5]);
ylim([-.5 .5]);

%% Carte itérée

% Construction courbe (p_n+, p_n-)

gamma = 0.62;
zeta = 0.6;

p_list = linspace(-1.5, 1.5, 1000);
p_plus_list = zeros(length(p_list),1);
p_minus_list = zeros(length(p_list),1);

for i = 1:length(p_list)
    [p_minus_list(i), p_plus_list(i)] = G_plot(p_list(i), gamma, zeta);
end

% Construction suite p_n
p_n = 0;
N = 100;

points_p_minus = zeros(N, 1);
points_p_plus = zeros(N, 1);

for n = 1:N
    points_p_minus(n) = p_n;
    p_n = G(p_n, p_minus_list, p_plus_list);
    points_p_plus(n) = p_n;
end

figure;
plot(p_minus_list, p_plus_list);
hold on;
scatter(points_p_minus, points_p_plus);
grid on;

figure;
plot(points_p_plus);
