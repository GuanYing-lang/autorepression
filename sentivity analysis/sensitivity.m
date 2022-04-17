%% an example of sensitivity analysis to parameter K, to analysis other specific parameter, please remove the annotation (%) in 'generate data' process for the specific parameter, and fix the other parameters by annotation (%).
clear all

%% generate data
for j=1:1:10
k=-7:0.2:-2;
Cumateq=10.^k;
data0=rand(5,7);
K=data0(:,1)*(100-50)+50; 
% n=data0(:,2)*(4-1)+1;
% Kr=data0(:,3)*(193-100)+100; %% note that Kr ranges satisfy burden-free constraint
% nr=data0(:,4)*(4-1)+1;
% Rtt=data0(:,5)*(3000-1000)+1000;
% alpha=data0(:,6)*(10000-800)+8000;
% Krcc=data0(:,7)*(25-5)+5;

%% fix the other parameters
% K=77*ones(5,1); 
n=3*ones(5,1);
Kr=109*ones(5,1);
nr=2*ones(5,1);

Rtt=2005*ones(5,1);
alpha=9143*ones(5,1);
Krcc=13*ones(5,1);
data1=[K,n,Kr,nr,Rtt,alpha,Krcc];
for tt=1:5
    K=data1(tt,1);
    m=data1(tt,2);
    Kr=data1(tt,3);
    nr=data1(tt,4);
Rtt=data1(tt,5);
alpha=data1(tt,6);
Krcc=data1(tt,7);
p=1;
for k=-1:0.2:4
    Cumatep=10^k;
    xp=fsolve(@(x) (Rtt*(1+Cumatep/Krcc)^nr/((1+Cumatep/Krcc)^nr+(x/Kr)^nr)-x),100);
    Rfp(p)=xp;

    Gp(tt,p)=alpha*(1+Cumatep/Krcc)^m/((1+Cumatep/Krcc)^m+(Rfp(p)/K)^m)+20;
    p=p+1;
end
end

% calculate dynamic range (DR), slope, and input range(lin)
DR=Gp(:,26)./Gp(:,1);
Yhalf=sqrt(Gp(:,26).*Gp(:,1));
for i=1:5
[M(i), I(i)]=min(abs(Yhalf(i)-Gp(i,:)));
end
slope=ones(5,1);
 for i=1:5
if I(i)==1
slope(i)=0;
else if I(i)==26
slope(i)=0;
else
slope(i)=(Gp(i,I(i)+1)-Gp(i,I(i)-1))/(Cumateq(I(i)+1)-Cumateq(I(i)-1))/1e6;
end
end
 end

Yonetenth=exp(log(Gp(:,1))+0.1*(log(Gp(:,26))-log(Gp(:,1))));
Yninetenth=exp(log(Gp(:,1))+0.9*(log(Gp(:,26))-log(Gp(:,1))));
for i=1:5
[Myone(i), Iyone(i)]=min(abs(Yonetenth(i)-Gp(i,:)));
end
for i=1:5
[Mynine(i), Iynine(i)]=min(abs(Yninetenth(i)-Gp(i,:)));
end
for i=1:5
lin(i)=Cumateq(Iynine(i))/Cumateq(Iyone(i));
end
jj=1;%%
sendr(j)=std(DR)/mean(DR)/(std(data1(:,jj))/std(data1(:,jj)))
senslo(j)=std(slope)/mean(slope)/(std(data1(:,jj))/std(data1(:,jj)))
senlin(j)=std(lin)/mean(lin)/(std(data1(:,jj))/std(data1(:,jj)))
end
sendrend=mean(sendr);
sendrvar=std(sendr);
sensloend=mean(senslo);
senslovar=std(senslo);
senlinend=mean(senlin);
senlinvar=std(senlin);

%% sensitivity result
result=[sendrend, sensloend,senlinend;sendrvar,senslovar,senlinvar];
