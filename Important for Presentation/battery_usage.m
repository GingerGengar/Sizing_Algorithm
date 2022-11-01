clear

prec = 1000;

time = linspace(0,30,prec); % minutes
battery_capacity_max = 6600; % mAh
battery_capacity_max = battery_capacity_max*60/1000; %Amp-min
battery_capacity_hist = zeros(prec,1);

eff = 0.8;

current_list = [45,35,5,15,5]; % Current (Amps) per flight profile
profile_time = [2,2,10,2,3]; % Minutes per profile
flight_checkpoint = cumsum(profile_time);

current_battery = battery_capacity_max;
battery_capacity_hist(1) = current_battery;
for i = 2:length(time)
    if time(i) < profile_time(1)
        current_battery = current_battery - current_list(1)*(time(i)-time(i-1));

    elseif profile_time(1) <= time(i) && time(i) < sum(profile_time(1:2))
        current_battery = current_battery - current_list(2)*(time(i)-time(i-1));

    elseif sum(profile_time(1:2)) <= time(i) && time(i) < sum(profile_time(1:3))
        current_battery = current_battery - current_list(3)*(time(i)-time(i-1));

    elseif sum(profile_time(1:3)) <= time(i) && time(i) < sum(profile_time(1:4))
        current_battery = current_battery - current_list(4)*(time(i)-time(i-1));

    elseif sum(profile_time(1:4)) <= time(i) && time(i) < sum(profile_time(1:5))
        current_battery = current_battery - current_list(5)*(time(i)-time(i-1));

    end

    battery_capacity_hist(i) = current_battery;
end

battery_capacity_hist = battery_capacity_hist*0.8;

figure(1)
plot(time,battery_capacity_hist/battery_capacity_max)
xlabel('Time (min)')
ylabel('Battery Percentage (%)')
ylim([0,1])
yline(0.2,'r-','Max Discharge Threshold (20%)')
title('Battery Usage During Mission')
yline(0.8,'r-','20% Loss Due to Cold Weather')
%subtitle('20% Loss Due to Cold Weather')
grid on
for i = 1:length(profile_time)
    xline(flight_checkpoint(i),'k--')
end