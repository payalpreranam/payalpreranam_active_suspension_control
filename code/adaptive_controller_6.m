clc;
clear;
close all;

% =====================================
% ACTIVE SUSPENSION SYSTEM
% =====================================

s = tf('s');

G = 1/(s^2 + 3*s + 2);

% =====================================
% TIME VECTOR
% =====================================

t = 0:0.01:10;

% =====================================
% ROAD DISTURBANCE
% =====================================

% Try changing this later
road = exp(-(t-3).^2/0.1);

% =====================================
% ADAPTIVE CONTROL LOGIC
% =====================================

road_intensity = max(abs(road));

if road_intensity > 0.7

    % Rough road / pothole
    Kp = 2;
    Kd = 1;

    mode_text = 'ROUGH ROAD MODE';

else

    % Smooth road
    Kp = 1;
    Kd = 0.5;

    mode_text = 'SMOOTH ROAD MODE';

end

% =====================================
% PD CONTROLLER
% =====================================

C = Kp + Kd*s;

% Controlled system
sys_cl = feedback(C*G,1);

% =====================================
% SYSTEM RESPONSES
% =====================================

y1 = lsim(G,road,t);

y2 = lsim(sys_cl,road,t);

% =====================================
% PERFORMANCE METRICS
% =====================================

improvement = abs((1 - rms(y2)/rms(y1)) * 100);

% PLOT RESULTS
% =====================================

figure('Color',[0.1 0.1 0.1],...
       'Position',[100 100 1200 700]);

plot(t,y1,'r','LineWidth',2)
hold on

plot(t,y2,'c','LineWidth',2)

plot(t,road,'y--','LineWidth',1.5)

grid on

title('Adaptive Active Suspension System',...
      'Color','white',...
      'FontSize',18)

xlabel('Time (seconds)',...
       'Color','white',...
       'FontSize',14)

ylabel('Suspension Displacement',...
       'Color','white',...
       'FontSize',14)

legend('Without Controller',...
       'Adaptive PD Controller',...
       'Road Disturbance',...
       'TextColor','white',...
       'Location','best')

ax = gca;
ax.Color = [0.15 0.15 0.15];
ax.XColor = 'white';
ax.YColor = 'white';
ax.FontSize = 12;

% =====================================
% DISPLAY TEXT
% =====================================

text(6,0.8,...
    ['Mode: ', mode_text],...
    'Color','white',...
    'FontSize',14,...
    'FontWeight','bold')

text(6,0.7,...
    ['Vibration Reduction Index: ',...
    num2str(improvement,'%.1f'),'%'],...
    'Color','cyan',...
    'FontSize',14,...
    'FontWeight','bold')