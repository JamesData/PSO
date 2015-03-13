function [ParSwarm,OptSwarm]=HybirdInitSwarm(SwarmSize,ParticleSize,ParticleScope,AdaptFunc)  
%�����������ֲ��汾������Ⱥ�㷨����ʼ������Ⱥ���޶�����Ⱥ��λ���Լ��ٶ���ָ���ķ�Χ��  
%[ParSwarm,OptSwarm,BadSwarm]=LocalInitSwarm(SwarmSize,ParticleSize,ParticleScope,AdaptFunc)  
%  
%���������SwarmSize:��Ⱥ��С�ĸ���  
%���������ParticleSize��һ�����ӵ�ά��  
%���������ParticleScope:һ�������������и�ά�ķ�Χ��  
%         ParticleScope��ʽ:  
%           3ά���ӵ�ParticleScope��ʽ:  
%                                   [x1Min,x1Max  
%                                    x2Min,x2Max  
%                                    x3Min,x3Max]  
%  
%���������AdaptFunc����Ӧ�Ⱥ���  
%  
%�����ParSwarm��ʼ��������Ⱥ  
%�����OptSwarm����Ⱥ��ǰ���Ž���ÿ��������������Ž⣬��һ�γ�ʼ�������������Ϊ0����Ϊ���ӱ���  
%  
%�÷� [ParSwarm,OptSwarm,BadSwarm]=LocalInitSwarm(SwarmSize,ParticleSize,ParticleScope,AdaptFunc);  
%  
%�쳣�����ȱ�֤���ļ���Matlab������·���У�Ȼ��鿴��ص���ʾ��Ϣ��  
%  
%�����ˣ�XXX  
%����ʱ�䣺2010.5.6  
%�ο����ף���  
%  
  
%�ݴ����  
if nargin~=4  
    error('����Ĳ�����������')  
end  
if nargout<2  
    error('����Ĳ����ĸ���̫�٣����ܱ�֤�Ժ�����С�');  
end  
  
[row,colum]=size(ParticleSize);  
if row>1||colum>1  
    error('��������ӵ�ά��������һ��1��1�е����ݡ�');  
end  
[row,colum]=size(ParticleScope);  
if row~=ParticleSize||colum~=2  
    error('��������ӵ�ά����Χ����');  
end  
  
%��ʼ������Ⱥ����  
  
%��ʼ������Ⱥ����ȫ����Ϊ[0-1]�����  
%rand('state',0);  
ParSwarm=rand(SwarmSize,2*ParticleSize+1);  
  
%������Ⱥ��λ��,�ٶȵķ�Χ���е���  
for k=1:ParticleSize  
    ParSwarm(:,k)=ParSwarm(:,k)*(ParticleScope(k,2)-ParticleScope(k,1))+ParticleScope(k,1);  
    %�����ٶȣ�ʹ�ٶ���λ�õķ�Χһ��  
    ParSwarm(:,ParticleSize+k)=ParSwarm(:,ParticleSize+k)*(ParticleScope(k,2)-ParticleScope(k,1))+ParticleScope(k,1);  
end  
      
%��ÿһ�����Ӽ�������Ӧ�Ⱥ�����ֵ  
  
for k=1:SwarmSize  
    ParSwarm(k,2*ParticleSize+1)=AdaptFunc(ParSwarm(k,1:ParticleSize));  
end  
  
%��ʼ������Ⱥ���Ž����,��SwarmSize*2�У�����ǰSwarmSize�м�¼�����Լ���ʷ���Ž⣬��SwarmSize�м�¼�������Ž�  
OptSwarm=zeros(SwarmSize*2+1,ParticleSize);  
%����Ⱥ���Ž����ȫ����Ϊ��  
OptSwarm(1:SwarmSize,:)=ParSwarm(1:SwarmSize,1:ParticleSize);  
%������������Ϊ1�����Ž�  
linyu=1;  
    for row=1:SwarmSize  
        if row-linyu>0&&row+linyu<=SwarmSize  
            tempM =[ParSwarm(row-linyu:row-1,:);ParSwarm(row+1:row+linyu,:)];              
            [maxValue,linyurow]=max(tempM(:,2*ParticleSize+1));             
            OptSwarm(SwarmSize+row,:)=tempM(linyurow,1:ParticleSize);             
        else  
            if row-linyu<=0  
                %��������Ĳ���ͻ���˱߽磬������Բ���ͻ�Ʊ߽�  
                if row==1  
                    tempM=[ParSwarm(SwarmSize+row-linyu:end,:);ParSwarm(row+1:row+linyu,:)];  
                    [maxValue,linyurow]=max(tempM(:,2*ParticleSize+1));                       
                    OptSwarm(SwarmSize+row,:)=tempM(linyurow,1:ParticleSize);                     
                else  
                    tempM=[ParSwarm(1:row-1,:);ParSwarm(SwarmSize+row-linyu:end,:);ParSwarm(row+1:row+linyu,:)];  
                    [maxValue,linyurow]=max(tempM(:,2*ParticleSize+1));                      
                    OptSwarm(SwarmSize+row,:)=tempM(linyurow,1:ParticleSize);                    
                end  
            else  
                %��������Ĳ���ͻ���˱߽磬������Բ���ͻ�Ʊ߽�  
                if row==SwarmSize  
                    tempM=[ParSwarm(SwarmSize-linyu:row-1,:);ParSwarm(1:linyu,:)];  
                    [maxValue,linyurow]=max(tempM(:,2*ParticleSize+1));                       
                    OptSwarm(SwarmSize+row,:)=tempM(linyurow,1:ParticleSize);  
                else  
                    tempM=[ParSwarm(row-linyu:row-1,:);ParSwarm(row+1:end,:);ParSwarm(1:linyu-(SwarmSize-row),:)];    
                    [maxValue,linyurow]=max(tempM(:,2*ParticleSize+1));                      
                    OptSwarm(SwarmSize+row,:)=tempM(linyurow,1:ParticleSize);                      
                end  
            end  
        end  
    end%for  

%Ѱ����Ӧ�Ⱥ���ֵ���Ľ��ھ����е�λ��(����)  
[maxValue,row]=max(ParSwarm(:,2*ParticleSize+1));  
OptSwarm(SwarmSize*2+1,:)=ParSwarm(row,1:ParticleSize);  