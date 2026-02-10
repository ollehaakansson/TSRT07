function [u, x] = computeux4(u_man, a_mode, r, y, x_prev, ctrlparam, ubounds, Ts)
%COMPUTEUX4 Discrete PID with first-order derivative filter + saturation + anti-windup.
%
% States (3):
%   x_prev(1) = I_prev  : integrator state
%   x_prev(2) = e_prev  : previous error (for discrete derivative)
%   x_prev(3) = d_prev  : previous filtered derivative state
%
% Derivative filter discretization used (as in course solution):
%   d = (mu*Td*d_prev + (e - e_prev)) / (mu*Td + Ts)
%
% Output:
%   v = K*e + I + K*Td*d
%
% Anti-windup:
%   I <- I + (Ts/Tt)*(u - v)

K   = ctrlparam(1);
Ti  = ctrlparam(2);
Td  = ctrlparam(3);
mu  = ctrlparam(4);

theta = ctrlparam(5:end);
Tt    = theta(1);

umin = ubounds(1);
umax = ubounds(2);

% Unpack states
I_prev = x_prev(1);
e_prev = x_prev(2);
d_prev = x_prev(3);

% Current error
e = r - y;

% Integrator update (preliminary)
I = I_prev + (K*Ts/Ti)*e;

% Filtered derivative update
d = (mu*Td*d_prev + (e - e_prev)) / (mu*Td + Ts);

% Unsaturated PID output
v = K*e + I + K*Td*d;

% Saturation
if v < umin
    u = umin;
elseif v > umax
    u = umax;
else
    u = v;
end

% Anti-windup (tracking / back-calculation)
I = I + (Ts/Tt)*(u - v);

% Pack updated states
x = [I; e; d];
end
