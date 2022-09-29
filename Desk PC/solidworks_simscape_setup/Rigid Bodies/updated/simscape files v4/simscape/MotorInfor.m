 %% Testing direction and values

% AK10-9 V2 (1.1)
p_min = -12.5; % rad
p_max = +12.5; % rad
v_min = -50.0; % rad/s
v_max = +50.0; % rad/s
t_min = -65.0; % Nm
t_max = +65.0; % Nm
kp_min = 0;
kp_max = 500;
kd_min = 0;
kd_max = 5;

% Motor directions
M3 = '+ve = CW';
M2 = '+ve = CW';

% Time
Simulation = 1/1000;

% M3 - write
period = 1/250;
pulse_width = 50;
phasedelay_sec = 3;

%M3 - read
period = 1/250;
pulse_width = 50;
phasedelay_sec = 3.001;

% M2
period = 1/250;
pulse_width = 50;
phasedelay_sec = 3.002;

%M2 - read
period = 1/250;
pulse_width = 50;
phasedelay_sec = 3.003;

% Motor Positions
M3 = 'left';
M2 = 'right';

% contacts
% occurs between upper link and upper most couplers of each leg

% upper link dim
UL_length = 174.5/1000;
UL_width = 8/1000;

% upper left coupler
diameter = 8/1000;
length = 44.6/1000;

% upper right coupler
diameter = 8/1000;
length = 28.6/1000;
