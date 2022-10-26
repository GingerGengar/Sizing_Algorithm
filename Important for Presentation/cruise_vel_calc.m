%vel = linspace(15,45)*0.3048; % velocity (m/s)
vel = linspace(0,25);

S = 0.32; % Reference area (m^2)
rho = 1.225; % density (kg/m^3)
W = 44; % Weight (N)
V = 14.8; % Voltage battery (V)
C = 6600/1000; % Battery Capacity (Ah)

Cd0 = 0.015;
k = 0.13; % Drag Polar Coefficient
eff = 0.70; % Total Efficiency
n = 1.3; % Discharge Parameter (dependent on battery type and temperature)
Rt = 1; % Battery Hour Rating (hours)

endurance = Rt^(1-n)*(eff*V*C./(0.5*rho*vel.^3*S*Cd0+(2*W^2*k./(rho*vel*S)))).^n * 60; % minutes

figure(1)
plot(vel*3.28084,endurance)
xlabel('Cruise Velocity (ft/s)')
ylabel('Endurance (min)')
yline(10,'r-','10 min RFP Endurance Req')