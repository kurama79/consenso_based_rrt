%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function for finding closest vertex in tree
function [closest_vert] = closestVertex(rrt_verts,xyz)
% Find distances from points in rrt_verts to xy
for i = 1:size(rrt_verts,2)
diffs(:,i) = rrt_verts(i).coordinates - xyz;
end
dists = sqrt(diffs(1,:).^2 + diffs(2,:).^2 + diffs(3,:).^2);
% Find closest vertex
[~,minind] = min(dists);

closest_vert = rrt_verts(minind);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%