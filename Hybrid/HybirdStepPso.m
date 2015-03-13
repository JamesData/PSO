function [ParSwarm,OptSwarm]=HybridStepPso(ParSwarm,OptSwarm,AdaptFunc,ParticleScope,MaxW,MinW,LoopCount,CurCount)  
% �����������������Ⱥ�㷨����ȫ�ְ汾��ֲ��汾���ϡ�����������Ⱥ�㷨�ĵ�������λ��,�ٶȵ��㷨  
%  
%[ParSwarm,OptSwarm]=LocalStepPsoByCircle(ParSwarm,OptSwarm,AdaptFunc,ParticleScope,MaxW,MinW,LoopCount,CurCount)  
%  
%�㷨˼�룺ȫ�ְ汾���ٶȸ��¹�ʽ��vq(k+1)=w*v(k)+c1*r1*(pg-w)+c2*r2*(pq-w)  
%pgΪ������ʷ���ţ�pqΪȫ������  
%�ֲ��汾���ٶȸ��¹�ʽ��vl(k+1)=w*v(k)+c1*r1*(pg-w)+c2*r2*(pl-w) plΪ��������  
%�����ٶȸ��¹�ʽvh=n*vq+(1-n)*vl;n����0��1��һ����  
% ���������ParSwarm:����Ⱥ���󣬰������ӵ�λ�ã��ٶ��뵱ǰ��Ŀ�꺯��ֵ  
%���������OptSwarm����������Ⱥ�������Ž���ȫ�����Ž�ľ���  
%���������ParticleScope:һ�������������и�ά�ķ�Χ��  
% ���������AdaptFunc����Ӧ�Ⱥ���  
%���������LoopCount���������ܴ���  
%���������CurCount����ǰ�����Ĵ���  
%  
% ����ֵ������ͬ�����ͬ������  
%  
%�÷���[ParSwarm,OptSwarm]=LocalStepPsoByCircle(ParSwarm,OptSwarm,AdaptFunc,ParticleScope,MaxW,MinW,LoopCount,CurCount)  
%  
% �쳣�����ȱ�֤���ļ���Matlab������·���У�Ȼ��鿴��ص���ʾ��Ϣ��  
%  
%�����ˣ�XXX  
%����ʱ�䣺2010.5.6  
%�ο����ף�XXX  
%�ο����ף�XXX  
%  
%�޸ļ�¼  
%----------------------------------------------------------------  
%2010.5.6  
%�޸��ˣ�XXX  
% ���2*unifrnd(0,1).*SubTract1(row,:)�е�unifrnd(0,1)�������ʹ���ܴ�Ϊ���  
%�޸Ļ�����ӣ���С���󣬿�ʼ��CurCount/LoopCount��ʼ  
%�޸�C1=2.05,C2=2.05  
%�޸��ٶȵķ�Χʱ����ÿά��Χ��0.5(һ��)  
%���ջ���MATLAB������Ⱥ�Ż��㷨�������  
%  
% �������ۣ�ʹ������汾�ĵ���ϵ����Ч���ȽϺ�  
%  
  
%�ݴ����  
if nargin~=8  
    error('����Ĳ�����������')  
end  
if nargout~=2  
    error('����ĸ���̫�٣����ܱ�֤ѭ��������')  
end  
  
%��ʼ�������µĲ���  
  
%*********************************************  
%***** ��������Ĵ��룬���Ը��Ĺ������ӵı仯*****  
%---------------------------------------------------------------------  
% ���εݼ�����  
w=MaxW-CurCount*((MaxW-MinW)/LoopCount);  
%---------------------------------------------------------------------  
%w �̶��������  
%w=0.7;  
%---------------------------------------------------------------------  
% �ο����ף��¹������ֽ�Ԯ������������Ⱥ�Ż��㷨�Ĺ���Ȩֵ�ݼ������о���������ͨ��ѧѧ����2006��1  
%w �����εݼ����԰������ݼ�  
%w=(MaxW-MinW)*(CurCount/LoopCount)^2+(MinW-MaxW)*(2*CurCount/LoopCount)+MaxW;  
%---------------------------------------------------------------------  
%w �����εݼ����԰������ݼ�  
%w=MinW*(MaxW/MinW)^(1/(1+10*CurCount/LoopCount));  
%*****��������Ĵ��룬���Ը��Ĺ������ӵı仯*****  
%*********************************************  
%�������������Ըı������ӵ�ȡֵ  
%-----------------------------------------------  
Hybrid=CurCount/LoopCount;  
%-----------------------------------------------  
  
