clear

g = 9.81; % m/s^2
rho = 1.2; % kg/m^3

prec = 1000;
vel = linspace(0,20,prec);

%% Stall Flight
cl_max = 1.6;
cl_min = -0.3;
wing_area = 0.9; % m^2 
m = 3.6; % kg
stall_n_pos = (1/2*rho*cl_max*vel.^2*wing_area)/(m*g);
stall_n_neg = (1/2*rho*cl_min*vel.^2*wing_area)/(m*g);

%% Max Load
max_n_pos = 3*ones(prec,1);
max_n_neg = -1.5*ones(prec,1);

%% Max Q
v_cruise = 14; 
v_dive = v_cruise*1.2; % m/s

figure(1)
vel_imperial = vel*3.28084;
plot(vel_imperial,stall_n_pos,'b--')
hold on
plot(vel_imperial,stall_n_neg,'b--')
hold on 
plot(vel_imperial,max_n_pos,'r--')
hold on 
plot(vel_imperial,max_n_neg,'r--')
hold on
xline(v_dive*3.28084,'--',{'V_D'},'LabelOrientation','horizontal')
hold on
xline(v_cruise*3.28084,'--',{'V_C'},'LabelOrientation','horizontal')
xlabel('Velocity (ft/s)')
ylabel('Load Factor (g)')
xlim([0,inf])
legend('Stall','','Max Load','')