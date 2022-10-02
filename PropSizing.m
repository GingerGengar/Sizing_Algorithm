l_d_min_ac = 3;
est_weight = 3.7; % kg
g = 9.81; %m/s^2

lift = est_weight * g; % N
drag = lift / l_d_min_ac; % N

disp(drag + " Newtons");