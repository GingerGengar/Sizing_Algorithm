%vel = linspace(15,45)*0.3048; % velocity (m/s)
vel = linspace(0,20);

S = 0.9144; % Reference area (m^2)
rho = 1.225; % density (kg/m^3)
W = 4.66 * 9.8; % Weight (N)
V = 14.8; % Voltage battery (V)
C = 6600/1000; % Battery Capacity (Ah)


%Cd0 = [0.1,0.15,0.25];

FR = 20.19/5.38; % Fulseage length/diameter
FFf = 1 + 60/FR^3 +0.0025*FR;
C_f = 1.328/sqrt(120E3);
nosecone_wettA = 328.95; % in^2
main_wettA = 401.12; % in^2
Cd0 = FFf * C_f*(nosecone_wettA+main_wettA)/(100*14); % fuselage cd0 wetted area/surface area
Cd0 = Cd0+0.042; % wing cd0

k = 1/(pi*0.7*7.1428); % Drag Polar Coefficient

prop_eff = 0.0029*(vel*3.28084-19.51)+0.637;
eff = 0.92*prop_eff; % Total Efficiency
n = 1.3; % Discharge Parameter (dependent on battery type and temperature)
Rt = 20; % Battery Hour Rating (hours)

endurance = zeros(length(Cd0),length(vel));

for i = 1:length(Cd0)
    endurance(i,:) = 0.5*Rt^(1-n)*(eff*V*C./(0.5*rho*vel.^3*S*Cd0(i)+(2*W^2*k./(rho*vel*S)))).^n * 60; % minutes
end

[max_end,ind]=max(endurance);

figure(1)
subplot(2,1,1)
for i = 1:length(Cd0)
    plot(vel*3.28084,endurance(i,:))
    hold on
end
plot(vel(ind)*3.28084,max_end,'r*')
hold on
text(vel(ind)*3.28084,max_end+0.5,'V_c = 25 ft/s')
xlabel('Cruise Velocity (ft/s)')
ylabel('Endurance (min)')
yline(10,'r-','10 min RFP Endurance Req')
hold on
xline(15,'k-','Stall Speed')
title('Cruise Speed vs Endurance')
subtitle('Accounting for Prop Efficiency & Temperature')
ylim([0,25])
%legend("Cd_0 = 0.1","Cd_0 = 0.25","Cd_0 = 0.3","Cd_0 = 0.4")
%Cd0 = [0.1,0.25,0.30,0.4];

range = 60*endurance(i,:).*vel*3.28084*0.000189394; % miles
[max_range,ind]=max(range);

subplot(2,1,2)
for i = 1:length(Cd0)
    plot(vel*3.28084,range)
    hold on
end
plot(vel(ind)*3.28084,max_range,'r*')
hold on
text(vel(ind)*3.28084,max_range+0.1,'V_c = 31 ft/s')
ylim([0,7])
xlabel('Cruise Velocity (ft/s)')
ylabel('Distance Travelled (miles)')
title('Cruise Speed vs Range')
subtitle('Accounting for Prop Efficiency & Temperature')
hold on
xline(15,'k-','Stall Speed')