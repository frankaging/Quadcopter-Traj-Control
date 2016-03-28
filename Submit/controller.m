function [F, M, trpy, drpy] = controller(qd, t, qn, params)
% CONTROLLER quadrotor controller
% The current states are:
% qd{qn}.pos, qd{qn}.vel, qd{qn}.euler = [roll;pitch;yaw], qd{qn}.omega
% The desired states are:
% qd{qn}.pos_des, qd{qn}.vel_des, qd{qn}.acc_des, qd{qn}.yaw_des, qd{qn}.yawdot_des
% Using these current and desired states, you have to compute the desired controls

% =================== Your code goes here ===================

% PID Tunning Params
kp = 16;
kd = 9;
kp_ang = 8*[1 1 1]';
kd_ang = 0.3*[1 1 1]';

% Initialization Params
m = params.mass;
g = params.grav;

% Getting Data From Traj Functions
pos = qd{qn}.pos;
vel = qd{qn}.vel;
euler = qd{qn}.euler;
omega = qd{qn}.omega;
pos_des = qd{qn}.pos_des;
vel_des = qd{qn}.vel_des;
yaw_des = qd{qn}.yaw_des;
acc_des = qd{qn}.acc_des;
yawdot_des = qd{qn}.yawdot_des;
phi = euler(1); theta = euler(2); psi = euler(3);

% 1st Input-Thrust Calculation
pos_error = pos_des - pos;
vel_error = vel_des - vel;
thrust = acc_des*m + [0 0 m*g]' + m * (kp * pos_error + kd * vel_error);
F_des = thrust;
F = F_des(3);

% 2nd Input-Moments Calculation
phi_des = 1/g * (thrust(1)/m * sin(yaw_des) - thrust(2)/m * cos(yaw_des));
theta_des = 1/g * (thrust(1)/m * cos(yaw_des) + thrust(2)/m * sin(yaw_des));
psi_des = yaw_des;
ang_error = [phi_des theta_des psi_des]' - [phi theta psi]';

p_des = 0;
q_des = 0;
r_des = yawdot_des; 
ang_vel_error = [p_des q_des r_des]' - omega;

M = (kp_ang .* ang_error + kd_ang .* ang_vel_error);
   % =================== Your code ends here ===================
    
    % Output trpy and drpy as in hardware
    trpy = [F, phi_des, theta_des, psi_des];
    drpy = [0, 0,       0,         0];
end
