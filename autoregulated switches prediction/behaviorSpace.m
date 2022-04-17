%% input data
clear all
load behaspacecopy2
clear Gp DR lin slope

k=-7:0.05:-2;
Cumateq=10.^k;
% data0=rand(10000,4);
% K=data0(:,1)*(300-20)+20;
% m=data0(:,2)*(6-1)+1;
% Kr=data0(:,3)*(300-20)+20;
% nr=data0(:,4)*(6-1)+1;
% data=[K,n,Kr,nr];
Rtt=777;
alpha=9143;
Krcc=13;
nb=1;
na=1;

%% predict curve 
for tt=1:144
    K=A21Copy(tt,3);
    m=A21Copy(tt,4);
%     for mm=1:41
    Kr=A21Copy(tt,1);
    nr=A21Copy(tt,2);
p=1;
for k=-1:0.05:4
    Cumatep=10^k;
    Cumatett(p)=Cumatep;
    xp=fsolve(@(x) (Rtt*(1+Cumatep/Krcc)^nr/((1+Cumatep/Krcc)^nr+(x/Kr)^nr)-x),100); 
    Rfp(tt,p)=xp
    Rftrue2(tt,p)=xp/(1+Cumatep/Krcc) 
Rfp(p)=Rtt;
    Gp(tt,p)=alpha*(1+Cumatep/Krcc)^m/((1+Cumatep/Krcc)^m+(xp/K)^m)+20;
    p=p+1;
end
    end
% end
figure(2);
ax=axes;
for pp=1:144
%     plot(Cumatett,Gp(pp,:),'Color',[150,150,150]/255);
    plot(Cumatett,Rftrue(pp,:),'Color',[150,150,150]/255);
    hold on
end
set(ax,'XLim',[0.1 10000],'YLim',[1 20000],'XScale','log','YScale','log');
xlabel('Cumate (\mumol/L)');
% ylabel('Output:Pt5 (a.u.)');
ylabel('Rfree (a.u.)');

figure(3);
ax=axes;
for pp=1:144
    if Rftrue(pp,1)<220
    plot(Cumatett,Gp(pp,:),'Color',[150,150,150]/255);
%     plot(Cumatett,Rftrue(pp,:),'Color',[150,150,150]/255);
    end
%     plot(Rftrue(pp,:));
    hold on
end
set(ax,'XLim',[0.1 10000],'YLim',[1 20000],'XScale','log','YScale','log');
xlabel('Cumate (\mumol/L)');
ylabel('Output:Pt5 (a.u.)');
% ylabel('Rfree (a.u.)');

% save GpNoNAR Gp data1
DR=Gp(:,101)./Gp(:,1);
Yhalf=sqrt(Gp(:,101).*Gp(:,1));
for i=1:144
[M(i), I(i)]=min(abs(Yhalf(i)-Gp(i,:)));
end

 for i=1:144
if I(i)==1
slope(i)=0;
else if I(i)==101
slope(i)=0;
else
slope(i)=(log10(Gp(i,I(i)+1))-log10(Gp(i,I(i)-1)))/(log10(Cumateq(I(i)+1))-log10(Cumateq(I(i)-1)));
end
end
end
