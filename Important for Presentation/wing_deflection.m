% Simple algorithm to calculate the deflection, bending moment, shear force in a
% cantilever beam.
% Using the load distribution from  XFLR5 for Telemaser
% load = loading distribution
    
clear 
% read normalized wing loading 

%% Lift Load
filename = 'Wing_Graph_0_LIFT DISTRIBUTION.csv';


output_mat = readmatrix(filename);
output_mat= rmmissing(output_mat);

b = 1.2678*2; % span (m)
x = output_mat(:,1)/1.2678; % normalized by half span
q = 0.5*1.225*14^2; % dynamic pressure
ref_area = 0.914; % m^2
cl_dist = output_mat(:,2);

N = 3; % Load Facter
mass_length = 8.8964378317/b; % N/m


load_XFRL = N*(cl_dist*q*ref_area-mass_length*b);

E = 3E4; % Pa
I = 9.98955421E-4; % m^2 (I = 2400 in^4)
ei = E*I;
l=1;
dl=.01;
x_uniform=0:dl:l;
load_uniform=interp1(x,load_XFRL,x_uniform);

[deflection,moment,shear]=beam_deflection(load_uniform,ei,l,dl);


[deflection,moment,shear] = beam_deflection(load_uniform,ei,l,dl);
total_load = sum(load_uniform)*dl;

%% Elliptic load distribution
for i=1
    moment_approx = N*2*3.40194*9.81/(3*pi)*2.54*(1-(x_uniform).^2).^(3/2);
    max_lift = N*1.5*q*ref_area;
    L0 = 4*max_lift/(pi*2.54); %http://web.mit.edu/16.unified/www/SPRING/fluids/Spring2008/LectureNotes/f07.pdf
    load_approx = L0*sqrt(1-(x_uniform).^2);
    
    u_2=moment_approx/ei;
    for i=2:length(moment_approx)
        u_2(i)=u_2(i-1);%-u_3(i-1)*dl;
    end
    u_1=0;
    for i=2:length(moment_approx)
        u_1(i)=u_1(i-1)+u_2(i-1)*dl;
    end
    u=0;
    for i=2:length(moment_approx)
        u(i)=u(i-1)+u_1(i-1)*dl;
    end
    deflection_approx=u; % meters
end

figure(1)
subplot(2,1,1)
plot(x_uniform,moment*0.737562,x_uniform,moment_approx*0.737562)
legend('XFLR Results','Elliptic Distribution')
xlabel('% Half Span')
ylabel('Bending Moment (lbs-ft)')
grid
hold off

subplot(2,1,2)
plot(x_uniform,deflection*39.3701,x_uniform,deflection_approx*39.3701,'r')
xlabel('% Half Span')
ylabel('Deflection (inches)')
grid
%legend('XFLR Results','Elliptic Distribution')
%title('Deflection along Wing')

figure
plot(x,load_XFRL*0.2248090795)
hold on
plot(-x_uniform,load_approx*0.2248090795,'r-',x_uniform,load_approx*0.2248090795,'r-')
xlabel('% Half Span')
ylabel('Load (lbs)')
grid
legend('XFLR Results','Elliptic Distribution')
xlim([-1,1])