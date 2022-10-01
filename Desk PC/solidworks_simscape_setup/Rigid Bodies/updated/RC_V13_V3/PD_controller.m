function t = PD_controller(cmd,q,w)
    q_new = -cmd.q;
    w_new = -cmd.w;
    Kp_new = cmd.Kp;
    Kd_new = cmd.Kd;
    tff_new = -cmd.tff;
    t = Kp_new*(q_new - q) + Kd_new*(w_new - w) + tff_new;
end
%function t = PD(cmd,q,w)
%t = cmd.Kp*(cmd.q - q) + cmd.Kd*(cmd.w - w) + cmd.tff;
