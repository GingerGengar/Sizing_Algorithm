% AAE 451 Team 7
% Written by Cooper LeComp and John Papas Dennerline on 2022 09 09

figure(1);

MIN_X = 0;
MAX_X = 1;
MAX_Y = 20;

v_stall = 4; % m/s (<15ft/s)
p = 1.225; % kg/m^3
cl_max = [0.9, 1, 1.1, 1.2, 1.3]; % CL max value estimate

v_cruise = 15; % m/s
max_power = 786.9837; % watts
np = 0.75; % power eff
cd0 = [0.015, 0.02, 0.025, 0.03, 0.035];

gamma = deg2rad(27.5);
l_d_max = [4, 6, 8, 10, 12];

g = 32.17405;

x_cd = MIN_X:0.1:MAX_X;
y_cl = 0:0.1:MAX_Y;
y_cd = zeros(5,length(x_cd));
y_ld = zeros(5,length(x_cd));
x_cl = zeros(5,length(y_cl));
for i = 1:5
    power_inv = 1/(.5 * p * 1.1 * (v_cruise)^3 * cd0(i)) ; % m^2/watt
    power_inv = power_inv*(1/0.00134102)*(3.28084^2); % ft^2/hp
    y_cd(i,:) = x_cd.*power_inv; % lbs/hp (x_cd is in units of lbf/ft^2)

    y_ld(i,:) = x_cd .* 0 + ((max_power * np) / (v_cruise * (1 / (0.866 * l_d_max(i)) + sin(gamma)))); % watts/(m/s) -> N
    y_ld(i,:) = (y_ld(i,:)*0.224809); % lbf

    x_cl(i,:) = y_cl .* 0 + (.5 * p * v_stall^2 * cl_max(i)); % N/m^2
    x_cl(i,:) = x_cl(i,:)*0.224809/(3.28084^2); % lbf/ft^2
end

plot( ...
    x_cl(1,:), y_cl,'-.', ...
    x_cl(2,:), y_cl,'-.', ...
    x_cl(3,:), y_cl,'-.', ...
    x_cl(4,:), y_cl,'-.', ...
    x_cl(5,:), y_cl,'-.', ...
    x_cd, y_cd(1,:), '--', ...
    x_cd, y_cd(2,:), '--', ...
    x_cd, y_cd(3,:), '--', ...
    x_cd, y_cd(4,:), '--', ...
    x_cd, y_cd(5,:), '--', ...
    x_cd, y_ld(1,:), '-', ...
    x_cd, y_ld(2,:), '-', ...
    x_cd, y_ld(3,:), '-', ...
    x_cd, y_ld(4,:), '-', ...
    x_cd, y_ld(5,:), '-');

    hold on
    weight = 8.031; % lbf
    wing_area = 8.33333; %ft^2
    motor_power = 1.07; %hp
    wing_load = weight/wing_area;
    power_load = weight/motor_power;
    plot(wing_load,power_load,'kx')
    hold on
    text(wing_load+0.1,power_load,'Current Design')

xlabel('Wing Loading W/S (lbf/ft^2)');
ylabel('Power Loading W/P (lbf/hp)');
title('Power Loading vs Wing Loading Constraint Diagram - AAE 451 Team 7');
labelset = "C_{L max} = " + cl_max;
labelset2 = "C_{D0} = " + cd0;
labelset3 = "L/D = " + l_d_max;
%legend([labelset, labelset2, labelset3]);
grid on;
axis([MIN_X MAX_X 0 MAX_Y]);