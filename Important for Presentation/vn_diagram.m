clear

g = 9.81; % m/s^2
rho = 1.2; % kg/m^3

prec = 1000;
vel = linspace(0,20,prec);

%% Stall Flight
cl_max_noflap = 1.6;
cl_min_noflap = -0.3;
wing_area = 0.9; % m^2 
m = 3.6; % kg
stall_n_pos_noflap = (1/2*rho*cl_max_noflap*vel.^2*wing_area)/(m*g);
stall_n_neg_noflap = (1/2*rho*cl_min_noflap*vel.^2*wing_area)/(m*g);
v_1g_pos = vel(find(stall_n_pos_noflap>1,1));
v_1g_neg = vel(find(stall_n_neg_noflap<-1,1));

%% Max Load
max_n = 3;
min_n = -1.5;

max_n_pos = max_n*ones(prec,1); % For plotting
max_n_neg = min_n*ones(prec,1);
v_a = vel(find(stall_n_pos_noflap>max_n,1)); % Manuevering Speed

%% Max Q
v_cruise = 7.62; 
v_dive = 13; % m/s

%% Gust Speeds
Cl_alpha = 0.7;
gusts = [-30,-15,15,30]*0.514444; % knots => m/s
gust_load = zeros(length(gusts),prec);
for i = 1:length(gusts)
    gust_load(i,:) = rho*gusts(i)*vel*Cl_alpha/(2*m*g/wing_area) + 1;
end

figure(1)
vel_imperial = vel*3.28084;
plot(vel_imperial,stall_n_pos_noflap,'b--')
hold on
plot(vel_imperial,stall_n_neg_noflap,'b--')
hold on 
plot(vel_imperial,max_n_pos,'r--')
hold on 
plot(vel_imperial,max_n_neg,'r--')
hold on
xline(v_dive*3.28084,'-',{'V_D'},'LabelOrientation','horizontal')
hold on
xline(v_cruise*3.28084,'--',{'V_C'},'LabelOrientation','horizontal')
hold on
%xline(v_1g_pos*3.28084,'--',{'V_{stall,1g}'},'LabelOrientation','horizontal')
plot(v_1g_pos*3.28084,1,'r*')
hold on
%xline(v_1g_neg*3.28084,'--',{'V_{stall,1g}'},'LabelOrientation','horizontal')
plot(v_1g_neg*3.28084,-1,'r*')
hold on
xline(v_a*3.28084,'--',{'V_a'},'LabelOrientation','horizontal')
for i = 1:length(gusts)
    plot(vel_imperial,gust_load(i,:),'k-.')
    hold on
end
yline(0)
xlabel('Velocity (ft/s)')
ylabel('Load Factor (g)')
xlim([0,45])
ylim([min_n-1,max_n+1])
legend('Stall','','Max Load','','','','1g','','',"Gust Load @ -30,-15,15,30 Knots",'Location','northwest')
title('V-n Diagram')