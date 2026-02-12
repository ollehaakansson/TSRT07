% This file can be used to set the PID parameters used in xpcpid.mdl.

Ku=51;
Tu=1.57;
K=3.86; % Controller gain
Ti=27; % Integral time
Td=0; % Derivative time
mu=0.1; % Derivative filter parameter
Ts=0.02; % Sampling time
Kf = 2;
ubounds=[0;10]; %Control signal limits

u0 = 4;
y0 = 5.5;
N = 3; % [I_mem; e_prev; bias]
theta = [1; 1; Kf; u0];
% Run this to update the parameters in real-time to xpc
changeparam

% Set this variable to the process you have, ie.
% elmotor, vattentank, vindflojel
labprocess = 'vattentank';