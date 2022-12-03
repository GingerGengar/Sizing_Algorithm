clear

original = readmatrix('WING_COORDS.csv');

len = length(original(:,1));

theta_array = linspace(-10,10,1000); % degrees

rotated_final = zeros(len,2);
min_thickness = 100; % High Thickness Guess 
for j = 1:length(theta_array)
    theta = theta_array(j);
    rotated = zeros(len,2);

    for i = 1:len
        rot_mat = [cosd(theta),sind(theta);
                   -sind(theta),cosd(theta)];
    
        rotated(i,:) = (rot_mat*(original(i,:)).').';
    end

    % Minimum coords to find thickness
    shift = min(rotated(:,2));
    rotated(:,2) = rotated(:,2)+abs(shift); 
    [thickness,ind] = max(rotated(:,2)); % Max Thickness of current rotation

    if thickness < min_thickness
        theta_rotation = theta;
        min_thickness = thickness;
        rotated_final = rotated;
        ind_find = ind;
    end
end

% Modifying File for Manufacter
rotated_final(:,2) = rotated_final(:,2) - rotated_final(1,2); % Set initial point to 0 
upper_clear = max(rotated_final(:,2));
lower_clear = min(rotated_final(:,2));

% Move airfoil to 0
original(:,2) = original(:,2)-min(original(:,2));
rotated_final(:,2) = rotated_final(:,2)-min(rotated_final(:,2));

[maxThick_original, original_ind] = max(original(:,2));
[maxThick_rot, rot_ind] = max(rotated_final(:,2));

clearance_original = 2-maxThick_original;
clearance_rotated = 2-maxThick_rot;

figure(1)
plot(original(:,1),original(:,2),'k--')
hold on
plot(rotated_final(:,1),rotated_final(:,2),'k-')
hold on 
plot(rotated_final(rot_ind,1),rotated_final(rot_ind,2),'r*')
hold on 
plot(original(original_ind,1),original(original_ind,2),'r*')
hold on
%text(rotated_final(rot_ind,1),rotated_final(rot_ind,2)-0.5,"Clearance: " + num2str(2-rotated_final(rot_ind,2))+ "in")
%text(rotated_final(ind_find,1),rotated_final(ind_find,2)+0.5,"Max Thickness: " + num2str(min_thickness)+ "in, \theta: " + num2str(theta_rotation)+"^{\circ}")
grid on
axis equal
title("Optimal Orientation for Foam Cut")
xlabel("Chord Length (inches)")
ylabel("Height (inches)")
hold on
yline(2,'r--','Max Thickness of Foam')
hold on
yline(0,'r--')
legend("Original Orientation","Rotated Airfoil","Location of Min Clearance")
%writematrix(rotated_final/max(rotated_final(:,1)),'Rotated_Airfoil.csv') %nondimensionalization by chord 