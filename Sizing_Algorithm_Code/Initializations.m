%%Give Definition of Global variable
Global_Variables;

%%Variables which are known/guessed (independent)
%PLEASE READ THIS! THIS IS THE IMPERIAL UNITS WE EXPECT!!!
%Force = (Pound Force)
%Length = (feet); 
%Time = (seconds); 
%Mass = (Pound Mass); 
%Power = (feet*pounds/seconds)
%Pressure = (Pound Force/(feet^2))
%Angle = (degrees)

%Variables Needed to Compute the Wing Loading and Thrust to Weight Ratio
g = 32.1741; %This is the local gravitational accel ()
rho = 0.0765; %This is the density of the air ()
v_stall = 15; %This is the estimation for stall speed ()
c_Lmax = 1.5; %the maximum lift coefficient we can get (dimless)
climb_angle = 25; %This is from the RFP (degrees)
c_D0 = 0.03; %This is the drag coefficient near stall speed (dimless)
e = 0.83; %efficiency of the wing due to deviating from elliptic lift distribution (dimless)

span = 8.33333; % ft
chord = 1.16667; % ft
wing_area = span*chord; % ft^2
A_R = span/chord;

%Variables that are needed to compute the total weight of the aircraft
Engine_Thrust = 6; %This is force produced by engine

%Variables that are needed to compute the mass of the batteries
endurance = 720; % seconds of flight. This corresponds to 12 minutes of flight
Motor_Power = 786.9837*.75; %This is the power of the motor, has to be in cruise conditions
CellNum = 4;
Batt_Specific_Energy = CellNum * 3.7*3300e-3*3600/.0317; %This is Energy/Mass 

%Variables that are needed to compute the Lift Devices
Main_Wing_Thickness = 1; %Thickness of the main Wing
Ave_Density_Main_Wing = 1; % Density of Wing Material

%%Directly Known Masses of the Aircraft

%Mass of the Motor and Propeller of Aircraft
Motor_Prop_Mass = 0.2; %This is in kg and taken from manufacturer

%Mass of the Prescribed Avionics
mass_pixhawk = 0.081571037;  %Mass of the pixhawk flight controller
mass_servos = 0.33069339; %Total mass of the servos

%Mass of the Payload
payload_mass = 1.5;

%%Variables that are dependent on other variables (dependent)
q = 1/2*rho*v_stall^2; %This is the dynamic pressure
G = tand(climb_angle); %Gradient of ascent = rise of flight/run of flight
mass_avionics = mass_pixhawk + mass_servos; % Units in kg
