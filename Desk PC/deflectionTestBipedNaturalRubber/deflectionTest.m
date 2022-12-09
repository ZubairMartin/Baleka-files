%% Notes

%{
x_body = right is +ve looking down the robot
The initial x = 0 is set globally - does not reset to zero after each run
ybody = 0.15 when robot on ground in rest state (up is +ve)
ybody = 0.202 when on force plate in rest state


Force vs ybody

Rest: ybody = 0.202 ---> force = -90.244
Push: 
    ybody = 0.20232 ---> force = -135.900
    ybody = 0.20204 ---> force = -137.001
    ybody = 0.20177 ---> force = -138.3014
    ybody = 0.20143 ---> force = -140.1210


    ybody = 0.2007 ---> force = -215.8037
    ybody = 0.2010---> force = -209.0306
    ybody = 0.2013---> force = -200.4272
    ybody = 0.2014---> force = -194.62806

%}

ybody = [0.20232;0.20204;0.20177; 0.20143;0.2007;0.2010;0.2013;0.2014];
force = [-135.900;-137.001;-138.3014;-140.1210;-215.8037;-209.0306;-200.4272;-194.62806];
kx = [0;0;0;0];
counter = 0;

for i = [1,3,5,7]
    counter = counter+1;
    kx(counter) = (force(i+1)-force(i))/(ybody(i+1)-ybody(i));
end
kx
mean(kx)