%% Ligne à retard

clear;
VEC_SIZE = 1000;


%% Expression du débit

% paramètres:
% u_A -> ???
% p_M -> Pression "Maximale" de plaquage
% delta_p -> pression dans bouche - pression dans bec
% u -> débit de la bouche vers le bec

% paramètres fixes
u_A = 200;
p_M = 75e3;

% abscisses
delta_p = linspace(-20e3, 150e3, VEC_SIZE);

% ordonnées
u = u_A .* (1 - delta_p ./ p_M) .* sqrt(abs(delta_p) ./ p_M) .* sign(delta_p);
u(delta_p > p_M) = 0;

% graphe
figure;
plot(delta_p, u);


%% Adimensionnement

% paramètres:
% gamma -> pression bouche divisé par pression de plaquage
% zeta -> ouverture de la bouche
% p -> ???

% paramètres fixes
zeta = 0.6;

% graphe
figure;
ylim([-0.4, 0.4]);

% abscisses
p = linspace(-1.5, 1.5, VEC_SIZE);

% ordonnées pour 3 valeures de gamma
for gamma = [0.22 0.42 0.65]
    u = zeta .* (1 - gamma + p) .* sqrt(abs(gamma - p)) .* sign(gamma - p);
    u((gamma - p) >= 1) = 0;
    hold on;
    plot(p, u);
end


%% Rotation F(p)

% paramètres:
% theta -> angle de la matrice de rotation R
% Ref -> matrice de reflection
% Rot -> matrice de rotation utilisant theta

% paramètres fixes
zeta = 0.6;

% transformations
theta = -45;
Ref = [-1 0; 0 1];
Rot = [cos(theta) -sin(theta); sin(theta) cos(theta)];

% graphe
figure;
xlim([-1 1]);
ylim([-1 1]);

% abscisses
p = linspace(-1.5, 1.5, VEC_SIZE);

for gamma = [0.22 0.42 0.65]
    % pression à débit
    u = zeta .* (1 - gamma + p) .* sqrt(abs(gamma - p)) .* sign(gamma - p);
    u((gamma - p) >= 1) = 0;
    
    % reflection + rotation pour obtenir p- et p+
    M = Rot * Ref * [p; u];
    p_minus = M(1,:); p_plus = M(2,:);
    
    % graphe
    hold on;
    plot(p_minus, p_plus);
end


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
