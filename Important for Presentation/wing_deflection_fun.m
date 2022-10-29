function [x_uniform,moment,deflection,load_XFRL,load_approx,deflection_approx,moment_approx] = wing_deflection_fun(N,V)
    %% Lift Load
    filename = 'Wing_Graph_0_LIFT DISTRIBUTION.csv';
   
    output_mat = readmatrix(filename);
    output_mat= rmmissing(output_mat);
    
    b = 1.2678*2; % span (m)
    x = output_mat(:,1)/1.2678; % normalized by half span
    q = 0.5*1.225*V^2; % dynamic pressure
    ref_area = 0.914; % m^2
    cl_dist = output_mat(:,2);
    
    mass_length = 8.8964378317/b; % N/m
    
    load_XFRL = N*(cl_dist*q*ref_area-mass_length*b);
    
    E = 4.5260e+08; % Pa
    I = 9.98955421E-4; % m^2 (I = 2400 in^4)
    ei = E*I;
    l=1;
    dl=.01;
    x_uniform=0:dl:l;
    load_uniform=interp1(x,load_XFRL,x_uniform);
    
    [deflection,moment,shear] = beam_deflection(load_uniform,ei,l,dl);
    moment = moment *0.737562; %lbs-ft
    deflection = deflection*39.3701; %inches
    total_load = sum(load_uniform)*dl;

    %% Elliptic load distribution
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

    moment_approx=moment_approx*0.737562;
    deflection_approx=deflection_approx*39.3701; % inches
end