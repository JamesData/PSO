Scope=[-10 10;-10 10;-10 10;-10 10;-10 10;-10 10;-10 10;-10 10;-10 10;-10 10];%���ӵ�ά�����Ʒ�Χ  
qun=20;%����Ⱥ��Ⱥ��ģ  
lizi=10;%���ӵ�ά��  
[Result,OnLine,OffLine,MinMaxMeanAdapt,BestofStep]=LocalPsoProcessByCircle(qun,lizi,Scope,@LocalInitSwarm,@LocalStepPsoByCircle,@Rastrigin,0,0,4000,0);  