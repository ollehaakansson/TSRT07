function [u, x] = computeux3(u_man, a_mode, r, y, x_prev, ctrlparam, ubounds, Ts)
%COMPUTEUX3 Discrete PI with saturation + back-calculation anti-windup.
%
% This method adds an extra correction term to the integrator:
%   I <- I + (Ts/Tt)*(u - v)
% where:
%   v = unsaturated controller output
%   u = saturated actuator output
% and Tt is a "tracking time constant" (theta(1)).
%
% Intuition:
%   - When saturated, u != v. The correction drives I so that v moves toward u,
%     i.e., the integrator state "tracks" what the actuator can actually deliver.

K   = ctrlparam(1);
Ti  = ctrlparam(2);
% Td = ctrlparam(3); mu = ctrlparam(4); not used in PI case
theta = ctrlparam(5:end);
Tt    = theta(1);  % tracking time constant

umin = ubounds(1);
umax = ubounds(2);

I_prev = x_prev(1);

e = r - y;

% Normal integrator update
I = I_prev + (K*Ts/Ti)*e;

% Unsaturated PI output
v = K*e + I;

% Saturate to actuator limits
if v < umin
    u = umin;
elseif v > umax
    u = umax;
else
    u = v;
end

% Back-calculation (integrator tracking)
I = I + (Ts/Tt)*(u - v);

x = I;
end
