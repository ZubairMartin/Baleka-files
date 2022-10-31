rawData = readtable('mid_walk_thbod_locked_v9_looped.csv');
dataLen = height(rawData);
loopLen = dataLen/100;
n = rawData(1:dataLen,"node");
thULA = rawData(1:dataLen,"thULA");
thURA = rawData(1:dataLen,"thURA");
thULB = rawData(1:dataLen,"thULB");
thURB = rawData(1:dataLen,"thURB");

dthULA = rawData(1:dataLen,"dthULA");
dthURA = rawData(1:dataLen,"dthURA");
dthULB = rawData(1:dataLen,"dthULB");
dthURB = rawData(1:dataLen,"dthURB");

tLeftA = rawData(1:dataLen,"tLeftA");
tLeftB = rawData(1:dataLen,"tLeftB");
tRightA = rawData(1:dataLen,"tRightA");
tRightB = rawData(1:dataLen,"tRightB");

n = table2array(n);
thULA = table2array(thULA);
thURA = table2array(thURA);
thULB = table2array(thULB);
thURB = table2array(thURB);

dthULA = table2array(dthULA);
dthURA = table2array(dthURA);
dthULB = table2array(dthULB);
dthURB = table2array(dthURB);

tLeftA = table2array(tLeftA);
tLeftB = table2array(tLeftB);
tRightA = table2array(tRightA);
tRightB = table2array(tRightB);

V_avg = 0.4*sqrt(0.38*9.8);
TT = (0.8/V_avg)*loopLen;



t = [0:TT/(dataLen-1):TT];
t = transpose(t);

tInterp = linspace(0,loopLen,500*loopLen);
thULAi = interp1(t,thULA,tInterp);
thURAi = interp1(t,thURA,tInterp);
thULBi = interp1(t,thULB,tInterp);
thURBi = interp1(t,thURB,tInterp);

dthULAi = interp1(t,dthULA,tInterp);
dthURAi = interp1(t,dthURA,tInterp);
dthULBi = interp1(t,dthULB,tInterp);
dthURBi = interp1(t,dthURB,tInterp);

tLeftAi = interp1(t,tLeftA,tInterp)';
tLeftBi = interp1(t,tLeftB,tInterp)';
tRightAi = interp1(t,tRightA,tInterp)';
tRightBi = interp1(t,tRightB,tInterp)';

ti = tInterp;
ti = ti';

thULA = -thULAi;
thURA = pi-thURAi;
thULB = -thULBi;
thURB = pi-thURBi;

thULA = thULA';
thURA = thURA';
thULB = thULB';
thURB = thURB';

dthULA = -dthULAi';
dthURA = -dthURAi';
dthULB = -dthULBi';
dthURB = -dthURBi';
 
m1_arr = [ti thURA];
m2_arr = [ti thURB];
m3_arr = [ti thULB];
m4_arr = [ti thULA];

% m1var = struct('values',thURA);
% m2var = struct('values',thURB);
% m3var = struct('values',thULB);
% m4var = struct('values',thULA);
% 
% m1_arr = struct('time',[],'signals',m1var);
% m2_arr = struct('time',[],'signals',m2var);
% m3_arr = struct('time',[],'signals',m3var);
% m4_arr = struct('time',[],'signals',m4var);

dm1_arr = [ti dthURA];
dm2_arr = [ti dthURB];
dm3_arr = [ti dthULB];
dm4_arr = [ti dthULA];

tm1_arr = [ti tRightAi];
tm2_arr = [ti tRightBi];
tm3_arr = [ti tLeftBi];
tm4_arr = [ti tLeftAi];


KpVal = 100;
KdVal = KpVal/10;
