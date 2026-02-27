function un=solvempcproblem(x,F,G,M,N,Q1,Q2,ubounds,Ts,t)
warning off
[n,m]=size(G);
[H,S]=createpredictors(F,G,N);
Q1b=blockrepeat(Q1,N);
Q2b=blockrepeat(Q2,N);
Mb=blockrepeat(M,N);
Au=[eye(N*m);-eye(N*m)];
bu=[repmat(ubounds(:,2),N,1);repmat(-ubounds(:,1),N,1)];

options=optimset('Display','off');
U=quadprog(S'*Mb'*Q1b*Mb*S+Q2b,S'*Mb'*Q1b*Mb*H*x,Au,bu,...
[],[],[],[],[],options);


disp(S'*Mb'*Q1b*Mb*H*x)
un=U(1:m);