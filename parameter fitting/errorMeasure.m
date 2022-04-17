function squaredError = errorMeasure(beta,data)
alpha=9143;

Input = data(:,1);
Output = data(:,2);
A1=[ones(size(Input)) log(Input)];
Y1=(Output-beta)/alpha;
Y2=log(1./Y1-1);
lamda=A1\Y2;
n=lamda(2);
K=exp(-lamda(1)/n);

Outpre=beta+alpha./(1+(Input/K).^n);
squaredError = sum(((Output-Outpre)./Output).^2);
% squaredError = sum((Output-Outpre).^2);