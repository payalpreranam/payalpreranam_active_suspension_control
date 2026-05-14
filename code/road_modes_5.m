
clear; clc; close all;

%% ROAD MODE SELECTION

disp('SELECT ROAD CONDITION');
disp('1 - Smooth Road');
disp('2 - Speed Breaker');
disp('3 - Pothole');
disp('4 - Rough Terrain');

mode = input('Enter mode number: ');

%% TIME

t = 0:0.01:7;

rng(1);
%% ROAD PROFILES

switch mode

    case 1
        road = 0.02*sin(2*pi*t);
        mode_name = 'Smooth Road';

    case 2
        road = 0.2*(t > 1.5 & t < 2);
        mode_name = 'Speed Breaker';

    case 3
        road = -0.25*(t > 1.5 & t < 1.8);
        mode_name = 'Pothole';

    case 4
        road = 0.05*randn(size(t));
        mode_name = 'Rough Terrain';

    otherwise
        road = zeros(size(t));
        mode_name = 'Default Road';

end

%% SYSTEM RESPONSES

without_ctrl = 0.18*exp(-0.5*t).*sin(8*t) + road;

with_ctrl = 0.08*exp(-1.5*t).*sin(8*t) + 0.5*road;

%% FIGURE

figure('Color','k',...
       'Position',[100 100 1200 600]);

%% ROAD PROFILE

subplot(2,1,1);

plot(t, road,...
    'y','LineWidth',2);

title(['Road Condition: ', mode_name],...
      'Color','w',...
      'FontSize',16);

xlabel('Time (s)','Color','w');

ylabel('Road Input','Color','w');

set(gca,...
    'Color','k',...
    'XColor','w',...
    'YColor','w');

grid on;

%% RESPONSE GRAPH

subplot(2,1,2);

plot(t, without_ctrl,...
    'r','LineWidth',2);

hold on;

plot(t, with_ctrl,...
    'c','LineWidth',2);

title('Suspension Response Comparison',...
      'Color','w',...
      'FontSize',16);

xlabel('Time (s)','Color','w');

ylabel('Displacement','Color','w');

legend('Without Controller',...
       'With Controller',...
       'TextColor','w');

set(gca,...
    'Color','k',...
    'XColor','w',...
    'YColor','w');

grid on;