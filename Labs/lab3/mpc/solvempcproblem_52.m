function un = solvempcproblem_52(x,F,G,M,N,Q1,Q2,ubounds,Ts,t)
warning off
global uold

[n,m] = size(G);
p = size(M,1);

if isempty(uold)
    uold = zeros(m,1);
end

% Predictors
[H,S] = createpredictors(F,G,N);

% Block matrices
Q1b = blockrepeat(Q1,N);
Q2b = blockrepeat(Q2,N);
Mb  = blockrepeat(M ,N);

% Input bounds on U-sequence (samma som 5.1)
Au = [eye(N*m); -eye(N*m)];
bu = [repmat(ubounds(:,2),N,1);
      repmat(-ubounds(:,1),N,1)];

% Reference
R = zeros(N*p,1);
for j = 1:N
    tj = t + (j-1)*Ts;
    rj = ref_52(tj);              % p-by-1
    R( (j-1)*p + (1:p) ) = rj;
end

% I-Delen
% ΔU = D*U + d0, where first block is (u0 - uold)
D0 = eye(N);
D0(2:end,1:end-1) = D0(2:end,1:end-1) - eye(N-1);  % 1 on diag, -1 on subdiag
D = kron(D0, eye(m));

d0 = zeros(N*m,1);
d0(1:m) = -uold;

% QP:
% Z = Mb*(H*x + S*U)
% min 0.5*(Z-R)'Q1b(Z-R) + 0.5*(D*U+d0)'Q2b(D*U+d0)
Hqp = S'*Mb'*Q1b*Mb*S + D'*Q2b*D;
fqp = S'*Mb'*Q1b*(Mb*H*x - R) + D'*Q2b*d0;

options = optimset('Display','off');
U = quadprog(Hqp,fqp,Au,bu,[],[],[],[],[],options);

un = U(1:m);
uold = un;
end

function r = ref_52(t)
% Reference in deviation coordinates (z around equilibrium)
if (t >= 20) && (t < 60)
    r = [0.0123; 0.03];
else
    r = [0; 0];
end
end