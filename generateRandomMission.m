function [start, goal]=generateRandomMission_consideringAgents(Obs, MapSize, otherAgents)

xyz = (MapSize(:,1) - MapSize(:,2)).*rand(3,1) + MapSize(:,2);

while (~isCollisionFree(Obs,xyz))
    xyz = (MapSize(:,1) - MapSize(:,2)).*rand(3,1) + MapSize(:,2);
end
start = xyz;
xyz = (MapSize(:,1) - MapSize(:,2)).*rand(3,1) + MapSize(:,2);
while (~isCollisionFree(Obs,xyz))
    xyz = (MapSize(:,1) - MapSize(:,2)).*rand(3,1) + MapSize(:,2);
end
goal =xyz;

end