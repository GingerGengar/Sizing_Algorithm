%%Give Definition of Global variable
Global_Variables;

%%Variables which are known/guessed (independent)

%Variables Needed to Compute the Wing Loading and Thrust to Weight Ratio
g = 9.81; %This is the local gravitational accel (m/s^2)
rho = 1.225; %This is the density of the air
v_stall = 8; %This is the estimation for stall speed
c_Lmax = 1.2; %the maximum lift coefficient we can get
climb_angle = 25; %This is from the RFP
c_D0 = 0.03; %This is the drag coefficient near stall speed
A_r = 9; %Aspect ratio of the main wing, typical values
e = 0.8; %efficiency of the wing due to deviating from elliptic lift distribution

%Variables that are needed to compute the total weight of the aircraft
Engine_Thrust = 40; %This is force produced by engine, units are in Newtons (N)

%Variables that are needed to compute the mass of the batteries
endurance = 900; %seconds of flight. This corresponds to 15 minutes of flight
Motor_Power = 200; %This is the power of the motor (W), has to be in cruise conditions
Batt_Specific_Energy = 0.655*10^6; %This is Energy/Mass, so its unit has to be (J/kg)

%Variables that are needed to compute the Lift Devices
Main_Wing_Thickness = 0.07; %Units in meters
Ave_Density_Main_Wing = 24.82862; % Density of Wing Material (kg/m^3)

%%Directly Known Masses of the Aircraft

%Mass of the Motor and Propeller of Aircraft
Motor_Prop_Mass = 0.2; %This is in kg and taken from manufacturer

%Mass of the Prescribed Avionics
mass_pixhawk = 0.037;  % Units in kg
mass_servos = 0.03 * 5; % Units in kg

%Mass of the Payload
payload_mass = 1.5*0.45;

%%Variables that are dependent on other variables (dependent)
q = 1/2*rho*v_stall^2; %This is the dynamic pressure
G = tan(deg2rad(climb_angle)); %Gradient of ascent = rise of flight/run of flight
mass_avionics = mass_pixhawk + mass_servos; % Units in kg

