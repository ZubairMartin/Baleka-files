function [B,polarPosition,polarVelocity,activateTrajectories]  = Controller(startButton,theta_ML,theta_MR,dtheta_ML,dtheta_MR)

    r_IC = 0.32;
    phi_IC = 0.0;
    dr_IC = 0.0;
    dphi_IC = 0.0;
    Kp_r_IC = 100;
    Kd_r_IC = 10;
    Kp_phi_IC = 10;
    Kd_phi_IC = 1;


    [JT11,JT12,JT21,JT22] = Jacobian_Transpose(theta_ML,theta_MR);
    [r,phi,dr,dphi,left_knee,right_knee] = ConvertToPolar(theta_ML,theta_MR,dtheta_ML,dtheta_MR);
    polarPosition = [r;phi];
    polarVelocity = [dr;dphi];
    JT = [JT11,JT12;JT21,JT22];

    activateTrajectories = 0;

    if startButton == 0
        % 0 = Rest
        w = [0;0];
        B = JT*w;

    elseif startButton == 1
        % 1 = Impedence control
        E = [r_IC - r; phi_IC - phi];
        dE = [dr_IC - dr; dphi_IC - dphi];
        wr = Kp_r_IC*E(1) + Kd_r_IC*dE(1);
        wphi = Kp_phi_IC*E(2) + Kd_phi_IC*dE(2);
        w = [wr;wphi];
        B = JT*w;

    else

        activateTrajectories = 1;
        w = [0;0];
        B = JT*w;

    end

end