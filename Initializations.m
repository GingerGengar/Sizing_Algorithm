%%Give Definition of Global variable
Global_Variables;

%%Variables which are known/guessed (independent)

%Variables Needed to Compute the Wing Loading and Thrust to Weight Ratio
rho = 1.225; %This is the density of the air
v_stall = 8; %This is the estimation for stall speed
c_Lmax = 1.2; %the maximum lift coefficient we can get
climb_angle = 25; %This is from the RFP
c_D0 = 0.03; %This is the drag coefficient near stall speed
A_r = 9; %Aspect ratio of the main wing, typical values
e = 0.8; %efficiency of the wing due to deviating from elliptic lift distribution

%Variables that are needed to compute the weight of the aircraft


%Variables that are needed to compute the weight of the powerplant system
endurance = 900; %seconds of flight. This corresponds to 15 minutes of flight
Motor_Power = ; %This is the power of the motor (W)
Batt_Specific_Energy = ; %This is Energy/Mass, so its unit has to be (J/kg)

%%Variables that are dependent on other variables (dependent)
q = 1/2*rho*v_stall^2; %This is the dynamic pressure
G = tan(deg2rad(climb_angle)); %Gradient of ascent = rise of flight/run of flight

