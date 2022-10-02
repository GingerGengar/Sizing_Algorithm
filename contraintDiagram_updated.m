% AAE 451 Team 7
% Written by Cooper LeComp and John Papas Dennerline on 2022 09 09

%% Deliverables/Constants
v_stall = 4; % m/s (<15ft/s)
v_cruise = 15; % m/s
p = 1.225; % kg/m^3
np = 0.75; % power eff
gamma = deg2rad(25); % Climb Angle

%% Our design 
cd0 = [0.015, 0.02, 0.025, 0.03, 0.035];
cl_max = [0.9, 1, 1.1, 1.2, 1.3]; % CL max value estimate
l_d_max = [4, 6, 8, 10, 12];

n = 3;
e = 0.7; %span efficiency
AR = 7.142857142857142; %aspect ratio

max_power = 786.9837; % watts
weight = 8.031; % lbf
wing_area = 8.33333; %ft^2
motor_power = max_power*0.00134102; %hp

wing_load = weight/wing_area;
power_load = weight/motor_power;

%% Plotting
MIN_X = 0;
MAX_X = 0.5;
MAX_Y = 20;

x_cd = MIN_X:0.1:MAX_X; % Wing Loading
y_cl = 0:0.1:MAX_Y; % Power Loading

y_cd = zeros(5,length(x_cd));
y_ld = zeros(5,length(x_cd));
x_cl = zeros(5,length(y_cl));
y_3g = zeros(5,length(x_cd));
for i = 1:5
    % Cruise Speed
    power_inv = 1/(.5 * p * 1.1 * (v_cruise)^3 * cd0(i)) ; % m^2/watt
    power_inv = power_inv*(1/0.00134102)*(3.28084^2); % ft^2/hp
    y_cd(i,:) = x_cd.*power_inv; % lbs/hp (x_cd is in units of lbf/ft^2)

    % Climb Angle
    y_ld(i,:) = x_cd .* 0 + (np / (v_cruise * (1 / (0.866 * l_d_max(i)) + sin(gamma)))); % s/m
    y_ld(i,:) = y_ld(i,:)/3.28084; % s/ft
    y_ld(i,:) = 550*y_ld(i,:); % lbf/hp (550 ft*lbf/s = 1 hp)

    % Stall Speed
    x_cl(i,:) = y_cl .* 0 + (.5 * p * v_stall^2 * cl_max(i)); % N/m^2
    x_cl(i,:) = x_cl(i,:)*0.224809/(3.28084^2); % lbf/ft^2

    % 3G Turn
    V_turn = v_stall*sqrt(n);
    q = 0.5*p*V_turn^2;
    wing_loading_SI = x_cd*47.880172;

    thrust2weight = q*(cd0(i)./(wing_loading_SI)+n^2/(q*pi*e*AR)*wing_loading_SI); % watts/N
    thrust2weight = thrust2weight*V_turn/np; % watts/N
    thrust2weight = thrust2weight*0.00134102/0.224809; % hp/W
    y_3g(i,:) = 1./thrust2weight;
end

%% PLotting
figure(1)
for i = 1:5
    plot(x_cl(i,:), y_cl,'r');
    hold on
    plot(x_cd, y_cd(i,:),'b');
    hold on
    plot(x_cd, y_ld(i,:),'g');
    hold on
    plot(x_cd,y_3g(i,:),'k')
    hold on
end
plot(wing_load,power_load,'kx')
hold on
text(wing_load+0.01,power_load,'Current Design')

xlabel('Wing Loading W/S (lbf/ft^2)');
ylabel('Power Loading W/P (lbf/hp)');
title('AAE 451 Team 7 Constraint Diagram');
grid on;
axis([MIN_X MAX_X 0 MAX_Y]);

hleg = legend('Stall Speed','Cruise Speeed','Climb Angle','3G Turn');
htitle = get(hleg,'Title');
set(htitle,'String','Constraints')