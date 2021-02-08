clc
clear
close
x= xlsread('集成，寻找最优的时空权重值','Sheet1','E2:E102');

y= xlsread('集成，寻找最优的时空权重值','Sheet1','G2:G102');

plot(x,y,'LineWidth',2)

fontsize=26
xlabel('The weight of temporal stream network','FontWeight','bold','fontsize',6);%x轴
ylabel('Accuracy','FontWeight','bold','fontsize',6);%y轴
set(gca,'FontSize',fontsize,'LineWidth',6)
set(get(gca,'YLabel'),'FontSize',fontsize);
set(get(gca,'XLabel'),'FontSize',fontsize);
axis([0 1 0.60 0.85])
%grid on
set(gca,'XTick',0:0.2:1);
set(gca,'YTick',0.60:0.05:0.85);
set(gca,'YTickLabel',{'0.60','0.65','0.70','0.75','0.80','0.85'});
set(gca, 'LineWidth',3 , 'fontangle','normal','box','off')
set(gcf,'position',[200,10,850,850]);
%set(gca,'units','normalized','position',[0.1 0.1 0.48 0.8]);