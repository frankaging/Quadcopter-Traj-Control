function [desired_state] = circle(t, qn)
% CIRCLE trajectory generator for accel circle

% =================== Your code goes here ===================
% You have to set the pos, vel, acc, yaw and yawdot variables

% Setting up accel arbitrary speed
% Calculate the run time based on this
time = 8;

% If the time is already longder than the max time, we need to run it in
% hovering mode
if t > time
    pos = [5 0 2.5];
    vel = [0, 0, 0];
    acc = [0, 0, 0];
    yaw = 0;
    yawdot = 0;
else
    
    thetaVal = [ (3*pi)/8192, -(15*pi)/2048, (5*pi)/128, 0, 0, 0];
    zVal = [15/32768, -75/8192, 25/512, 0, 0, 0];
    
    pos = [t^5, t^4, t^3, t^2, t^1, 1];
    vel = [5*t^4, 4*t^3, 3*t^2, 2*t, 1, 0];
    accel = [20*t^3, 12*t^2, 6*t, 2, 0, 0];
    
    theta = sum(pos .* thetaVal);
    
    % Position
    x = 5 * cos(theta);
    y = 5 * sin(theta);
    z = sum(pos .* zVal);
    
    % Speed
    x_d = -5 * sin(theta) * sum(vel .* thetaVal);
    y_d = 5 * cos(theta) * sum(vel .* thetaVal);
    z_d = sum(vel .* zVal);
    
    % Accel
    x_dd = -5 * cos(theta) * sum(vel .* thetaVal) - ...
        5 * sin(theta) * sum(accel .* thetaVal);
    y_dd = -5 * sin(theta) * sum(vel .* thetaVal) + ...
        5 * cos(theta) * sum(accel .* thetaVal);
    z_dd = sum(accel .* zVal);
    
    yaw = 0;
    yawdot = 0;
    
    pos = [x, y, z];
    vel = [x_d, y_d, z_d];
    acc = [x_dd, y_dd, z_dd];
end
% =================== Your code ends here ===================

desired_state.pos = pos(:);
desired_state.vel = vel(:);
desired_state.acc = acc(:);
desired_state.yaw = yaw;
desired_state.yawdot = yawdot;

end
