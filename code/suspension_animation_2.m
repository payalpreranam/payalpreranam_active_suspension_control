clear all; close all; clc;

%% 1. Physics Parameters
m = 150;          
k_p = 400; b_p = 5;  % Low damping = High Jitter
Kp = 12000; Kd = 2500; 

%% 2. Simulation & Road Setup
tspan = 0:0.01:7;    
velocity = 0.75; 

% --- BUMP TRIGGER: Starts at 1.5 ---
bump_trigger_start = 1.5;   
bump_trigger_end = 2.0;     

% Road profile function (Physics Engine)
road = @(x) (x >= bump_trigger_start && x <= bump_trigger_end) * 0.2; 

% ODEs
p_ode = @(t, y) [y(2); (-k_p*(y(1)-road(velocity*t)) - b_p*y(2))/m];
a_ode = @(t, y) [y(2); (-Kp*(y(1)-road(velocity*t)) - Kd*y(2))/m];

[t, out_p] = ode45(p_ode, tspan, [0; 0]);
[t, out_a] = ode45(a_ode, tspan, [0; 0]);

% Circle math for wheels
th = 0:pi/10:2*pi; r = 0.1;
xw = r*cos(th); yw = r*sin(th);

%% 3. Animation
figure('Color', 'k', 'Position', [50, 100, 1200, 500]);

for i = 1:4:length(t)
    curr_x = velocity * t(i);

    % --- LEFT: Without PD controller ---
    subplot(1,2,1); cla;
    set(gca, 'Color', 'k', 'XColor', 'w', 'YColor', 'w'); hold on;

    plot([0 5.5], [0 0], 'w', 'LineWidth', 2);
    fill([2.0 2.0 2.5 2.5], [0 0.2 0.2 0], [1 0.5 0]); % Visual block stays at 2.0-2.5

    y_val = out_p(i,1); 
    plot(xw + curr_x, yw + 0.1 + y_val, 'w');
    plot(xw + curr_x + 0.5, yw + 0.1 + y_val, 'w');
    rectangle('Position', [curr_x-0.1, 0.2 + y_val, 0.7, 0.3], 'EdgeColor', 'r', 'LineWidth', 2);

    title('Without PD controller', 'Color', 'r', 'FontSize', 14);
    axis([0 5.5 -0.5 1.5]); grid on;

    % --- RIGHT: Adaptive Active Suspension ---
    subplot(1,2,2); cla;
    set(gca, 'Color', 'k', 'XColor', 'w', 'YColor', 'w'); hold on;

    plot([0 5.5], [0 0], 'w', 'LineWidth', 2);
    fill([2.0 2.0 2.5 2.5], [0 0.2 0.2 0], [0 1 1]);

    y_val_pd = out_a(i,1);
    plot(xw + curr_x, yw + 0.1 + y_val_pd, 'w');
    plot(xw + curr_x + 0.5, yw + 0.1 + y_val_pd, 'w');
    rectangle('Position', [curr_x-0.1, 0.2 + y_val_pd, 0.7, 0.3], 'EdgeColor', 'c', 'LineWidth', 2);

    title('Adaptive Active Suspension', 'Color', 'c', 'FontSize', 14);
    axis([0 5.5 -0.5 1.5]); grid on;

    drawnow;
end