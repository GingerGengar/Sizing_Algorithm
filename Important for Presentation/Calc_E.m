L = 23.5; % inches
L = L * 0.0254; % meters

chord = 5.75; % in
chord = chord * 0.0254; % meters

thickness = 0.75; % in
thickness = thickness * 0.0254; % meters

I = pi/4*(thickness/2)^3*(chord/2); % Ellipse approx

P = 0.914*9.8; % Force applied

location = [0,4,8,12,16,20,23.5].'*0.0254;
def = [0,0.17,1,1.3,1.6,2.3,2.5].'/100;


ft = fittype('a*x^2*(3*0.5969-x)',...
'dependent',{'y'},'independent',{'x'},...
    'coefficients',{'a'});

f = fit(location,def,ft,'StartPoint',3E4);
a = 0.06655;
E = P/(6*I*a);

x = linspace(0,L);
def_fit = P*x.^2/(6*E*I).*(3*L-x);

figure(1)
plot(location,def,'o')
hold on
plot(x,def_fit)
axis equal
xlabel('Distance from Fixed Point (m)')
ylabel('Deflection (m)')
grid on
legend('Data Points','Fitted Curve')
title('Deflection Test - Foam + Fiberglass Wing')