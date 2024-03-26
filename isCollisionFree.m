%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function for collision checking
function [collFree] = isCollisionFree(Obs,xyz)
for i =1:size(Obs,2)
    vXf_pd = xyz - Obs(i).vXfP1;
    d_dot = dot(vXf_pd, Obs(i).v_XfAxisCyl);
    if (d_dot < 0 || d_dot > Obs(i).distance)
        continue;
    else
        if ( (dot(vXf_pd,vXf_pd) - (d_dot * d_dot)/Obs(i).distance) < Obs(i).r)
            collFree = false;
            return;
        end
    end
end
collFree = true;
end