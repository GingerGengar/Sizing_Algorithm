clear 
% read normalized wing loading 
filename = 'Wing_Graph_0_LIFT DISTRIBUTION.csv';

output_mat = readmatrix(filename);
output_mat= rmmissing(output_mat);

b = 1.2678*2; % span (m)
x = output_mat(:,1)/1.2678; % normalized by half span

%% Lift Load
N = 1;
V_Cruise = 7.67675376; % m/s
[x_uniform,moment_cruise,deflection_cruise,load_XFRL,load_approx,deflection_approx,moment_approx] = wing_deflection_fun(N,V_Cruise);

N = 3; 
V_3G = 10.9728; 
[~,moment_3G,deflection_3G,~,~,~,~] = wing_deflection_fun(N,V_3G);

N = 1;
V_max = 13; %V_Cruise*1.2; % m/s
[~,moment_maxVel,deflection_maxVel,~,~,~,~] = wing_deflection_fun(N,V_max);

%% Comparing Loads
figure(1)
subplot(2,1,1)
plot(x_uniform,moment_cruise)
hold on
plot(x_uniform,moment_maxVel)
hold on
plot(x_uniform,moment_3G)
hold on 
yline(42,'k--','Motor/Wing Mount Threshold')
legend('Cruise @ 25 ft/s','Max Speed','3G Turn @ V_a')
xlabel('% Half Span')
ylabel('Bending Moment (lbs-ft)')
grid
hold off
title('Bending Moment along Wing')
ylim([0,50])

subplot(2,1,2)
plot(x_uniform*b*39.3701/2,deflection_cruise)
hold on
plot(x_uniform*b*39.3701/2,deflection_maxVel)
hold on
plot(x_uniform*b*39.3701/2,deflection_3G)
xlabel('Distance from Plane Centerline (inches)')
ylabel('Deflection (inches)')
grid
title('Deflection along Wing')
legend('Cruise @ 25 ft/s','Max Speed','3G Turn @ V_a')
%title('Deflection along Wing (axis equalled)')
%axis equal


% figure(1)
% subplot(2,1,1)
% plot(x_uniform,moment_cruise,x_uniform,moment_approx)
% legend('XFLR Results','Elliptic Distribution')
% xlabel('% Half Span')
% ylabel('Bending Moment (lbs-ft)')
% grid
% hold off
% 
% subplot(2,1,2)
% plot(x_uniform,deflection_cruise,x_uniform,deflection_approx,'r')
% xlabel('% Half Span')
% ylabel('Deflection (inches)')
% grid
% %legend('XFLR Results','Elliptic Distribution')
% %title('Deflection along Wing')
% 
% figure
% plot(x,load_XFRL*0.2248090795)
% hold on
% plot(-x_uniform,load_approx*0.2248090795,'r-',x_uniform,load_approx*0.2248090795,'r-')
% xlabel('% Half Span')
% ylabel('Load (lbs)')
% grid
% legend('XFLR Results','Elliptic Distribution')
% xlim([-1,1])