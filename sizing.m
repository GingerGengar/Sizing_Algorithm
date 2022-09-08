% AAE 451 Team 7
% Written by Cooper LeComp on 2022 09 07

clc; clear vars;

% UNKNOWNS
mf_empty = 0.6;
m_prop = 0.35;      % kg
m_other = 0.2;      % kg
E_spec = 100 * 3600;        % wh/kg->ws/kg
L_D = 5;                    % L/D ratio

% KNOWN: Part masses
m_payload = 0.7;    % kg
m_pixhawk = 0.037;  % kg
m_servos = 0.03 * 5;% kg
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

% Determine battery mass fraction
mf_batt = (range_m * g) / (E_spec * eta_total * f_usable * L_D);

% Calculate takeoff weight
m_to = (m_payload + m_avionics + m_prop + m_other) / ...
    (1 - (mf_empty + mf_batt));

m_batt = (m_to - m_payload) * mf_batt;
m_empty = m_to - m_payload - m_batt;
m_struct = m_empty - m_avionics - m_prop - m_other;

% Verify our math is sane for total mass
assert(abs(m_batt + m_empty + m_payload - m_to) < 0.001,"%d, %d", ...
    m_batt + m_empty + m_payload, m_to);

