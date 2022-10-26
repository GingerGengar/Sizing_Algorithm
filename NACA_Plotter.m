%% AAE 251 HW4 MATLAB
clc;clear;close all
% User Inputs:
%NACA = input("Enter NACA Designation: ")

NACA = 6412;  % NACA Airfoil Designation

% Preliminary calculations:
chord = 1; % Chord Length for percent referencing.
maxCamberF = NACA / 1000; % Max camber in float points
maxCamber = round(maxCamberF,0) / 100; % Maximum camber as percent of chord.
maxCamDisF = NACA / 100; % dividing NACA by 100 to get camber distance
maxCamDisFR = round(maxCamDisF,-1); % Rounding previous variable
maxCamDisFRR = maxCamDisF - maxCamDisFR; % Getting last three NACA digits with the first being in ones place.
maxCamDis = round(maxCamDisFRR,0) / 10; % Number of chords maximum camber is located from leading edge.
thickness = mod(NACA, 100) / 100; % Maximum thickness of airfoil as percent of chord.

b = linspace(0, pi, 500); % incrementing angles from 0 to ? to input into airfoil X values.
c = 1; % Counter to increment angles "b".
x = [0]; % Array of x values to plot
while b(c) < pi % populating preliminary X value array for later calculations.
    c = c + 1; % incrementing C to cycle through b (angles)
    x(c) = (1 - cos(b(c))) / 2 * chord; % Preliminary x values for further calculations in plot of airfoil.
end
yt = [0]; % Array of y values to plot.
c = 1; % counter to increment y values;
a0 = 0.2969; % Constant used in plotting airfoil.
a1 = -0.126; % Constant used in plotting airfoil.
a2 = -0.3516; % Constant used in plotting airfoil.
a3 = 0.2843; % Constant used in plotting airfoil.
a4 = -0.1015; % Constant used in plotting airfoil.
while x(c) < chord % populating preliminary Y value array for camber calculation.
    c = c + 1; % incrementing counter.
    yt(c) = (5 * thickness * chord) * ((a0 * ((x(c)/chord) .^ 0.5)) + (a1 * (x(c)/chord)) + (a2 * ((x(c)/chord) .^ 2)) + (a3 * (x(c)/chord) .^ 3) + (a4 * (x(c)/chord) .^4)); % Preliminary y values for airfoil plot.
end
c = 0; % counter
yc = [0]; % Blank array for camber.
dydx = [0]; % Blank array for gradient.
xu = [0]; % Blank array for X coordinate for upper surface of airfoil.
x1 = [0]; % Blank array for X coordinate for lower surface of airfoil.
yu = [0]; % Blank array for Y coordinate for upper surface of airfoil.
y1 = [0]; % Blank array for Y coordinate for lower surface of airfoil.
theta = [0]; % Blank array for angles to be used in final airfoil plot.
for c = 1:1:500 % Populating camber and gradient arrays to be used in final airfoil plot.
    if x(c) <= maxCamDis * chord % conditions for front half of airfoil.
        yc(c) = (maxCamber / (maxCamDis ^ 2)) * ((2 * maxCamDis * (x(c) / chord)) - (x(c) / chord) .^ 2); % Front half camber.
        dydx(c) = ((2 * maxCamber) / maxCamDis ^ 2) * (maxCamDis - (x(c)/chord)); % Front half gradient.
    end
    if  (x(c) >= (maxCamDis * chord)) && (x(c) <= chord) % conditions for back half of airfoil.
        yc(c) = (maxCamber / (1 - maxCamDis)^2) * (1 - (2 * maxCamDis) + (2 * maxCamDis * (x(c) / chord)) - (x(c) / chord).^2); % Back half camber.
        dydx(c) = ((2 * maxCamber) / ((1 - maxCamDis)^2)) * (maxCamDis - (x(c)/chord)); % back half gradient.
    end
    theta(c) = atan(dydx(c)); % Angle for calculating upper and lower surfaces.
    xu(c) = x(c) - (yt(c) * sin(theta(c))); % Upper wing surface X values.
    x1(c) = x(c) + (yt(c) * sin(theta(c))); % Lower wing surface X values.
    yu(c) = yc(c) + (yt(c) * cos(theta(c))); % Upper wing surface Y values.
    y1(c) = yc(c) - (yt(c) * cos(theta(c))); % Lower wing surface Y values.
end

plot(xu*1.16666*12, yu*1.16666*12, 'b-') % Upper airfoil surface
hold on
grid on
plot(x1*1.16666*12, y1*1.16666*12, 'b-') % Lower airfoil surface
% plot(x, yc, 'r-') % Camber line.
% plot([0, chord], [0,0], 'k') % Chord line
axis equal
titleString = "NACA "+num2str(NACA)+" Airfoil Profile";
title(titleString) % plot title.
xlabel("Chord (X position of airfoil)") % X axis title.
ylabel("Thickness (Y position of airfoil)") % Y axis title.
%legend("Upper Surface", "Lower Surface", "Camber Line", "Chord line", "Location", "Best")

%% Create Coordinates of Standard Wing
xs = [x1'; flipud(xu')];
ys = [y1';flipud(yu')];
OutputForDat = [xs,ys];
%csvwrite("AIRFOILPLOTTED.csv",OutputForDat)

%% WING CALCULATIONS
SMALL_WING_SPAN = 36; %Inches
SMALL_WING_CHORD = 5.04; % Inches
SMALL_WING_AREA = trapz(xu*SMALL_WING_CHORD,yu*SMALL_WING_CHORD)...
    - trapz(x1*SMALL_WING_CHORD,y1*SMALL_WING_CHORD); % Area of the wing in inch^2

SMALL_WING_VOLUME = SMALL_WING_AREA * SMALL_WING_SPAN * 1.63871e-5; % Volume in m^3
SMALL_WING_MASS = 27/1000; % IN KG

FOAMDENSITY1 = SMALL_WING_MASS/SMALL_WING_VOLUME;

BLOCK_VOLUME = 2*31*15.75* 1.63871e-5;
BLOCK_MASS = 399/1000;

FOAMDENSITY2 = BLOCK_MASS/BLOCK_VOLUME;

averageDensity = (FOAMDENSITY2 + FOAMDENSITY1)/2;


%% Compute Thickness
% LOWER = [x1'*1.16666*12, y1'*1.16666*12]; %% For solidworks part it must be zyx
% UPPER = flip([xu'*1.16666*12, yu'*1.16666*12]);
% 
% ALL = [LOWER;UPPER];
% 
% MAXTHICK = max(yu*1.16666*12) - min(y1*1.16666*12)

% Source: Lednicer, D. (2010). The Incomplete Guide to Airfoil Usage. Retrieved from https://m-selig.ae.illinois.edu/ads/aircraft.html.
% Source: NACA 4 digit airfoil generator. (2019). Retrieved from http://airfoiltools.com/airfoil/naca4digit
% Source: NACA Airfoil. (2019). Retrieved from https://en.wikipedia.org/wiki/NACA_airfoil.

