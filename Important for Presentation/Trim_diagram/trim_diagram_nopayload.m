trim_data = cell(1,1);


trim_data{1} = readmatrix('cm_trimmed_4_nopay.csv');
trim_list = ["-4^{\circ}"];
picked_trim = 1;

figure(1)
for i = 1
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
xlim([-4,7])
xlabel('\alpha (deg)')
ylabel('C_m')
title('Trim Diagram @ Cruise (25 ft/s)')
subtitle('Trim Angle Labelled with Corresponding Line')

% hleg = legend(trim_list);
% htitle = get(hleg,'Title');
% set(htitle,'String','Trim Condition')