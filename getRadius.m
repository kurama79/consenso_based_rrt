function r = getRadius(d,maxDistance,n)
%% Get the dimension of the state space d, maxDistance in the tree, n number of nodes



%% Calculating the Lebesgue measure of the obstacle-free space
X_free = (maxDistance)^d;

%% Calculating the unit ball in the d-dimensional Euclidean space

Vn= ((pi)^d)/(gamma((d/2+1)));

minimumFactor = 2.5*((1+1/d)*(X_free/Vn))^(1/d);
if n>1
    r= minimumFactor*(log(n)/n)^(1/d);
else
   r=minimumFactor; 
end
end