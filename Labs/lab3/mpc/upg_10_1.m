A = [-0.0556 -0.05877; 0.01503 -0.005887];
B = [0; -0.03384];
C = eye(2);
D = [0; 0];

[m ,n]=size(C);
x_0 = [20; 2];
M = eye(m);
N = 30;

Q1 = 10*eye(m);
Q2 = 0.1;

ubounds = [-1, 1];
Ts = 0.5; % tog bara nåt
t = 0;

sys = ss(A, B, C, 0);
sys_d = c2d(sys, Ts);

F1 = sys_d.A;
G1 = sys_d.B;
