clc;
clear;
close all;

% ==============================
% ACTIVE SUSPENSION SYSTEM
% ==============================

% Define transfer function
s = tf('s');

G = 1/(s^2 + 3*s + 2);

% PD Controller Parameters
Kp = 4.25;
Kd = 1;

C = Kp + Kd*s;

% Closed-loop controlled system
sys_cl = feedback(C*G,1);

% ==============================
% CREATE FIGURE
% ==============================

figure('Color',[0.1 0.1 0.1], ...
    'Position',[100 100 1000 600]);

% Step Responses
step(G,'r','LineWidth',2.5)
hold on

step(sys_cl,'c','LineWidth',2.5)

grid on

% ==============================
% LABELS & TITLE
% ==============================

title('Active Suspension System Response', ...
    'FontSize',18, ...
    'FontWeight','bold', ...
    'Color','white');


xlabel('Time (seconds)', ...
    'FontSize',14, ...
    'Color','white');

ylabel('Displacement', ...
    'FontSize',14, ...
    'Color','white');

legend({'Without Controller','With PD Controller'}, ...
    'TextColor','white', ...
    'Location','southeast');

% ==============================
% AXIS STYLING
% ==============================


% ==============================
% PERFORMANCE INFO
% ==============================

info_uncontrolled = stepinfo(G);
info_controlled = stepinfo(sys_cl);

disp('WITHOUT CONTROLLER')
disp(info_uncontrolled)

disp('WITH PD CONTROLLER')
disp(info_controlled)

fprintf('\nSettling Time Improvement = %.2f %%\n', ...
    ((info_uncontrolled.SettlingTime - ...
    info_controlled.SettlingTime) / ...
    info_uncontrolled.SettlingTime)*100);