%�򿪼�ʱ��
tic;
%
Scope=[-50 50
    -50 50];
[v,on,off,minmax]=PsoProcess(20,2,Scope,@InitSwarm,@BaseStepPso,@Griewank,0,0,4000,1);
toc