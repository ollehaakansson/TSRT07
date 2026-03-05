clear; close all; clc
load distilldata.mat

Ts = 1;
sys  = ss(A,B,[],[]);
sysd = c2d(sys, Ts, 'zoh');
F = sysd.A;
G = sysd.B;

N  = 20;
Q1 = eye(size(Mz,1));
Q2 = 1e-2*eye(size(G,2));

ubounds = [ -V0, 5 - V0;
            -L0, 5 - L0 ];

xdagger = [0.98 0.90 0.76 0.53 0.37 0.20 0.08 0.02]';
x0 = xdagger;

mdl = 'distillmpcbasic';
if ~bdIsLoaded(mdl), load_system(mdl); end
set_param(mdl,'StopTime','200');

evalc("sim(mdl);");  % kör

% check
dV = U.signals(1).values;
dL = U.signals(2).values;
fprintf('ΔV: [%g, %g], bounds [%g, %g]\n', min(dV), max(dV), ubounds(1,1), ubounds(1,2));
fprintf('ΔL: [%g, %g], bounds [%g, %g]\n', min(dL), max(dL), ubounds(2,1), ubounds(2,2));