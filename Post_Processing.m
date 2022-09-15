%%Give Definition of Global variable
Global_Variables;

fprintf("\n\n##################################################################\n");
fprintf("Payload Mass: (%f lb)\n", payload_mass/.45);
fprintf("##################################################################\n");
fprintf("Wing Loading for Aircraft: %f (N/m^2)\n", L_wi);
fprintf("Thrust to Weight Ratio: %f (dimless)\n", T_W);
fprintf("##################################################################\n");
fprintf("Battery Mass: %f kg\n", Batt_Mass);
fprintf("##################################################################\n");
fprintf("Aircraft Wing Area: %f m^2\n", Main_Wing_Area);
fprintf("Main Aircraft Wing Mass: %f kg\n", mass_main_wing);
fprintf("##################################################################\n");
fprintf("The Total Mass of the Aircraft: %f kg (%f lb)\n", Total_Aircraft_Mass,Total_Aircraft_Mass*2.2);
fprintf("The Spare Mass of the Aircraft: %f kg (%f lb)\n", Spare_Aircraft_Mass,Spare_Aircraft_Mass*2.2);
fprintf("##################################################################\n");
fprintf('Aircraft Wing Span: %f m\n',(A_r * Main_Wing_Area)^.5)
fprintf('Aircraft Wing Chord: %f m\n',Main_Wing_Area/(A_r * Main_Wing_Area)^.5)
fprintf("##################################################################\n");
fprintf("# End of Analysis\n")
fprintf("##################################################################\n");
