clc; clear; close all;

%FPR = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.050,0.15,0.15,0.15,0.20,0.20,0.20,0.20,0.20,0.20,0.20,0.25,0.25,0.30,0.35,0.40,0.45,0.45,0.55,0.60,0.65,0.65,0.70,0.70,0.70,0.70,0.70,0.70,0.75,0.75,0.80,0.85,0.90,0.90,0.90,0.95,0.95,0.95,1];
%TPR = [0,0,0.050,0.050,0.050,0.050,0.10,0.15,0.15,0.15,0.15,0.15,0.15,0.20,0.25,0.30,0.35,0.35,0.40,0.45,0.45,0.50,0.55,0.60,0.60,0.60,0.60,0.60,0.60,0.65,0.70,0.80,0.85,0.85,0.85,0.95,0.95,0.95,0.95,0.95,0.95,0.95,0.95,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
FPR= xlsread('集成','ensemble1','AB2:AB713');

TPR= xlsread('集成','ensemble1','AC2:AC713');
acurve=trapz(FPR,TPR);%计算AUC

x_dig=0:0.01:1;
y_dig=x_dig;
color2=[1,0,0]
color1=[0.9300    0.4700    0.5000];%红色
coloot_2=[0 0 255]./255;
color3=[229 159 1]./255;
color4=[107,105,102]./255;
h=figure;
set(h,'units','normalized','position',[0.1 0.1 0.48 0.8]);%设置绘图窗口的大小
set(h,'color','w');%设置绘图窗口的背景为白色
h1=plot(FPR, TPR,'Color',color2,'LineWidth',2,'MarkerSize',3);
hold on;
plot(x_dig,y_dig,'--','Color',color4,'LineWidth',1.5);%画中间的虚线
xlabel('False Positive Ratio (1-specificity)','fontsize',2,'FontWeight','bold');%x轴
ylabel('True Positive Ratio (Sensitivity)','fontsize',2,'FontWeight','bold');%y轴
set(gca,'YLim',[0,1]);
set(gca,'XLim',[0,1]);
fontsize=26;
set(gca,'FontSize',fontsize,'LineWidth',1.6)
set(get(gca,'YLabel'),'FontSize',fontsize);
set(get(gca,'XLabel'),'FontSize',fontsize);
set(gca,'YTick',[0:0.2:1])

grid on
%%
%%画图例

%%

expert1_spe=0.60
expert1_sen=0.67
coloot_l=[0.69804,0.13333,0.13333]
h2=plot(1-expert1_spe,expert1_sen,'.','Color',coloot_l,'MarkerSize',50)

% ROCtitle_1=['expert1'];
% h2=legend(ROCtitle_1);
% set(h2,'edgecolor','white')


expert2_spe=0.58
expert2_sen=0.75
coloot2=[1,0.5,0]
h3=plot(1-expert2_spe,expert2_sen,'.','Color',coloot2,'MarkerSize',50)

expert3_spe=0.52
expert3_sen=0.74
coloot_3=[0.5451,0.51373,0.47059]
%coloot_3=[192/255,192/255,192/255]
h4=plot(1-expert3_spe,expert3_sen,'.','Color',coloot_3,'MarkerSize',50)

expert1_spe=0.63
expert1_sen=0.66
coloot_4=[0.67,0,1]
h5=plot(1-expert1_spe,expert1_sen,'.','Color',coloot_4,'MarkerSize',50)

model_spe=0.68
model_sen=0.85
%coloot_4=[0.67,0,1]
%h1=plot(1-model_spe,model_sen,'.','Color',color2,'MarkerSize',50)

ROCtitle_1=['STEM']%AUC = ',num2str(roundn(acurve,-3))];
hh=legend([h3,h2,h4,h5,h1],'Embryologist-I','Embryologist-II','Embryologist-III','Embryologist-IV',ROCtitle_1)%,'Location','southeast');


set(hh,'edgecolor','white')
set(gca, 'LineWidth',3 , 'fontangle','normal','box','off')