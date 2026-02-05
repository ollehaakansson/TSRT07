% This file can be used to plot the signals that have been collected 
% using xpcpid.mdl.

t=tg.outputLog(:,1);
r=tg.outputLog(:,2);
y=tg.outputLog(:,3);
u=tg.outputLog(:,4);

pause(0.5)

save signalData t r y u

pause(2)

figure(1)
clf
subplot(211)
stairs(t,u)
legend('u')
subplot(212)
plot(t,y,'k')
hold on
plot(t,r,'r:')
legend('y','r')
