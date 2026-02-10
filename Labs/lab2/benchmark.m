%% The system
sys = tf([2],[1,7,16,10]);

%% PID-parameters
Ku=51;
Tu=1.57;
K=0.35*Ku; % Controller gain
Ti=0.76*Tu; % Integral time
Td=0.19*Tu; % Derivative time
mu=0.1; % Derivative filter parameter
Ts=0.02; % Sampling time

% theta används här som två flaggor:
% theta(1)=anti-windup (0 av, 1 på)
% theta(2)=stötfri auto/man (0 av, 1 på)
theta = [1; 1];

N = 3; % [I_mem; e_prev; bias]

ubounds=[-6;6]; % Control signal limits

%% Signals

load benchmarksignals

%% Plots

% Simulate the model to get data
sim('simmodel',ref(end,1));

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
