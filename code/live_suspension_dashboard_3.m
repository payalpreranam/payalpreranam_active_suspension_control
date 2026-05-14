clear all;
close all;
clc;

%% =====================================
% ACTIVE SUSPENSION LIVE DASHBOARD
%% =====================================

%% SYSTEM PARAMETERS

m = 150;

% Passive Suspension
k_p = 400;
b_p = 5;

% PD Controller
Kp = 12000;
Kd = 2500;

%% SIMULATION SETTINGS

tspan = 0:0.01:7;

velocity = 0.75;

% Bump Region
bump_trigger_start = 1.5;
bump_trigger_end   = 2.0;

%% ROAD PROFILE

road = @(x) ...
       (x >= bump_trigger_start && ...
        x <= bump_trigger_end) * 0.2;

%% ODE MODELS

% Without Controller
p_ode = @(t, y) ...
    [y(2);
    (-k_p*(y(1)-road(velocity*t)) ...
    - b_p*y(2))/m];

% With PD Controller
a_ode = @(t, y) ...
    [y(2);
    (-Kp*(y(1)-road(velocity*t)) ...
    - Kd*y(2))/m];

%% SOLVE SYSTEMS

[t, out_p] = ode45(p_ode, tspan, [0; 0]);

[t, out_a] = ode45(a_ode, tspan, [0; 0]);

%% WHEEL SHAPE

th = 0:pi/10:2*pi;

r = 0.1;

xw = r*cos(th);

yw = r*sin(th);

%% FIGURE WINDOW

figure('Color', 'k', ...
       'Position', [20 20 1500 850]);

%% =====================================
% ANIMATION LOOP
%% =====================================

for i = 1:4:length(t)

    curr_x = velocity * t(i);

    clf;

    %% =====================================
    % LEFT TOP - WITHOUT CONTROLLER
    %% =====================================

    subplot(2,2,1);

    set(gca, ...
        'Color', 'k', ...
        'XColor', 'w', ...
        'YColor', 'w');

    hold on;

    % Road
    plot([0 5.5], [0 0], ...
         'w', 'LineWidth', 2);

    % Speed Breaker
    fill([2.0 2.0 2.5 2.5], ...
         [0 0.2 0.2 0], ...
         [1 0.5 0]);

    % Suspension Response
    y_val = out_p(i,1);

    % Wheels
    plot(xw + curr_x, ...
         yw + 0.1 + y_val, ...
         'w', 'LineWidth', 1.5);

    plot(xw + curr_x + 0.5, ...
         yw + 0.1 + y_val, ...
         'w', 'LineWidth', 1.5);

    % Vehicle Body
    rectangle('Position', ...
             [curr_x-0.1, ...
              0.2 + y_val, ...
              0.7, 0.3], ...
             'EdgeColor', 'r', ...
             'LineWidth', 2);

    title('Without PD Controller', ...
          'Color', 'r', ...
          'FontSize', 14, ...
          'FontWeight', 'bold');

    axis([0 5.5 -0.5 1.5]);

    grid on;

    %% =====================================
    % RIGHT TOP - WITH CONTROLLER
    %% =====================================

    subplot(2,2,2);

    set(gca, ...
        'Color', 'k', ...
        'XColor', 'w', ...
        'YColor', 'w');

    hold on;

    % Road
    plot([0 5.5], [0 0], ...
         'w', 'LineWidth', 2);

    % Speed Breaker
    fill([2.0 2.0 2.5 2.5], ...
         [0 0.2 0.2 0], ...
         [0 1 1]);

    % Controlled Response
    y_val_pd = out_a(i,1);

    % Wheels
    plot(xw + curr_x, ...
         yw + 0.1 + y_val_pd, ...
         'w', 'LineWidth', 1.5);

    plot(xw + curr_x + 0.5, ...
         yw + 0.1 + y_val_pd, ...
         'w', 'LineWidth', 1.5);

    % Vehicle Body
    rectangle('Position', ...
             [curr_x-0.1, ...
              0.2 + y_val_pd, ...
              0.7, 0.3], ...
             'EdgeColor', 'c', ...
             'LineWidth', 2);

    title('Adaptive Active Suspension', ...
          'Color', 'c', ...
          'FontSize', 14, ...
          'FontWeight', 'bold');

    axis([0 5.5 -0.5 1.5]);

    grid on;

    %% =====================================
    % BOTTOM - LIVE RESPONSE GRAPH
    %% =====================================

    subplot(2,1,2);

    set(gca, ...
        'Color', 'k', ...
        'XColor', 'w', ...
        'YColor', 'w');

    hold on;

    % Without Controller Graph
    plot(t(1:i), ...
         out_p(1:i,1), ...
         'r', ...
         'LineWidth', 2);

    % With Controller Graph
    plot(t(1:i), ...
         out_a(1:i,1), ...
         'c', ...
         'LineWidth', 2);

    title('Real-Time Suspension Response', ...
          'Color', 'w', ...
          'FontSize', 15, ...
          'FontWeight', 'bold');

    xlabel('Time (seconds)', ...
           'FontSize', 13, ...
           'Color', 'white');

    ylabel('Displacement', ...
           'FontSize', 13, ...
           'Color', 'white');

    legend('Without Controller', ...
           'With Controller', ...
           'TextColor', 'w', ...
           'Location', 'northeast');

    axis([0 7 -0.3 0.3]);

    grid on;

    drawnow;

end