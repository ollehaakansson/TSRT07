% === Controller tuning parameters (from 3-parameter model) ===
Kp = 0.2;
T  = 1.4;
L  = 0.33;

lambda = 0.6;
Tc     = lambda*T;
mu     = 0.1;

K  = (T + L/2) / (Kp*(Tc + L));
Ti = T + L/2;
Td = 0;  % PI-case
