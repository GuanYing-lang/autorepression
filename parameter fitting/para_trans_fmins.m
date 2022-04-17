%% run 'A16K5.m' first to get original input
hold on
load A16K5
clear data
data(:,1)=Input-10;
data(:,2)=M-10;
data(:,3)=S;
[i,j]=find(data(:,:)>9143);
data(i,:)=[];
beta0=0;alpha=9143;
tic
beta = fminsearch(@errorMeasure, beta0, [], data);
fprintf('time= %g\n', toc);
[i,j]=find(data(:,2)<beta);
data(i,:)=[];
In = data(:,1);
Ou = data(:,2);
% save paradata data In Ou beta alpha M S Input
A1=[ones(size(In)) log(In)];
Y1=(Ou-beta)/alpha;
Y2=log(1./Y1-1);
lamda=A1\Y2;
n=lamda(2)
K=exp(-lamda(1)/n);


Outpre=beta+alpha./(1+((Input-10)/K).^n);

Iplot=10.^([0:0.1:5]);
Oplot=beta+alpha./(1+(Iplot/K).^n);
figure('position',[50 50 450 450]);
ax=axes;
Ouput=M-10;

plot(Iplot,Oplot,'Marker','none','LineStyle','-','Color',[105 105 105]/255,'LineWidth',1.5);
hold on
plot(Input,Ouput,'MarkerSize',9, 'MarkerEdgeColor',[102 205 170]/255,'MarkerFaceColor',[102 205 170]/255,'Marker','s','LineStyle','none');
% errorbar(Input,Ouput,S,'Marker','none','LineStyle','none','LineWidth',1.5,'Color',[0 0 0]);
set(ax,'LineWidth',1,'FontSize',15,'XLim',[1 100000],'YLim',[1 100000],'XScale','log','YScale','log','XTick',[1 10^3 10^5],'YTick',[1 10^3 10^5]);
xlabel('Input');
ylabel('Output');
RMSE=sum(((Ouput-Outpre)./Ouput).^2);

fprintf('RMSE = %d\n', RMSE);
% load paraKN




