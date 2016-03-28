function [desired_state] = diamond(t, qn)
% DIAMOND trajectory generator for accel diamond

% =================== Your code goes here ===================
% You have to set the pos, vel, acc, yaw and yawdot variables

% Setting up accel arbitrary speed
speed = 0.1;
% Calculate the run time based on this
time = 1 / speed;
yaw = 0;
yawdot = 0;

% If the time is already longder than the max time, we need to run it in
% hovering mode
if t > time
    pos = [1 0 0];
    vel = [0, 0, 0];
    acc = [0, 0, 0];
    
else
    kx = [ 48/3125, -12/125, 4/25, 0, 0, 0;
        48/3125, -36/125, 52/25, -36/5, 12, -15/2;
        48/3125, -12/25, 148/25, -36, 108, -255/2;
        48/3125, -84/125, 292/25, -504/5, 432, -735];
    
    ky = [ (192*2^(1/2))/3125, -(48*2^(1/2))/125, (16*2^(1/2))/25, 0, 0, 0;...
        -(192*2^(1/2))/3125, (144*2^(1/2))/125, -(208*2^(1/2))/25, (144*2^(1/2))/5, -48*2^(1/2), 32*2^(1/2);...
        -(192*2^(1/2))/3125, (48*2^(1/2))/25, -(592*2^(1/2))/25, 144*2^(1/2), -432*2^(1/2), 512*2^(1/2);...
        (192*2^(1/2))/3125, -(336*2^(1/2))/125, (1168*2^(1/2))/25, -(2016*2^(1/2))/5, 1728*2^(1/2), -2944*2^(1/2)];
    
    kz = [  (192*2^(1/2))/3125, -(48*2^(1/2))/125, (16*2^(1/2))/25, 0, 0, 0;...
        (192*2^(1/2))/3125, -(144*2^(1/2))/125, (208*2^(1/2))/25, -(144*2^(1/2))/5, 48*2^(1/2), -30*2^(1/2);...
        -(192*2^(1/2))/3125, (48*2^(1/2))/25, -(592*2^(1/2))/25, 144*2^(1/2), -432*2^(1/2), 514*2^(1/2);...
        -(192*2^(1/2))/3125, (336*2^(1/2))/125, -(1168*2^(1/2))/25, (2016*2^(1/2))/5, -1728*2^(1/2), 2944*2^(1/2)];
    
    idx = floor(t / 2.5) + 1;
    if idx <= 0
        idx = 1;
    end
    
    local_t = t;
    
    pos = [local_t^5, local_t^4, local_t^3, local_t^2, local_t^1, 1];
    vel = [5*local_t^4, 4*local_t^3, 3*local_t^2, 2*local_t, 1, 0];
    accel = [20*local_t^3, 12*local_t^2, 6*local_t, 2, 0, 0];
    
    x = sum(kx(idx, :) .* pos);
    y = sum(ky(idx, :) .* pos);
    z = sum(kz(idx, :) .* pos);
    
    xd = sum(kx(idx, :) .* vel);
    yd = sum(ky(idx, :) .* vel);
    zd = sum(kz(idx, :) .* vel);
    
    xdd = sum(kx(idx, :) .* accel);
    ydd = sum(ky(idx, :) .* accel);
    zdd = sum(kz(idx, :) .* accel);
    
    pos = [x, y, z];
    vel = [xd, yd, zd];
    acc = [xdd, ydd, zdd];
    
    
    
    
end

% =================== Your code ends here ===================

desired_state.pos = pos(:);
desired_state.vel = vel(:);
desired_state.acc = acc(:);
desired_state.yaw = yaw;
desired_state.yawdot = yawdot;

end
