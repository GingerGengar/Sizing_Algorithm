L = 18; % inches
L = L * 0.0254; % meters

chord = 14; % in
chord = chord * 0.0254; % meters

thickness = 2; % in
thickness = thickness * 0.0254; % meters

I = pi/4*(thickness/2)^3*(chord/2); % Ellipse approx

P = 1.19*9.8; % Force applied


def_neutral = [0,4.3,4.2,4.1,3.9,4].'/100;
def_measured = [0,4.7,4.9,5.2,5.4,5.5].'/100;

location = [0,4,8,12,16,18].'*0.0254;
def = def_measured-def_neutral;


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
title('Deflection Test of Actual Wing')