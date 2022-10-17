y = linspace(-50,50,1000); % inches
b = 100;
lmda = 1; % Taper Ratio
S = 100*14;
C_r = 2*S/(b*(1+lmda));

C_y = C_r * (1-2*y/b*(1-lmda));

figure(1)
plot(y,C_y)
xlabel('Position from Middle (in)')
ylabel('Local Wing Chord (in)')
