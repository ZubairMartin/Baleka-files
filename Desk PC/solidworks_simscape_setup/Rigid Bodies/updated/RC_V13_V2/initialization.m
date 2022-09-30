version = 13;
join_legs = -1; % (-1) M14 mirrors M23 (1) M14 is the opposite of M23
copy_leg = true;
th_boom = 1.4; % deg
zero_origin = -2.23; % [rad] from downward vertical axis

% radians
Hip.M1.w0 = 0;
Hip.M2.w0 = 0;
Hip.M3.w0 = 0;
Hip.M4.w0 = 0;

if version == 11
    % v11 CCW is positive (angles in rad)
    motor_angle = 30*pi/180;

    Hip.M1.q0 = motor_angle; % left - looking down boom
    Hip.M4.q0 = -motor_angle; % right - looking down boom
    Hip.M2.q0 = -motor_angle; % right - front
    Hip.M3.q0 = motor_angle; % left - front
end

if version > 11
    % V12 CW is positive (angles in rad)
    motor_angle_M1 = 0.0;
    motor_angle_M4 = 0.0;
    motor_angle_M2 = 0.0;
    motor_angle_M3 = 0.0;
    
%     % Testing
%     motor_angle_M1 = -30*pi/180;
%     motor_angle_M4 = 30*pi/180;
%     motor_angle_M2 = 30*pi/180;
%     motor_angle_M3 = -30*pi/180;

    Hip.M1.q0 = -motor_angle_M1; % right - front
    Hip.M4.q0 = -motor_angle_M4; % left - front
    Hip.M2.q0 = -motor_angle_M2; % right - front
    Hip.M3.q0 = -motor_angle_M3; % left - front
end
%%


% Impedence controller
r_des = 0.3;
phi_des = 0.0;
dr_des = 0.0;
dphi_des = 0.0;
Kpr_des = 500;
Kdr_des = 50;
Kpphi_des = 100;
Kdphi_des = 10;

% Raibert controller
r_d_23 = 0.35;
phi_d_23 = 0.0; %0.785398;
dr_d_23 = 0.0;
dphi_d_23 = 0.0;
Fpush_d_23 = 200;
Kp_r_d_23 = 500;
Kd_r_d_23 = Kp_r_d_23*0.1;
Kp_phi_d_23 = 100;
Kd_phi_d_23 = 10;
rthrust_d_23 = 0.33;
GAIN_dx_d_23 = 0.02;

if copy_leg == true
    r_d_14 = r_d_23;
    phi_d_14 = phi_d_23;
    dr_d_14 = dr_d_23;
    dphi_d_14 = dphi_d_23;
    Fpush_d_14 = Fpush_d_23;
    Kp_r_d_14 = Kp_r_d_23;
    Kd_r_d_14 = Kp_r_d_23*0.1;
    Kp_phi_d_14 = Kp_phi_d_23;
    Kd_phi_d_14 = Kd_phi_d_23;
    rthrust_d_14 = rthrust_d_23;
    GAIN_dx_d_14 = GAIN_dx_d_23; % 0.02
else
    r_d_14 = 0.38;
    phi_d_14 = 0; %0.785398;
    dr_d_14 = 0.0;
    dphi_d_14 = 0.0;
    Fpush_d_14 = 300;
    Kp_r_d_14 = 600;
    Kd_r_d_14 = Kp_r_d_14*0.1;
    Kp_phi_d_14 = 200;
    Kd_phi_d_14 = 10;
    rthrust_d_14 = 0.3;
    GAIN_dx_d_14 = 0.05; % 0.02
end


