Scope=[-10 10;-10 10];%����ÿά�����Ʒ�Χ  
qun=20;%����Ⱥ�Ĺ�ģ  
lizi=2;%ÿ�����ӵ�ά��  
[Result,OnLine,OffLine,MinMaxMeanAdapt,BestofStep]=HybirdPsoProcessByCircle(qun,lizi,Scope,@HybirdInitSwarm,@HybirdStepPso,@Rastrigin,0,0,1000,0);  