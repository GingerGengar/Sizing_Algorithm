% AAE 451 Team 7
% Written by Ian Greene

clear all;

MIN_X = 0;
MAX_X = .8;
MAX_Y = 50;


v_stall = 15; %(<15ft/s)
p = 0.0023769; % slugs/ft^3
cl_max = 1.5; % CL max value estimate
v_throw = 20; %about 10 to 15 mph is a light throw
%https://www.rcgroups.com/forums/showthread.php?1132350-Hand-Launching-Design-How-fast-is-too-fast-to-throw-a-plane

v_cruise = 26.607; % ft/s
np = 0.75; % % power
cd0 = [0.015, 0.02, 0.025, 0.03, 0.035];
n = 3; %load of 3g
e = 0.7; %span efficiency

g = 32.17405;
max_power = 1.07; % HP
wcalc = 7.1868953440493781315; %lbf
wingArea = 9.7222222222; %ft^2
AR = 7.142857142857142; %aspect ratio

gamma = deg2rad(27.5);
l_d_max = [8, 9];

x_cd = linspace(MIN_X,MAX_X);
y_cd_a = x_cd .* ((0.75 * 550 * np) / (.5 * p * 1.1 * v_cruise^3 * cd0(1)));
y_cd_b = x_cd .* ((0.75 * 550 * np) / (.5 * p * 1.1 * v_cruise^3 * cd0(2)));
y_cd_c = x_cd .* ((0.75 * 550 * np) / (.5 * p * 1.1 * v_cruise^3 * cd0(3)));
y_cd_d = x_cd .* ((0.75 * 550 * np) / (.5 * p * 1.1 * v_cruise^3 * cd0(4)));
y_cd_e = x_cd .* ((0.75 * 550 * np) / (.5 * p * 1.1 * v_cruise^3 * cd0(5)));

y_turn_a = 1 ./ ((.5 * p * v_cruise^2 * cd0(1)) ./ x_cd + x_cd .* n^2/(.5 * p * v_cruise^2 * pi*e*AR));
y_turn_b = 1 ./ ((.5 * p * v_cruise^2 * cd0(2)) ./ x_cd + x_cd .* n^2/(.5 * p * v_cruise^2 * pi*e*AR));
y_turn_c = 1 ./ ((.5 * p * v_cruise^2 * cd0(3)) ./ x_cd + x_cd .* n^2/(.5 * p * v_cruise^2 * pi*e*AR));
y_turn_d = 1 ./ ((.5 * p * v_cruise^2 * cd0(4)) ./ x_cd + x_cd .* n^2/(.5 * p * v_cruise^2 * pi*e*AR));
y_turn_e = 1 ./ ((.5 * p * v_cruise^2 * cd0(5)) ./ x_cd + x_cd .* n^2/(.5 * p * v_cruise^2 * pi*e*AR));

y_ld_a = x_cd .* 0 + ((550 * np) / (1.2 * v_stall * (1 / (0.866 * l_d_max(1)) + sin(gamma))));
y_ld_b = x_cd .* 0 + ((550 * np) / (1.2 * v_stall * (1 / (0.866 * l_d_max(2)) + sin(gamma))));

y_cl = linspace(0,MAX_Y);
x_cl_a = y_cl .* 0 + (.5 * p * v_stall^2 * cl_max);
x_cl_b = y_cl .* 0 + (.5 * p * v_throw^2 * cl_max / 1.21);

figure(1);
plot( x_cl_a, y_cl,'-.', ...
    x_cl_b, y_cl, '-.', ...
    x_cd, y_cd_a, '--', ...
    x_cd, y_cd_b, '--', ...
    x_cd, y_cd_c, '--', ...
    x_cd, y_cd_d, '--', ...
    x_cd, y_cd_e, '--', ...
    x_cd, y_turn_a, ':', ...
    x_cd, y_turn_b, ':', ...
    x_cd, y_turn_c, ':', ...
    x_cd, y_turn_d, ':', ...
    x_cd, y_turn_e, ':', ...
    x_cd, y_ld_a, '-', ...
    x_cd, y_ld_b, '-');

xlabel('Wing Loading W/S (lbf/ft^2)');
ylabel('Power Loading W/P (lbf/hp');
title('Power Loading vs Wing Loading Constraint Diagram - AAE 451 Team 7');
labelset = "Stall Speed @ C_{L max} = " + cl_max;
labelset2 = "Cruise Speed @ C_{D0} = " + cd0;
labelset3 = "Sustained 3G Turn @ C_{D0} = " + cd0;
labelset4 = "Climb Angle @ L/D = " + l_d_max;
legend([labelset, "Hand Thrown @ C_{L max} = " + cl_max, labelset2, labelset3, labelset4]);
grid on;
hold on;
axis([MIN_X MAX_X 0 MAX_Y]);
xConstraint = wcalc/wingArea;
yConstraint = wcalc/max_power;
plot(xConstraint, yConstraint, '*', 'DisplayName',"Constraint Point: (" + xConstraint + ", " + yConstraint + ")")



