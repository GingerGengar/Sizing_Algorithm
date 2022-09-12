%%Give Definition of Global variable
Global_Variables;

%%Load All of the Inputs for this simulation
Initializations; %Initialize the global variables

%%Compute the 2 important parameters based on RFP requirements
Wing_Loading; %Compute the wing loadings
Thrust_Weight_Ratio; %Compute the Thrust to Weight Ratio

%%Compute the Power-plant weight
Aircraft_Total_Mass; %Compute the total aircraft mass based on thrust to weight and engine choice
Get_Batt_Mass; %Compute the battery mass needed for correct flight endurance

%%Show All Results
Post_Processing; %Print out All of the things we want to know about





