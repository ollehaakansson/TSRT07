%% The system
sys = tf([3.47],[26.8,1]);
sys0 = tf([3.47],[1]);
Gm = sys/sys0;

%% PID-parameters
Ku=51;
Tu=1.57;
K=3.86; % Controller gain
Ti=27; % Integral time
Td=0; % Derivative time
mu=0.1; % Derivative filter parameter
Ts=0.02; % Sampling time
Kf = 3.8; % Feedforward

anti_wind_up = 1; %Anti wind up
anti_bump = 1; % Anti bump

u0 = 4;
y0 = 5.5;
N = 4; % [I_mem; e_prev; bias; d_mem]
theta = [anti_wind_up; anti_bump; Kf];
ubounds=[0;10]; % Control signal limits

%% Signals

load benchmarksignals


%% Plots

% Simulate the model to get data
sim('simmodel_24',ref(end,1));

figure(1)
subplot(4,1,1)
plot(tsim,ysim,'b',tsim,rsim,'--r')
legend('y -- output','r -- reference')
title('Output and reference')
xlabel('t')
xlim([tsim(1),tsim(end)])
subplot(4,1,2)
stairs(tsim,umannsim,'b')
xlim([tsim(1),tsim(end)])
title('Uman')
xlabel('t')
subplot(4,1,3)
stairs(tsim,amnsim,'b')
title('Auto/manual -- 0 - manual, 1 - automatic')
xlabel('t')
ylim([-0.1,1.1])
xlim([tsim(1),tsim(end)])
subplot(4,1,4)
stairs(tsim,usim,'b')
hold on
plot([0,tsim(end)],ubounds(1)*[1,1],'--r')
plot([0,tsim(end)],ubounds(2)*[1,1],'--r')
hold off
legend('u -- control signal','u_{bound}')
ylim([ubounds(1)*1.1,ubounds(2)*1.1])
title('Control signal')
xlabel('t')
xlim([tsim(1),tsim(end)])
