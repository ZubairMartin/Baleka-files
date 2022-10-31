%% Setup 
% Initialization
match_leg_gains = -1; % (-1) M14 mirrors M23 (1) M14 is the opposite of M23
gravity_activated = 0; % 1 = on, 0 = off

% Simscape
th_boom = 10;%8; % deg

% % body rotation (radians)
% Hip.M1.w0 = -1.35; %initial velocities
% Hip.M2.w0 = -13.24;
% Hip.M3.w0 = 4.59;
% Hip.M4.w0 = -2.24;
% 
% % % V12 CW is positive (angles in rad)
% motor_angle_M1 = -0.86; %initial angles
% motor_angle_M4 = 0.86;
% motor_angle_M2 = 0.86;
% motor_angle_M3 = -0.86;

% body rotation (radians)
Hip.M1.w0 = 0; %initial velocities
Hip.M2.w0 = 0;
Hip.M3.w0 = 0;
Hip.M4.w0 = 0;

% % V12 CW is positive (angles in rad)
motor_angle_M1 = 0; %initial angles
motor_angle_M4 = 0;
motor_angle_M2 = 0;
motor_angle_M3 = 0;



Hip.M1.q0 = -motor_angle_M1; % right - front
Hip.M4.q0 = -motor_angle_M4; % left - front
Hip.M2.q0 = -motor_angle_M2; % right - front
Hip.M3.q0 = -motor_angle_M3; % left - front


zero_origin = -2.23; % [rad] from downward vertical axis
