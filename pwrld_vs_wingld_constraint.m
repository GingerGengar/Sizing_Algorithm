% AAE 451 Team 7
% Written by Cooper LeComp and John Papas Dennerline on 2022 09 09

figure(1);

MIN_X = 0;
MAX_X = .5;
MAX_Y = 10;


v_stall = 4; % m/s (<15ft/s)
p = 1.225; % kg/m^3
cl_max = [0.9, 1, 1.1, 1.2, 1.3]; % CL max value estimate

v_cruise = 15; % m/s
max_power = 100; % W
np = 0.75; % % power
cd0 = [0.015, 0.02, 0.025, 0.03, 0.035];

gamma = deg2rad(27.5);
l_d_max = [4, 6, 8, 10, 12];

g = 32.17405;

x_cd = MIN_X:0.1:MAX_X;
y_cd_a = x_cd .* ((max_power * np) / (.5 * p * 1.1 * v_cruise^3 * cd0(1))) * g;
y_cd_b = x_cd .* ((max_power * np) / (.5 * p * 1.1 * v_cruise^3 * cd0(2))) * g;
y_cd_c = x_cd .* ((max_power * np) / (.5 * p * 1.1 * v_cruise^3 * cd0(3))) * g;
y_cd_d = x_cd .* ((max_power * np) / (.5 * p * 1.1 * v_cruise^3 * cd0(4))) * g;
y_cd_e = x_cd .* ((max_power * np) / (.5 * p * 1.1 * v_cruise^3 * cd0(5))) * g;

y_ld_a = x_cd .* 0 + ((max_power * np) / (v_cruise * (1 / (0.866 * l_d_max(1)) + sin(gamma))));
y_ld_b = x_cd .* 0 + ((max_power * np) / (v_cruise * (1 / (0.866 * l_d_max(2)) + sin(gamma))));
y_ld_c = x_cd .* 0 + ((max_power * np) / (v_cruise * (1 / (0.866 * l_d_max(3)) + sin(gamma))));
y_ld_d = x_cd .* 0 + ((max_power * np) / (v_cruise * (1 / (0.866 * l_d_max(4)) + sin(gamma))));
y_ld_e = x_cd .* 0 + ((max_power * np) / (v_cruise * (1 / (0.866 * l_d_max(5)) + sin(gamma))));

y_cl = 0:0.1:MAX_Y;
x_cl_a = y_cl .* 0 + (.5 * p * v_stall^2 * cl_max(1)) / g;
x_cl_b = y_cl .* 0 + (.5 * p * v_stall^2 * cl_max(2)) / g;
x_cl_c = y_cl .* 0 + (.5 * p * v_stall^2 * cl_max(3)) / g;
x_cl_d = y_cl .* 0 + (.5 * p * v_stall^2 * cl_max(4)) / g;
x_cl_e = y_cl .* 0 + (.5 * p * v_stall^2 * cl_max(5)) / g;

plot( ...
    x_cl_a, y_cl,'-.', ...
    x_cl_b, y_cl,'-.', ...
    x_cl_c, y_cl,'-.', ...
    x_cl_d, y_cl,'-.', ...
    x_cl_e, y_cl,'-.', ...
    x_cd, y_cd_a, '--', ...
    x_cd, y_cd_b, '--', ...
    x_cd, y_cd_c, '--', ...
    x_cd, y_cd_d, '--', ...
    x_cd, y_cd_e, '--', ...
    x_cd, y_ld_a, '-', ...
    x_cd, y_ld_b, '-', ...
    x_cd, y_ld_c, '-', ...
    x_cd, y_ld_d, '-', ...
    x_cd, y_ld_e, '-');

xlabel('Wing Loading W/S (lbf/ft^2)');
ylabel('Power Loading W/P (lbf/hp');
title('Power Loading vs Wing Loading Constraint Diagram - AAE 451 Team 7');
labelset = "C_{L max} = " + cl_max;
labelset2 = "C_{D0} = " + cd0;
labelset3 = "L/D = " + l_d_max;
legend([labelset, labelset2, labelset3]);
grid on;
axis([MIN_X MAX_X 0 MAX_Y]);



