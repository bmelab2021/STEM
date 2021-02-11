clc; clear; close all;

%FPR = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.050,0.15,0.15,0.15,0.20,0.20,0.20,0.20,0.20,0.20,0.20,0.25,0.25,0.30,0.35,0.40,0.45,0.45,0.55,0.60,0.65,0.65,0.70,0.70,0.70,0.70,0.70,0.70,0.75,0.75,0.80,0.85,0.90,0.90,0.90,0.95,0.95,0.95,1];
%TPR = [0,0,0.050,0.050,0.050,0.050,0.10,0.15,0.15,0.15,0.15,0.15,0.15,0.20,0.25,0.30,0.35,0.35,0.40,0.45,0.45,0.50,0.55,0.60,0.60,0.60,0.60,0.60,0.60,0.65,0.70,0.80,0.85,0.85,0.85,0.95,0.95,0.95,0.95,0.95,0.95,0.95,0.95,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
FPR= xlsread('ense_file','ensemble1','V2:V734');

TPR= xlsread('ense_file','ensemble1','W2:W734');%lstm

acurve=0.77;% AUC1

FPR2= xlsread('ense_file','ensemble1','Y2:Y804');

TPR2= xlsread('ense_file','ensemble1','Z2:Z804');%kong

acurve2=0.76;% AUC2

FPR3= xlsread('ense_file','ensemble1','AB2:AB713');

TPR3= xlsread('ense_file','ensemble1','AC2:AC713');%ensemble

acurve3=0.82;% AUC3
x_dig=0:0.01:1;
y_dig=x_dig;

color1=[0 0 1];% blue gradientboosting

color2=[1,0,0]% red

color3=[1,1, 0]
color4=[107,105,102]./255;
h=figure;
set(h,'units','normalized','position',[0.1 0.1 0.48 0.8]);
set(h,'color','w');
h2=plot(FPR, TPR,'Color',color1,'LineWidth',2,'MarkerSize',3);hold on;
plot(x_dig,y_dig,'--','Color',color4,'LineWidth',1.5);hold on;
h1=plot(FPR2, TPR2,'Color',color3,'LineWidth',2,'MarkerSize',3);hold on;
h3=plot(FPR3, TPR3,'Color',color2,'LineWidth',2,'MarkerSize',3);hold on;


xlabel('False Positive Ratio (1-specificity)','fontsize',2,'FontWeight','bold');%x 
ylabel('True Positive Ratio (Sensitivity)','fontsize',2,'FontWeight','bold');%y
set(gca,'YLim',[0,1]);
set(gca,'XLim',[0,1]);
fontsize=26
set(gca,'FontSize',fontsize,'LineWidth',1.6)
set(get(gca,'YLabel'),'FontSize',fontsize);
set(get(gca,'XLabel'),'FontSize',fontsize);
set(gca,'YTick',[0:0.2:1])

grid on
%%
%%plot
ROCtitle_1=['STEM AUC = ',num2str(roundn(acurve3,-3))];
ROCtitle_2=['Temporal model AUC = ',num2str(roundn(acurve,-3))];
ROCtitle_3=['Spatial model AUC = ',num2str(roundn(acurve2,-3))];
hh=legend([h3,h1,h2],ROCtitle_1,ROCtitle_3,ROCtitle_2)%,'Location','southeast');
set(hh,'edgecolor','white')
set(gca, 'LineWidth',3 , 'fontangle','normal','box','off','FontSize',fontsize)
%set(gcf,'position',[0,0,800,800]);
