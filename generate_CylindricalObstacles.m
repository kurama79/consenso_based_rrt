function [Obs]=generate_CylindricalObstacles(radius,MapSize,numberOfObstacles)
    for i=1:numberOfObstacles
        %%Max then Min
        x = (MapSize(1,1) - MapSize(1,2))*rand(1) + MapSize(1,2);
        y = (MapSize(2,1) - MapSize(2,2))*rand(1) + MapSize(2,2);
        r = (radius(1) - radius(2))*rand(1) + radius(2);
        vXfp2 = [x; y; MapSize(3,1)];
        vXfP1 = [x; y; MapSize(3,2)];
        distance = vXfp2 - vXfP1;
        Obs(i).r = r*r;
        Obs(i).v_XfAxisCyl = distance;
        Obs(i).distance = norm(distance)*norm(distance);
        Obs(i).vXfP1 = vXfP1;
%    m_sObstacleCylHandler.dRadius_sqr = dRadius*dRadius;
% 	m_sObstacleCylHandler.v_XfAxisCyl = vXfp2 - vXfP1;
% 	m_sObstacleCylHandler.dDistance_sqr = m_sObstacleCylHandler.v_XfAxisCyl.norm()*m_sObstacleCylHandler.v_XfAxisCyl.norm();
% 	m_sObstacleCylHandler.v_Xfp1 = vXfP1;        
%        Obs(i).r = (i,:) = [r*r, distance, norm(distance)*norm(distance), v_Xfp1];
    end
end