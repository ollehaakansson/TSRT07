% This file can be used to set the PID parameters used in xpcpid.mdl.

K=1; %Controller gain
Ti=10; %Integral time
Td=0.1; %Derivative time
mu=0.1; %Derivative filter param
theta=10; %Auxiliary parameter
Ts=0.02; %Sampling time
N=2; %Number of controller states
ubounds=[-4;6]; %Control signal limits

u0 = 0; % u0 for the system you have
y0 = 0; % y0 for the system you have

% Run this to update the parameters in real-time to xpc
changeparam

% Set this variable to the process you have, ie.
% elmotor, vattentank, vindflojel
labprocess = 'vindflojel';