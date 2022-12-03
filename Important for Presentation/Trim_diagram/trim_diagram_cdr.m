trim_data = cell(1,1);


trim_data{1} = readmatrix('cma_trim_4_5.csv');
trim_list = ["-4^{\circ}"];
picked_trim = 1;

figure(1)
aoa = trim_data{1}(:,1);
cm = trim_data{1}(:,2);
plot(aoa,cm)
hold on
[trim_aoa,ind]=min(abs(cm));
plot(aoa(ind),cm(ind),'r*') 
text(aoa(ind)+0.25,cm(ind)+0.02,"\alpha_{trim} = -4.5^{\circ}")
hold on 
plot(aoa,cm-0.5,'--')
text(aoa(ind)+0.25,cm(ind)-0.5+0.02,"\alpha_{trim} = -3^{\circ}")

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