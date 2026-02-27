A = [-3 1; 0 1];
B = [0; 4];
C = eye(2);
D = [0; 0];

[m ,n]=size(C);
x_0 = [1; 1];
M = eye(m);
N = 2;

Q1 = 10*eye(m);
Q2 = 2;

ubounds = [-5, 5];
Ts = 0.05; % tog bara nåt
t = 0;

sys = ss(A, B, C, 0);
sys_d = c2d(sys, Ts);

F1 = sys_d.A;
G1 = sys_d.B;

feedback(sys_d, eye(2));