%% transform
alpha=10000;beta=400;%需要修改
load A11K1;%需要修改
Input=[44.1573800050000,46.1631618450000,70.8762595093235,100.973050209728,188.646470991980,373.115490144538,556.182633696902,800.120233094962,1456.17388275565,2069.18304897070,2997.63518886883,5039.05252157064]'-10;
Inerr=[0.0678726131284850,0.971897149461355,23.6126256888038,43.0049781374996,85.3985042003886,190.887127969345,300.848821966225,235.407713634096,489.458283128839,430.746531530186,654.584555132633,630.957080702644];
Output=M'-10;
Ouerr=S;
A1=[ones(size(Input)) log(Input)];
Y1=(Output-beta)/alpha;
Y2=log(1./Y1-1);
para=A1\Y2;
n=para(2)
K=exp(-para(1)/n)

Ipre=10.^([0:0.1:5]);
Opre=beta+alpha./(1+(Ipre/K).^n);
figure;
ax=axes;
errorbar(Input,Output,Ouerr,Ouerr,Inerr,Inerr,'MarkerSize',7, 'MarkerEdgeColor',[0 0 0]/225,'Marker','o','LineStyle','none','LineWidth',0.7,'Color',[0 0 0]);
set(ax,'FontSize',15,'XLim',[1 100000],'YLim',[1 100000],'XScale','log','YScale','log','XTick',[1 10^3 10^5],'YTick',[1 10^3 10^5]);
hold on
plot(Ipre,Opre,'Marker','none','LineStyle','-','LineWidth',0.7,'Color',[65 105 225]/225);
xlabel('Input:Ptac (a.u.)');
ylabel('Output:Pt5 (a.u.)');
save A11K2para alpha beta K n %需要修改