% �õ�����ȺȺ���С�Լ�һ������ά������Ϣ  
[ParRow,ParCol]=size(ParSwarm);  
  
%�õ����ӵ�ά��  
ParCol=(ParCol-1)/2;  
GlobleSubTract1=OptSwarm(1:ParRow,:)-ParSwarm(:,1:ParCol);%����������ʷ���Ž�λ�ü�ȥ���ӵ�ǰλ��  
LocalSubTract1=OptSwarm(1:ParRow,:)-ParSwarm(:,1:ParCol);%����������ʷ���Ž�λ�ü�ȥ���ӵ�ǰλ��  
LocalSubTract2=OptSwarm(ParRow+1:end-1,:)-ParSwarm(:,1:ParCol);%�����������Ž�λ�ü�ȥ���ӵ�ǰλ��  
%*********************************************  
%***** ��������Ĵ��룬���Ը���c1,c2�ı仯*****  
c1=2.05;  
c2=2.05;  
%---------------------------------------------------------------------  
%con=1;  
%c1=4-exp(-con*abs(mean(ParSwarm(:,2*ParCol+1))-AdaptFunc(OptSwarm(ParRow+1,:))));  
%c2=4-c1;  
%----------------------------------------------------------------------  
%***** ��������Ĵ��룬���Ը���c1,c2�ı仯*****  
%*********************************************  
for row=1:ParRow   
       GlobleSubTract2=OptSwarm(ParRow*2+1,:)-ParSwarm(row,1:ParCol);%ȫ�����ŵ�λ�ü�ȥÿ�����ӵ�ǰ��λ��     
       LocalTempV=w.*ParSwarm(row,ParCol+1:2*ParCol)+c1*unifrnd(0,1).*LocalSubTract1(row,:)+c2*unifrnd(0,1).*LocalSubTract2(row,:);  
       GlobleTempV=w.*ParSwarm(row,ParCol+1:2*ParCol)+c1*unifrnd(0,1).*GlobleSubTract1(row,:)+c2*unifrnd(0,1).*GlobleSubTract2;  
       TempV=Hybrid.*GlobleTempV+(1-Hybrid).*LocalTempV;  
   %�����ٶȵĴ���  
   for h=1:ParCol  
       if TempV(:,h)>ParticleScope(h,2)/2.0  
           TempV(:,h)=ParticleScope(h,2)/2.0;  
       end  
       if TempV(:,h)<-ParticleScope(h,2)/2.0  
           TempV(:,h)=(-ParticleScope(h,2)+1e-10)/2.0;  
           %��1e-10��ֹ��Ӧ�Ⱥ��������  
       end  
   end    
     
   % �����ٶ�  
   ParSwarm(row,ParCol+1:2*ParCol)=TempV;  
     
   %*********************************************  
   %***** ��������Ĵ��룬���Ը���Լ�����ӵı仯*****  
   %---------------------------------------------------------------------  
   %a=1;  
   %---------------------------------------------------------------------  
   a=0.729;  
   %***** ��������Ĵ��룬���Ը���Լ�����ӵı仯*****  
   %*********************************************  
     
   % ����λ�õķ�Χ  
   TempPos=ParSwarm(row,1:ParCol)+a*TempV;  
   for h=1:ParCol  
       if TempPos(:,h)>ParticleScope(h,2)  
           TempPos(:,h)=ParticleScope(h,2);  
       end  
       if TempPos(:,h)<=ParticleScope(h,1)  
           TempPos(:,h)=ParticleScope(h,1)+1e-10;             
       end  
   end  
  
   %����λ��   
   ParSwarm(row,1:ParCol)=TempPos;  
     
   % ����ÿ�����ӵ��µ���Ӧ��ֵ  
   ParSwarm(row,2*ParCol+1)=AdaptFunc(ParSwarm(row,1:ParCol));  
   if ParSwarm(row,2*ParCol+1)>AdaptFunc(OptSwarm(row,1:ParCol))  
       OptSwarm(row,1:ParCol)=ParSwarm(row,1:ParCol);  
   end  
