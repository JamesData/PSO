function result=Ackley(x)  
%Ackley ����  
%����x,������Ӧ��yֵ,��x=(0,0,��,0) ����ȫ�ּ�С��0,Ϊ�õ����ֵ������ֵȡ�෴��  
%�����ˣ�  
%�������ڣ�  
[row,col]=size(x);  
if row>1  
    error('����Ĳ�������');  
end  
result=-20*exp(-0.2*sqrt((1/col)*(sum(x.^2))))-exp((1/col)*sum(cos(2*pi.*x)))+exp(1)+20;  
result=-result;  