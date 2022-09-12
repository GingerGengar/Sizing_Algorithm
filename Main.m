%%Give Definition of Global variable
Global_Variables;

%%Basic Housekeeping Before Running Simulation
clear; clc;

%%Load All of the Inputs for this simulation
Initializations; %Initialize the global variables

%%Compute the 2 important parameters based on RFP requirements
Wing_Loading; %Compute the wing loadings
Thrust_Weight_Ratio; %Compute the Thrust to Weight Ratio

%%Compute the Power-plant weight
Aircraft_Total_Mass; %Compute the total aircraft mass based on thrust to weight and engine choice
Get_Batt_Mass; %Compute the battery mass needed for correct flight endurance

%%Compute the Weight of the lift devices
Aircraft_Wing_Area; %Compute the Area of the Main Wing Device
Main_Wing_Mass; %Compute the mass of the Main Wing

%%Compute Spare Weight Quota Available
Spare_Weight_Available; %Computes whatever mass is left for all the other components

%%Show All Results
Post_Processing; %Print out All of the things we want to know about


