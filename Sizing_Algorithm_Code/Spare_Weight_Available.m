%%Give Definition of Global variable
Global_Variables;

%Initialize the Spare Weight to the Total Aircraft Weight
Spare_Aircraft_Weight = Total_Aircraft_Weight;

%Subtract the Propulsion System
Spare_Aircraft_Weight = Spare_Aircraft_Weight - Batt_Mass*g - Motor_Prop_Mass*g;

%Subtract the Lift Devices
Spare_Aircraft_Weight = Spare_Aircraft_Weight - weight_main_wing;

%Subtract the Control System
Spare_Aircraft_Weight = Spare_Aircraft_Weight - mass_avionics*g;

%Subtract the Intended Payload
Spare_Aircraft_Weight = Spare_Aircraft_Weight - payload_mass*g;

%Convert the Spare Weight into spare Mass
Spare_Aircraft_Mass = Spare_Aircraft_Weight/g;
