%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function for collision checking
function [collFree] = areTwoPoints_CollisionFree(Obs,p1_xyz,p2_xyz)
%#######To implement the distance d!
xVirtual=linspace(p1_xyz(1),p2_xyz(1),30);
yVirtual=linspace(p1_xyz(2),p2_xyz(2),30);
zVirtual=linspace(p1_xyz(3),p2_xyz(3),30);
for k=1:size(xVirtual,2)
    collFree = isCollisionFree(Obs,[xVirtual(k);yVirtual(k);zVirtual(k)]);
    if(~collFree)
        return;
    end
end
end
