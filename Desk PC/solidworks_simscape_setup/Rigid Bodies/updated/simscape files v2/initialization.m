th_boom = 30; % deg

% radians
Hip.M1.w0 = 0;
Hip.M2.w0 = 0;
Hip.M3.w0 = 0;
Hip.M4.w0 = 0;
Hip.M1.q0 = -0.5;
Hip.M2.q0 = 0.5;
Hip.M3.q0 = -0.5;
Hip.M4.q0 = 0.5;

r_d_14 = 0.38;
phi_d_14 = 0.0;
dr_d_14 = 0.0;
dphi_d_14 = 0.0;
Fpush_d_14 = 200;
Kp_r_d_14 = 500;
Kd_r_d_14 = 50;
Kp_phi_d_14 = 100;
Kd_phi_d_14 = 10;
rthrust_d_14 = 0.35;
GAIN_dx_d_14 = 0.05; % 0.02

r_d_23 = 0.38;
phi_d_23 = 0.0;
dr_d_23 = 0.0;
dphi_d_23 = 0.0;
Fpush_d_23 = 200;
Kp_r_d_23 = 500;
Kd_r_d_23 = 50;
Kp_phi_d_23 = 100;
Kd_phi_d_23 = 10;
rthrust_d_23 = 0.35;
GAIN_dx_d_23 = 0.05;

% Phases
% States = struct('Flight',1,'Loading',2,'Compression',3,'Thrust',4,'Unloading',5);
% busInfo = Simulink.Bus.createObject(States);