end  
%forѭ������  
%ȷ������ķ�Χ  
linyurange=fix(ParRow/2);  
%ȷ����ǰ����������Χ  
jiange=ceil(LoopCount/linyurange);  
linyu=ceil(CurCount/jiange);  
    for row=1:ParRow  
        if row-linyu>0&&row+linyu<=ParRow  
            tempM =[ParSwarm(row-linyu:row-1,:);ParSwarm(row+1:row+linyu,:)];  
              
            [maxValue,linyurow]=max(tempM(:,2*ParCol+1));  
            if maxValue>AdaptFunc(OptSwarm(ParRow+row,:))  
                OptSwarm(ParRow+row,:)=tempM(linyurow,1:ParCol);  
            end  
        else  
            if row-linyu<=0  
                %��������Ĳ���ͻ���˱߽磬������Բ���ͻ�Ʊ߽�  
                if row==1  
                    tempM=[ParSwarm(ParRow+row-linyu:end,:);ParSwarm(row+1:row+linyu,:)];  
                    [maxValue,linyurow]=max(tempM(:,2*ParCol+1));  
                     if maxValue>AdaptFunc(OptSwarm(ParRow+row,:))  
                        OptSwarm(ParRow+row,:)=tempM(linyurow,1:ParCol);  
                     end  
                else  
                    tempM=[ParSwarm(1:row-1,:);ParSwarm(ParRow+row-linyu:end,:);ParSwarm(row+1:row+linyu,:)];  
                    [maxValue,linyurow]=max(tempM(:,2*ParCol+1));  
                     if maxValue>AdaptFunc(OptSwarm(ParRow+row,:))  
                        OptSwarm(ParRow+row,:)=tempM(linyurow,1:ParCol);  
                     end  
                end  
            else  
                %��������Ĳ���ͻ���˱߽磬������Բ���ͻ�Ʊ߽�  
                if row==ParRow  
                    tempM=[ParSwarm(ParRow-linyu:row-1,:);ParSwarm(1:linyu,:)];  
                    [maxValue,linyurow]=max(tempM(:,2*ParCol+1));  
                     if maxValue>AdaptFunc(OptSwarm(ParRow+row,:))  
                        OptSwarm(ParRow+row,:)=tempM(linyurow,1:ParCol);  
                     end  
                else  
                    tempM=[ParSwarm(row-linyu:row-1,:);ParSwarm(row+1:end,:);ParSwarm(1:linyu-(ParRow-row),:)];    
                    [maxValue,linyurow]=max(tempM(:,2*ParCol+1));  
                     if maxValue>AdaptFunc(OptSwarm(ParRow+row,:))  
                        OptSwarm(ParRow+row,:)=tempM(linyurow,1:ParCol);  
                     end  
                end  
            end  
        end  
    end%for  
    %Ѱ����Ӧ�Ⱥ���ֵ���Ľ��ھ����е�λ��(����)������ȫ�����ŵĸı�   
[maxValue,row]=max(ParSwarm(:,2*ParCol+1));  
if AdaptFunc(ParSwarm(row,1:ParCol))>AdaptFunc(OptSwarm(ParRow*2+1,:))  
    OptSwarm(ParRow*2+1,:)=ParSwarm(row,1:ParCol);  
end  