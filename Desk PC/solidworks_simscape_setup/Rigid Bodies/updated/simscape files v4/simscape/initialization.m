copy_leg = true;
th_boom = 1.4; % deg
motor_angle = 2.2;% 0.5

% radians
Hip.M1.w0 = 0;
Hip.M2.w0 = 0;
Hip.M3.w0 = 0;
Hip.M4.w0 = 0;
Hip.M1.q0 = -motor_angle;
Hip.M4.q0 = motor_angle;
Hip.M2.q0 = motor_angle;
Hip.M3.q0 = -motor_angle;


% Impedence controller
r_des = 0.4;
phi_des = 0.0;
dr_des = 0.0;
dphi_des = 0.0;
Kpr_des = 700;
Kdr_des = 700;
Kpphi_des = 50;
Kdphi_des = 5;

% Raibert controller
r_d_23 = 0.38;
phi_d_23 = 0; %0.785398;
dr_d_23 = 0.0;
dphi_d_23 = 0.0;
Fpush_d_23 = 300;
Kp_r_d_23 = 500;
Kd_r_d_23 = Kp_r_d_23*0.1;
Kp_phi_d_23 = 200;
Kd_phi_d_23 = 10;
rthrust_d_23 = 0.3;
GAIN_dx_d_23 = 0.05;

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


