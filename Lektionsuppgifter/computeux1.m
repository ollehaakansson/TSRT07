function [u, x] = computeux1(u_man, a_mode, r, y, x_prev, ctrlparam, ubounds, Ts)
%COMPUTEUX1 Discrete PI controller with actuator saturation (NO anti-windup).
%
% This implementation is intentionally "naive": it always integrates the error,
% even when the actuator is saturated. That will typically create integrator
% windup -> large overshoot and slow recovery.
%
% Inputs:
%   u_man     - manual up/down signal (not used here)
%   a_mode    - 1 = automatic, 0 = manual (not used here; assumed automatic)
%   r, y      - reference and measured output at current sample
%   x_prev    - controller state from previous sample (integrator state)
%   ctrlparam - [K, Ti, Td, mu, theta...]
%   ubounds   - [umin, umax]
%   Ts        - sampling time
%
% Outputs:
%   u         - saturated control signal
%   x         - updated controller state

% ----- Unpack parameters -----
K  = ctrlparam(1);   % proportional gain
Ti = ctrlparam(2);   % integral time constant
% Td, mu, theta exist but are not used in the pure PI case
% Td = ctrlparam(3); mu = ctrlparam(4);

umin = ubounds(1);
umax = ubounds(2);

% ----- Unpack state -----
I_prev = x_prev(1);  % integrator state (the only state in this PI version)

% ----- Control error -----
e = r - y;

% ----- Integrator update (Euler forward) -----
% Always integrate, regardless of saturation (this is what causes windup).
I = I_prev + (K*Ts/Ti)*e;

% ----- Unsaturated controller output (PI) -----
v = K*e + I;

% ----- Actuator saturation -----
if v < umin
    u = umin;
elseif v > umax
    u = umax;
else
    u = v;
end

% ----- State output -----
x = I;
end
