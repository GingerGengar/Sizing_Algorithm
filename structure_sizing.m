clear

g = 9.81; % m/s^2

%% Battery Mass
%m_prop = ;
thrust = 10;
m_battery = 10;

%% Payload Mass
m_payload_array = [0.5,1,1.5]*0.453592;    % kg
m_payload = m_payload_array(1);

%% Avionics Mass
m_pixhawk = 0.037;  % kg
m_servos = 0.03 * 5; % kg
m_avionics = m_pixhawk + m_servos;   % kg

%% Wing Mass
T_W = 0.8; % Thrust to Weight Ratio
W_A = 4; % Wing Loading (Weight / Wing Area)

m_total = (thrust*(T_W)^(-1))/g;
wingArea = m_total*g*(W_A)^(-1); 

span = 2*0.762; % 2.5 ft 
wingArea = span^2/AR;

thickness = 0.01 * span;


rho_material = 24.82862; % Density of Wing Material (kg/m^3)


wingVolume = 10; % Volume of Wing
m_wing = rho_material * wingVolume;

%% Calculate Usuable Structure Mass (larger is better)
m_structure = m_total - m_avionics - m_battery - m_payload - m_wing;