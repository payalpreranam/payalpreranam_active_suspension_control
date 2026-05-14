clc;
clear;
close all;

% =====================================
% ACTIVE SUSPENSION SYSTEM
% =====================================

s = tf('s');

G = 1/(s^2 + 3*s + 2);

% PD Controller
Kp = 20;
Kd = 10;

C = Kp + Kd*s;

% Controlled system
sys_cl = feedback(C*G,1);

% =====================================
% TIME VECTOR
% =====================================

t = 0:0.01:10;

% =====================================
% ROAD DISTURBANCES
% =====================================

% Smooth Road
smooth_road = 0.2*sin(0.5*t);

% Speed Breaker
speed_breaker = exp(-(t-3).^2/0.1);

% Pothole
pothole = -exp(-(t-5).^2/0.05);

% Rocky Terrain
rocky = 0.15*randn(size(t));

% =====================================
% SELECT ROAD CONDITION
% =====================================

road = rocky;

% =====================================
% SYSTEM RESPONSES
% =====================================

y1 = lsim(G,road,t);

y2 = lsim(sys_cl,road,t);

% =====================================
% PLOT RESULTS
% =====================================

figure('Color',[0.1 0.1 0.1],...
    'Position',[100 100 1100 700]);

plot(t,y1,'r','LineWidth',2)
hold on

plot(t,y2,'c','LineWidth',2)

plot(t,road,'y--','LineWidth',1.5)

grid on

title('Rocky Terrain Response',...
    'Color','white',...
    'FontSize',18)

xlabel('Time (seconds)',...
    'Color','white',...
    'FontSize',14)

ylabel('Suspension Displacement',...
    'Color','white',...
    'FontSize',14)

legend('Without Controller',...
    'With PD Controller',...
    'Road Disturbance',...
    'TextColor','white',...
    'Location','best')

ax = gca;
ax.Color = [0.15 0.15 0.15];
ax.XColor = 'white';
ax.YColor = 'white';
ax.FontSize = 12;