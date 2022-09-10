%Variables which are known/guessed (independent)
rho = 1.225; %This is the density of the air
v_stall = ; %This is the estimation for stall speed
c_Lmax = 1.2; %the maximum lift coefficient we can get
climb_angle = ; %This is from the RFP


%Variables that are dependent on other variables (dependent)
q = 1/2*rho*v_stall^2; %This is the dynamic pressure
c_D0 = ; %This is the drag coefficient near stall speed
A_r = ; %Aspect ratio of the main wing
e = 0.9; %efficiency of the wing due to deviating from elliptic lift distribution
G = tan(climb_angle); %Gradient of ascent = rise of flight/run of flight


