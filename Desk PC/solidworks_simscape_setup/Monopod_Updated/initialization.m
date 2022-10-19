%% Setup 
version = 'monopod';
% Initialization
%% biped values
match_leg_gains = -1; % (-1) M14 mirrors M23 (1) M14 is the opposite of M23
copy_leg = true; % set the gains/constants equal to one another of both legs
alternate_legs = 1.0;

%% adjust before run
% Simscape
th_boom = 1.4; % deg
zero_origin = -2.23; % [rad] from downward vertical axis
gravity_activated = 1;
contact_stiffness = 3.6e4;
update_controller_Kd_r = 0; % if = 0 then deactivate controller

%%
m_eff = 5; % monopod measured on scale
% Test: Ts = pi/(sqrt(4*m_eff*Kp-Kd^2))/(2*m_eff);
dr_contact = -0.5; % velocity when contact is reached (taken from simscape estimation)
tau_limit = 100; % to turn off motors 
knee_limit = 100; % deg
offset_phi_limit = 30; % should phi hit out of bounds(deg)

%% Raibert Control
%control_type = 0; % 0 = hop, 1 = run, 2 = position control
dx_des = 0.15;
x_des = 0;

% Impedence controller
r_IC = 0.3;
phi_IC = 0.0;
dr_IC = 0.0;
dphi_IC = 0.0;
Kp_r_IC = 500;
Kd_r_IC = 50;
Kp_phi_IC = 100;
Kd_phi_IC = 10;

% Raibert controller
if update_controller_Kd_r>0
    GAIN_dx_RC_23 = 0.02;
    Fthrust_RC_23 = 50;
    Kp_r_RC_23 = 900; 
    Kp_phi_RC_23 = 20;
else
    GAIN_dx_RC_23 = 0.03;
    Fthrust_RC_23 = 200;
    Kp_r_RC_23 = 600;
    Kp_phi_RC_23 = 100;
end

r_RC_23 = 0.35;
phi_RC_23 = -0.004; %-0.004; %-0.005;
dr_RC_23 = 0.0;
dphi_RC_23 = 0.0;
Kd_r_RC_23 = Kp_r_RC_23*0.1;
Kd_phi_RC_23 = Kp_phi_RC_23*0.1;
r_thrust_RC_23 = 0.33;

% % Raibert controller - low hop
% r_RC_23 = 0.32;
% phi_RC_23 = -0.003; %-0.004; %-0.005; %0.785398;
% dr_RC_23 = 0.0;
% dphi_RC_23 = 0.0;
% Fthrust_RC_23 = 100;
% Kp_r_RC_23 = 600;
% Kd_r_RC_23 = Kp_r_RC_23*0.1;
% Kp_phi_RC_23 = 100;
% Kd_phi_RC_23 = Kp_phi_RC_23*0.1;
% r_thrust_RC_23 = 0.27;
% GAIN_dx_RC_23 = 0.07;

% body rotation (radians)
Hip.M1.w0 = 0;
Hip.M2.w0 = 0;
Hip.M3.w0 = 0;
Hip.M4.w0 = 0;
% CW is positive (angles in rad)
motor_angle_M1 = 0.0;
motor_angle_M4 = 0.0;
motor_angle_M2 = 0.0;
motor_angle_M3 = 0.0;
Hip.M1.q0 = -motor_angle_M1; % right - front
Hip.M4.q0 = -motor_angle_M4; % left - front
Hip.M2.q0 = -motor_angle_M2; % right - front
Hip.M3.q0 = -motor_angle_M3; % left - front


if copy_leg == true
    r_RC_14 = r_RC_23;
    phi_RC_14 = phi_RC_23;
    dr_RC_14 = dr_RC_23;
    dphi_RC_14 = dphi_RC_23;
    Fthrust_RC_14 = Fthrust_RC_23;
    Kp_r_RC_14 = Kp_r_RC_23;
    Kd_r_RC_14 = Kd_r_RC_23;
    Kp_phi_RC_14 = Kp_phi_RC_23;
    Kd_phi_RC_14 = Kd_phi_RC_23;
    r_thrust_RC_14 = r_thrust_RC_23;
    GAIN_dx_RC_14 = GAIN_dx_RC_23;
else
    r_RC_14 = 0.32;
    phi_RC_14 = -0.003; %-0.004; %-0.005; %0.785398;
    dr_RC_14 = 0.0;
    dphi_RC_14 = 0.0;
    Fthrust_RC_14 = 100;
    Kp_r_RC_14 = 600;
    Kd_r_RC_14 = Kp_r_RC_14*0.1;
    Kp_phi_RC_14 = 100;
    Kd_phi_RC_14 = Kp_phi_RC_14*0.1;
    r_thrust_RC_14 = 0.27;
    GAIN_dx_RC_14 = 0.07;
end


