j = load('deg0.txt');
j = j(:,1);
D = tril(ones(numel(j),numel(j)),-1);

a = D*j;
v = D*D*j;
p = D*D*D*j;
plot(p,'r');hold on
pdeg = load('deg3.txt');

plot(pdeg(:,1))

D3 = D*D*D;