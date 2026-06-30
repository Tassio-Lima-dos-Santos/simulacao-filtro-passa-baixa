% tau * (dtheta/dt) + theta = alpha * t
% Temp_filtered[n] = k * temp_raw[n] + (1 - k) * temp_filtered[n - 1]
% k = dt / (tau + dt)
% temp_raw = alpha * t

clear; clc; close all;

% Definição do tempo
dt = 1;    % 1 s
tf = 2420; % 40 min e 20 s
t = 0:dt:tf;
n = length(t);

% Parâmetros da simulação
alpha = 1 / 60;
tau = 20;
k = dt / (tau + dt);

% Condições iniciais
temp_raw(1) = 25      % 25 graus Celsius
temp_filtered(1) = temp_raw(1);

% Vetores
temp_raw = temp_raw(1) + alpha * t;

for i = 2:n
    temp_filtered(i) = k * temp_raw(i) + (1 - k) * temp_filtered(i - 1);
end

% Encontrar o tempo em que temp_filtered passa 55°C
idx = find(temp_filtered >= 55, 1);  % primeiro índice que atinge 55
if ~isempty(idx)
    t_crossing = t(idx);
    temp_raw_crossing = temp_raw(idx);
else
    t_crossing = [];
    temp_raw_crossing = [];
    disp('Filtro nunca atingiu 55°C');
end

% Plotar
plot(t, temp_raw, 'b-', 'LineWidth', 1.5);
hold on;
plot(t, temp_filtered, 'r-', 'LineWidth', 2);
plot([0 tf], [55 55], 'k--', 'LineWidth', 1.5);  % horizontal
plot([t_crossing t_crossing], [0 max(temp_raw)], 'g--', 'LineWidth', 1.5);  % vertical
plot([0 tf], [temp_raw_crossing temp_raw_crossing], 'g-', 'LineWidth', 2);  % horizontal
hold off;

legend('Raw', 'Filtered', '55°C limit', sprintf('Crossing at %.1f s', t_crossing), sprintf('Crossing at %.1f C', temp_raw_crossing));
xlabel('Tempo (s)');
ylabel('Temperatura (°C)');
title('Filtro Passa-Baixa');
grid on;
