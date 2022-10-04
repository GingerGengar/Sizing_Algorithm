trim_data = cell(6,1);

trim_data{1} = readmatrix('trim_neg_3.csv');
trim_data{2} = readmatrix('trim_neg_1_5.csv');
trim_data{3} = readmatrix('trim_0.csv');
trim_data{4} = readmatrix('trim1_5.csv');
trim_data{5} = readmatrix('trim2_5.csv');
trim_data{6} = readmatrix('trim3.csv');
trim_list = ["-3^{\circ}","-1.5^{\circ}","0^{\circ}","+1.5^{\circ}","+2.5^{\circ}","+3^{\circ}"];
picked_trim = 5;

figure(1)
for i = 1:6
    aoa = trim_data{i}(:,1);
    cm = trim_data{i}(:,2);
    if i == picked_trim
        plot(aoa,cm)
        hold on
        [trim_aoa,ind]=min(abs(cm));
        plot(aoa(ind),cm(ind),'r*') 
        text(aoa(ind)+0.25,cm(ind)+0.02,"\alpha_{trim} = "+num2str(aoa(ind))+"^{\circ}")
    else
        plot(aoa,cm,'--')
    end
    hold on
    
    % Plot the Text
    mover = 8.5;
    [~,ind]=min(abs(aoa-mover));
    text(aoa(ind),cm(ind)+0.01,trim_list(i))
end
yline(0,'k')
hold on
xline(0,'k')
grid on
xlim([-2,10])
xlabel('\alpha (deg)')
ylabel('C_m')
title('C_m vs \alpha @ Cruise (12 m/s)')

% hleg = legend(trim_list);
% htitle = get(hleg,'Title');
% set(htitle,'String','Trim Condition')