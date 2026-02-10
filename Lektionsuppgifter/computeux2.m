function [u, x] = computeux2(u_man, a_mode, r, y, x_prev, ctrlparam, ubounds, Ts)
%COMPUTEUX2 Discrete PI with saturation + conditional integration (anti-windup).
%
% Idea:
%   - First compute the *tentative* control signal if we would integrate now.
%   - If that tentative signal is within actuator bounds, allow integration.
%   - Otherwise, freeze the integrator state.
%
% This prevents the integrator from "winding up" while saturated.

K  = ctrlparam(1);
Ti = ctrlparam(2);

umin = ubounds(1);
umax = ubounds(2);

I_prev = x_prev(1);

e = r - y;

% Tentative unsaturated signal if we integrate this step:
v_tent = K*e + I_prev + (K*Ts/Ti)*e;

% Conditional integration:
if (v_tent >= umin) && (v_tent <= umax)
    I = I_prev + (K*Ts/Ti)*e;
else
    I = I_prev;  % freeze integrator during saturation tendency
end

v = K*e + I;

% Saturate
if v < umin
    u = umin;
elseif v > umax
    u = umax;
else
    u = v;
end

x = I;
end
