% AAE 451 Team 7
% Written by Cooper LeComp on 2022 09 07

clear;

% UNKNOWNS
prec = 100;
mf_empty = linspace(0.45,0.7,prec);
E_spec = linspace(80,150,prec) * 3600;        % watt hr/kg->watt sec/kg

m_prop = 0.35;      % kg
m_other = 0.2;      % kg
L_D = 5;                    % L/D ratio

% KNOWN: Part masses
m_payload_array = [0.5,1,1.5]*0.453592;    % kg
m_pixhawk = 0.037;  % kg
m_servos = 0.03 * 5; % kg
m_avionics = m_pixhawk + m_servos;   % kg

% USER SET: Aircraft configuration
cruise_speed_desired = 15;  % m/s
endurance_min = 20;         % minutes
g = 9.81;                   % m/s^2
f_usable = 0.8;             % usable battery %
eta_total = 0.9^5;          % efficiency %

% Base calculations
endurance_sec = endurance_min * 60;
range_m = cruise_speed_desired * endurance_sec;

% Initialize Variables
takeoffWeight = zeros(prec,prec,length(m_payload_array)); % Takeoff Weight
emptyWeight = zeros(prec,prec,length(m_payload_array)); % Empty Weight

for payloadNum = 1:length(m_payload_array)
    for i = 1:length(mf_empty)
        for j = 1:length(E_spec)
            m_payload = m_payload_array(payloadNum);
        
            % Determine battery mass fraction
            mf_batt = (range_m * g) / (E_spec(j) * eta_total * f_usable * L_D);
            
            % Calculate takeoff weight
            m_to = (m_payload + m_avionics + m_prop + m_other) / ...
                (1 - (mf_empty(i) + mf_batt));
            
            % Verify
            m_batt = (m_to - m_payload) * mf_batt;
            m_empty = m_to - m_payload - m_batt;
            m_struct = m_empty - m_avionics - m_prop - m_other;
            
            % Verify our math is sane for total mass
            assert(abs(m_batt + m_empty + m_payload - m_to) < 0.001,"%d, %d", ...
                m_batt + m_empty + m_payload, m_to); 

            takeoffWeight(i,j,payloadNum) = m_to;
            emptyWeight(i,j,payloadNum) = m_to*mf_empty(i);
        end
    end
end

figure(1)
color = ["red","blue","green"]; 
[X,Y] = meshgrid(mf_empty,E_spec/3600); % Meshgrid is weird, need to transpose XY when plotting
for i = 1:1:length(m_payload_array)
    surf(X.',Y.',takeoffWeight(:,:,i),'FaceAlpha',0.5,'EdgeColor','none','FaceColor',color(i))
    hold on
end
xlabel('Empty Mass Fraction')
ylabel('Battery Energy Density (Watt hr/kg)')
zlabel('Takeoff Weight (kg)')
hleg = legend('0.5 lbs','1 lbs','1.5 lbs');
htitle = get(hleg,'Title');
set(htitle,'String','Payload Weight')