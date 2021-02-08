clc;
clear;
close all;

% data= xlsread('pro','f_35_lstm','L2:M2374');
lstm= xlsread('集成','ensemble1','B2:C2087');
kong= xlsread('集成','ensemble1','F2:G2087');

% data2= xlsread('ensemble','train 0.78','A8049:B9499');
% data=[data1;data2]

%label= xlsread('集成','ensemble1','P2:R2087');
%data= xlsread('集成','ensemble1','F2:G2087');

num1=100
pro0_ensemble=ones(101,1)
pro1_ensemble=ones(101,1)
pro_ensemble=ones(101,1)
for i =0:num1
    p=0+i*0.01 % p = 0,0.01,0.02......1
    q=1-p % q = 1,0.99,....0
    data=lstm*p+kong*q % weight
    
    data00=data(1:821,1)
    data01=data(1:821,2)
    data0=sum(data00>data01)
    pro0=data0/821 % spe

    data10=data(822:2086,1)
    data11=data(822:2086,2)
    data1=sum(data11>data10)
    pro1=data1/1265 % sen

    pro=(data0+data1)/2086 % acc
    pro0_ensemble(i+1,1)=pro0
    pro1_ensemble(i+1,1)=pro1
    pro_ensemble(i+1,1)=pro

end
% 
