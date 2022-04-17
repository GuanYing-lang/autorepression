% Input A16K5
load n15;load n17;load n20;load A11K8;
 figure(1);
ax=axes;
plot(Iptg1,Plate_17(9,:),'MarkerSize',10,'Marker','o','LineWidth',0.7);
hold on
plot(Iptg1,Plate_17(10,:),'MarkerSize',10,'Marker','o','LineWidth',0.7);
% plot(Iptg1,Plate_17(7,:),'MarkerSize',10,'Marker','o','LineWidth',0.7);
% plot(Iptg1,Plate_17(8,:),'MarkerSize',10,'Marker','o','LineWidth',0.7);
set(ax,'XLim',[0.1 10000],'YLim',[1 100000],'XScale','log','YScale','log');
xlabel('IPTG (\mumol/L)');
ylabel('Output:Pt5 (a.u.)');
legend;
% choose "three samples in different days" and plot
clear M
clear S
clear AA
clear A
Iptg=10e-6*Iptg1;
A(1,:)=Plate_17(9,:);
A(2,:)=Plate_17(10,:);
% A(3,:)=Plate_17(7,:);
for i=1:1:12
    AA=A(:,i);
    M(i)=mean(AA(AA~=0));
    S(i)=std(AA(AA~=0));
end
 figure(2);
ax=axes;
errorbar(Iptg,M,S,'MarkerSize',6, 'MarkerEdgeColor',[0 0.447058826684952 0.74117648601532],'Marker','o','LineStyle','none','LineWidth',0.7,'Color',[0 0 0]);
set(ax,'XLim',10e-6*[1 10000],'YLim',[1 100000],'XScale','log','XTick',[1e-05 0.001 0.1],'YScale','log');
xlabel('IPTG (mol/L)');
ylabel('Output:Pt5 (a.u.)');
save A16K5 Iptg M S Iptg1 Iptg2
%% plot
Input=[18.9265097101903,19.9070969648565,21.0191050272422,22.4247303562945,25.1206836168041,32.5321529245381,41.4289545786197,51.6052680626896,93.3407426197805,125.514745273625,187.616682644079,281.095175993206];
Output=[5212.08507200000,4640.19122650000,3029.13555700000,1973.95915900000,608.808128500000,96.3477438900000,54.2613206000000,41.7169834700000,28.9131430100000,26.6720552100000,25.0424291550000,27.7797803200000];
figure(3);
ax=axes;
plot(Input,Output,'MarkerSize',6, 'MarkerEdgeColor',[0 0.447058826684952 0.74117648601532],'Marker','o','LineStyle','none','LineWidth',0.7);
set(ax,'XLim',[1 10000],'YLim',[1 100000],'XScale','log','YScale','log');
xlabel('IPTG (mol/L)');
ylabel('Output:Pt5 (a.u.)');
% n=5;
% K_tune(:,n)=M;
% K_tune_var(:,n)=S;
n=4;
n_tune(:,n)=M;
n_tune_var(:,n)=S;

