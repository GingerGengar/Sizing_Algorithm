%%Give Definition of Global variable
Global_Variables;

Main_Wing_Volume = Main_Wing_Area * Main_Wing_Thickness; % Units in m^3
mass_main_wing = Ave_Density_Main_Wing * Main_Wing_Volume; %Units in kg
weight_main_wing = mass_main_wing*g; %Units in Newtons
