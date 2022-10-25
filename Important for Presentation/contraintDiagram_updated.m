% AAE 451 Team 7
% Written by Cooper LeComp and John Papas Dennerline on 2022 09 09

%% Deliverables/Constants
v_stall = 4.5; % m/s (<15ft/s)
v_stall2 = 8; 
v_cruise = 11; % m/s
p = 1.225; % kg/m^3
np = 0.75; % power eff
gamma = deg2rad(25); % Climb Angle

%% Our design 
cd0 = 0.035* ones(5,1); %[0.015, 0.02, 0.025, 0.03, 0.035]; %[0.015, 0.02, 0.025, 0.03, 0.035];
cl_max = [1.5, 1.5, 1.5, 1.5, 1.5]; % CL max value estimate
l_d_max = [10, 10, 10, 10, 10];

n = 3;
e = 0.8; % span efficiency

%% Designs
% Old design
max_power = 786.9837; % watts
weight = 8.031; % lbf
span = 8; % ft
chord = 1; % ft
wing_area = span*chord; % ft^2
motor_power = max_power*0.00134102; % hp

wing_load_old = weight/wing_area;
power_load_old = weight/motor_power;

% New design
max_power = 786.9837; % watts
weight = 7.061; % lbf
span = 100/12; % ft
chord = 14/12; % ft
wing_area = span*chord; % ft^2
motor_power = max_power*0.00134102; % hp

wing_load_new = weight/wing_area;
power_load_new = weight/motor_power;

T = 15; %lbf
AoA_stall = 15; % deg

AR = span/chord;

%% Plotting
MIN_X = 0;
MAX_X = 2;
MAX_Y = 100;

x_cd = linspace(MIN_X,MAX_X,1000); % Wing Loading
y_cl = 0:0.1:MAX_Y; % Power Loading

testcase = length(cd0); % number of test cases
y_cd = zeros(5,length(x_cd));
y_ld = zeros(testcase,length(x_cd));
x_cl = zeros(testcase,length(y_cl));
x_cl2 = zeros(testcase,length(y_cl));
x_cl3 = zeros(testcase,length(y_cl));
y_3g = zeros(testcase,length(x_cd));
for i = 1:testcase
    % Cruise Speed
    power_inv = 1/(.5 * p * 1.1 * (v_cruise)^3 * cd0(i)) ; % m^2/watt
    power_inv = power_inv*(1/0.00134102)*(3.28084^2); % ft^2/hp
    y_cd(i,:) = x_cd.*power_inv; % lbf/hp (x_cd is in units of lbf/ft^2)

    % Climb Angle
    y_ld(i,:) = x_cd .* 0 + (np / (v_cruise * (1 / (0.866 * l_d_max(i)) + sin(gamma)))); % s/m
    y_ld(i,:) = y_ld(i,:)/3.28084; % s/ft
    y_ld(i,:) = 550*y_ld(i,:); % lbf/hp (550 ft*lbf/s = 1 hp)

    % Stall Speed
    x_cl(i,:) = y_cl .* 0 + (.5 * p * v_stall^2 * cl_max(i)); % N/m^2
    x_cl(i,:) = x_cl(i,:)*0.224809/(3.28084^2); % lbf/ft^2

    x_cl2(i,:) = y_cl .* 0 + (.5 * p * v_stall2^2 * cl_max(i)); % N/m^2
    x_cl2(i,:) = x_cl2(i,:)*0.224809/(3.28084^2); % lbf/ft^2

    % Power-on Stall 
    x_cl3(i,:) = y_cl .* 0 + (.5 * p * v_stall^2 * cl_max(i)); % N/m^2
    x_cl3(i,:) = T/wing_area*sind(AoA_stall)+x_cl3(i,:)*0.224809/(3.28084^2); % lbf/ft^2

    % 3G Turn
    V_turn = v_stall*sqrt(n);
    q = 0.5*p*V_turn^2; % N/m^2
    wing_loading_SI = x_cd*47.880172; % N/m^2

    thrust2weight = q*(cd0(i)./(wing_loading_SI))+n^2/(q*pi*e*AR)*wing_loading_SI; % N/N
    thrust2weight = thrust2weight*V_turn/np; % watts/N
    thrust2weight = thrust2weight*0.00134102/0.224809; % hp/W
    y_3g(i,:) = 1./thrust2weight;
end

%% PLotting
figure(1)
for i = 1:testcase
    plot(x_cl(i,:), y_cl,'--r');
    hold on
    plot(x_cl2(1,:), y_cl,'r');
    hold on
    plot(x_cl3(1,:), y_cl,'--r');
    hold on
    plot(x_cd, y_cd(i,:),'b');
    hold on
    plot(x_cd, y_ld(i,:),'g');
    hold on
    plot(x_cd,y_3g(i,:),'k')
    hold on
end
% plot(wing_load_old,power_load_old,'ko')
% hold on
% text(wing_load_old+0.03,power_load_old,'Previous Design','HorizontalAlignment','left')
hold on 
plot(wing_load_new,power_load_new,'kx')
hold on
text(wing_load_new+0.03,power_load_new,'Current Design','HorizontalAlignment','left')


hold on
h = text(x_cl(1,1)-0.03, 30,'Power-off Stall');
set(h,'Rotation',90);
hold on
s = text(x_cl2(1,1)-0.03, 30,'Historical');
set(s,'Rotation',90);
hold on
h = text(x_cl3(1,1)-0.03, 30,'Power-on Stall');
set(h,'Rotation',90);

xlabel('Wing Loading W/S (lbf/ft^2)');
ylabel('Power Loading W/P (lbf/hp)');
title('AAE 451 Team 7 Constraint Diagram');
grid on;
%axis([MIN_X MAX_X 0 MAX_Y]);
xlim([0,1.5])
ylim([-inf, 75])
hleg = legend('','Stall Speed','','Cruise Speed','Climb Angle','3G Turn');
htitle = get(hleg,'Title');
set(htitle,'String','Constraints')