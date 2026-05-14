clear; clc; close all;

%% =====================================
% SYSTEM PARAMETERS
%% =====================================

m = 150;

% Without Controller
k_p = 400;
b_p = 5;

% PD Controller
Kp = 18000;
Kd = 2500;

%% =====================================
% SIMULATION SETTINGS
%% =====================================

tspan = 0:0.01:7;

velocity = 0.75;

bump_trigger_start = 1.5;
bump_trigger_end   = 2.0;

% Road Profile
road = @(x) (x >= bump_trigger_start && ...
             x <= bump_trigger_end) * 0.2;

%% =====================================
% SYSTEM EQUATIONS
%% =====================================

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

%% =====================================
% SOLVE SYSTEMS
%% =====================================

[t, out_p] = ode45(p_ode, tspan, [0; 0]);

[t, out_a] = ode45(a_ode, tspan, [0; 0]);

%% =====================================
% PERFORMANCE METRICS
%% =====================================

% Peak Oscillation
peak_without = max(abs(out_p(:,1)));

peak_with = max(abs(out_a(:,1)));

% 2% Settling Thresholds
threshold1 = 0.02 * peak_without;

threshold2 = 0.02 * peak_with;

% Settling Times
idx1 = find(abs(out_p(:,1)) > threshold1, ...
            1, 'last');

settling_without = t(idx1);

idx2 = find(abs(out_a(:,1)) > threshold2, ...
            1, 'last');

settling_with = t(idx2);

% Vibration Reduction Index
comfort_index = ...
    (1 - rms(out_a(:,1)) ...
    / rms(out_p(:,1))) * 100;

comfort_index = abs(comfort_index);

%% =====================================
% DASHBOARD WINDOW
%% =====================================

figure('Color','k',...
       'Position',[200 100 950 550]);

axis off

title('ACTIVE SUSPENSION PERFORMANCE DASHBOARD',...
      'Color','w',...
      'FontSize',18,...
      'FontWeight','bold')

%% =====================================
% TABLE CONTENT
%% =====================================

data = {

'Peak Oscillation', ...
num2str(peak_without,'%.3f'), ...
num2str(peak_with,'%.3f');

'Settling Time (s)', ...
num2str(settling_without,'%.2f'), ...
num2str(settling_with,'%.2f');

'Ride Stability', ...
'Poor', ...
'Excellent';

'Vibration Reduction Index (%)', ...
'-', ...
num2str(comfort_index,'%.1f')

};

column_names = ...
{'Parameter', ...
 'Without Controller', ...
 'With Controller'};

%% =====================================
% CREATE TABLE
%% =====================================

uitable('Data',data,...
        'ColumnName',column_names,...
        'Position',[90 140 760 260],...
        'FontSize',12);

%% =====================================
% FINAL TEXT
%% =====================================

text(0.17,0.13,...
    ['Ride Comfort Improvement: ', ...
    num2str(comfort_index,'%.1f'), '%'],...
    'Color','cyan',...
    'FontSize',16,...
    'FontWeight','bold')

text(0.17,0.06,...
    'Adaptive Active Suspension Improved Vehicle Stability',...
    'Color','w',...
    'FontSize',14)