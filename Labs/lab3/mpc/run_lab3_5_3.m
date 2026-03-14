clear;  clc
load distilldata.mat

% Disktretisera (ZOH)
Ts = 1;
A = [A, zeros(size(A,1),1); zeros(1,size(A,2)), 0];
B = [B, zeros(size(B,1),1); zeros(1,size(B,2)), -Ts/3];
Mz = [Mz, zeros(size(Mz,1),1); zeros(1,size(Mz,2)), 1];
D = 0;

sys  = ss(A,B,[], []);
sysd = c2d(sys, Ts, 'zoh');
F = sysd.A;
G = sysd.B;

% MPC params 
N  = 10;
p  = size(Mz,1);
m  = size(G,2);

q_z3 = 1000;

Q1 = diag([100, 100, q_z3]); % testat allt mellan 50-150 för första param
Q2 = diag([1,1 1000]);   % istället för 3e-4

% Bounds på Δu (eftersom regulatorn jobbar med avvikelser)
ubounds = [ -V0, 5 - V0;
            -L0, 5 - L0;
            - F0, 5 - F0];

% Initialtillstånd: jämvikt
x0 = xstar(:);

% Reset I-action memory
global uold
uold = [];

% Load model
mdl = 'distillmpcbuffer';
if ~bdIsLoaded(mdl), load_system(mdl); end

% Peka MPC-blocket till solvempcproblem_52
blk = [mdl '/MPC Controller'];
maskNames  = get_param(blk,'MaskNames');
maskValues = get_param(blk,'MaskValues');
idx = find(strcmp(maskNames,'ufname'),1);
maskValues{idx} = '''solvempcproblem_53''';
set_param(blk,'MaskValues',maskValues);

% Simulera. Av någon anledning så uppdaterades inte mina params om jag it
% kör följande 2 rader.
set_param(mdl,'FastRestart','off'); %1
set_param(mdl,'SimulationCommand','update'); %2
set_param(mdl,'StopTime','300');
evalc("sim(mdl);");

rita(X,U)

%% Result
% Params: Ts=1, N=70, Q1=diag([110 200]), Q2=6e-4*I
% Ref: r(t) = [0.0123; 0.03] for 20<=t<60, else 0

% max|z-r| during step:
% z1 = 0.0081
% z2 = 0.0183

% mean(z-r) on [55,60):
% z1 = -0.0024
% z2 = -0.0020
%
% var(z) on [23,25]:
% z1 = 0.0012
% z2 = 0.0003

% z2 tracks closer than z1 near end of step; both are ish constant by t=25.

