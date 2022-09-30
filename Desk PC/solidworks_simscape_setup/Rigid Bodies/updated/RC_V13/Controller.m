function [B,ctrl_state]  = Controller(startButton,bodyState,DesiredImpedenceValues,DesiredRaibertValues,PolarState,JacobianValues)

    x_body = bodyState.x;
    dx_body = bodyState.dx;
    y_body = bodyState.y;
    dy_body = bodyState.dy;

    r_des = DesiredImpedenceValues(1);
    phi_des = DesiredImpedenceValues(2);
    dr_des = DesiredImpedenceValues(3);
    dphi_des = DesiredImpedenceValues(4);
    Kpr_des = DesiredImpedenceValues(5);
    Kdr_des = DesiredImpedenceValues(6);
    Kpphi_des = DesiredImpedenceValues(7);
    Kdphi_des = DesiredImpedenceValues(8);

    r = PolarState.r;
    phi = PolarState.phi;
    dr = PolarState.dr;
    dphi = PolarState.dphi;

    JT11 = JacobianValues.JT11;
    JT12 = JacobianValues.JT12;
    JT21 = JacobianValues.JT21;
    JT22 = JacobianValues.JT22; 

    r_ref = DesiredRaibertValues(1);
    phi_ref = DesiredRaibertValues(2);
    dr_ref = DesiredRaibertValues(3);
    dphi_ref = DesiredRaibertValues(4);
    F_push = DesiredRaibertValues(5);

    Kp_r = DesiredRaibertValues(6);  
    Kp_phi = DesiredRaibertValues(8);  
    Kd_r = DesiredRaibertValues(7);  
    Kd_phi = DesiredRaibertValues(9); 
    r_thrust = DesiredRaibertValues(10);
    GAIN_dx= DesiredRaibertValues(11);
    
    JT = [JT11,JT12;JT21,JT22];

    y_foot = r*cos(phi); % +ve value
    
    % constants
    phi_neutral = phi_ref;
    r0 = r_ref; % 0.38 0.33
    r_min = r_thrust; % 0.30 0.25
    dt = 0.02;
    
    F_thrust = 0;
    tau = 0; % Kd_phi*(dphi_ref - dphi)

    persistent state
    persistent phi0
    persistent contact_offset
    persistent Ts
    persistent stance_timer

    if startButton == 0
        % 0 = Rest
        state = State.Thrust;
        w = [0;0];
        B = JT*w;

    elseif startButton == 1
        % 1 = Impedence control
        state = State.Thrust;
        E = [r_des - r; phi_des - phi];
        dE = [dr_des - dr; dphi_des - dphi];
        wr = Kpr_des*E(1) + Kdr_des*dE(1);
        wphi = Kpphi_des*E(2) + Kdphi_des*dE(2);
        w = [wr;wphi];
        B = [1;1]; %JT*w;

    elseif startButton == 2
        % 2 = Hop
        state = State.Thrust;
        if (r > r0)
            F_thrust = 0;
        else
            F_thrust = F_push;
        end       
        Fr = Kp_r*(r_ref - r) + Kd_r*(dr_ref - dr) + F_thrust;
        B = JT * [Fr; tau];

    else
        % 3 = Raibert Control
        if isempty(state)
            state = State.Thrust;
        end
        if isempty(phi0)
            phi0 = phi_neutral;
        end
        if isempty(contact_offset)
            contact_offset = 0;
        end
        if isempty(Ts)
            Ts = 0.23;
        end
        if isempty(stance_timer)
            stance_timer = 0;
        end 
    
        % calculate foot contact
        foot_height = y_body - y_foot; %- contact_offset; % This gets the foot height distance %- contact_offset;
        if (foot_height > 0.005)
            foot_contact = false;
        else
            foot_contact = true;
        end
        
        % update stance duration
        if foot_contact
            stance_timer = stance_timer + dt;
        end
        
       % (1 = Flight, 2 = Loading, 3 = Compression, 4 = Thrust, 5 = Unloading)
        % state transitions
        if state == State.Flight
            
            % adjust foot placement based on horizontal velocity
            dx_des = 0; %-min(max(1.0*(x_body - x_des), -0.5), 0.5);
            x_foot = 0.5*dx_body*0.18 + GAIN_dx*(dx_body - dx_des);
            phi0 = (phi_neutral + asin(x_foot / r0));
            tau = Kp_phi*(phi_ref- phi) + Kd_phi*(dphi_ref - dphi); % position foot
    
            if foot_contact
                state = State.Loading;
            end
        
        elseif state == State.Loading
            if (dr < 0)
                state = State.Compression;
            end
        
        elseif state == State.Compression
            % leg velocity isn't always exactly zero
            if ((-0.1 < dr && dr < 0.1) && (r < r_min))
                state = State.Thrust;
                contact_offset = y_body - y_foot; % update foot contact offset
            end
       
        elseif state == State.Thrust
            F_thrust = F_push;
            if (r > r0)
                state = State.Unloading;
            end
        
        elseif state == State.Unloading
            if not(foot_contact)
                state = State.Flight;
                Ts = min(stance_timer, 0.28); % record stance time
                stance_timer = 0; % reset stance timer
            end
        end
            
        % permanent radial spring damper
        Fr = Kp_r*(r_ref - r) + Kd_r*(dr_ref - dr) + F_thrust;
        
        % transform into joint torques
        B = JT * [Fr; tau];       
        
    end
    ctrl_state = state;
    
end