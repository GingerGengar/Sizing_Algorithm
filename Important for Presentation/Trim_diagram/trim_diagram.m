trim_data = cell(6,1);

% trim_data{1} = readmatrix('trim_neg_3.csv');
% trim_data{2} = readmatrix('trim_neg_1_5.csv');
% trim_data{3} = readmatrix('trim_0.csv');
% trim_data{4} = readmatrix('trim1_5.csv');
% trim_data{5} = readmatrix('trim2_5.csv');
% trim_data{6} = readmatrix('trim3.csv');
% trim_list = ["-3^{\circ}","-1.5^{\circ}","0^{\circ}","+1.5^{\circ}","+2.5^{\circ}","+3^{\circ}"];
% picked_trim = 6;

trim_data{1} = readmatrix('cma_trim_pos_3.csv');
trim_data{2} = readmatrix('cma_trim_pos_2.csv');
trim_data{3} = readmatrix('cma_trim_pos_1.csv');
trim_data{4} = readmatrix('cma_trim_neg_3.csv');
trim_data{5} = readmatrix('cma_trim_neg_2.csv');
trim_data{6} = readmatrix('cma_trim_neg_1.csv');
trim_data{7} = readmatrix('cma_trim_0.csv');
%trim_data{8} = readmatrix('cma_trim_neg_1_5_DESIGN.csv');
%trim_list = ["+3^{\circ}","+2^{\circ}","+1^{\circ}","-3^{\circ}","-2^{\circ}","-1^{\circ}","-1.5^{\circ}","0"];
trim_list = ["0.5^{\circ}","-1.5^{\circ}","-2.5^{\circ}","-6.5^{\circ}","-5.5^{\circ}","-4.5^{\circ}","-3.5^{\circ}"];
picked_trim = 6;

figure(1)
for i = 1:7
    aoa = trim_data{i}(:,1);
    cm = trim_data{i}(:,2)/2;
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