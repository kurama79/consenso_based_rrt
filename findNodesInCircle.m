function listOfPoints = findNodesInCircle(xyz,rrt_Structure,circleRadius)
count = 0;
listOfPoints=[];
for i=1:size(rrt_Structure,2)
    if(norm(xyz - rrt_Structure(i).coordinates)< circleRadius )
        count=count+1;
        listOfPoints(count).coordinates = rrt_Structure(i).coordinates;
        listOfPoints(count).parent_id = rrt_Structure(i).parent_id;
        listOfPoints(count).my_id = rrt_Structure(i).my_id;
        listOfPoints(count).carried_distance = rrt_Structure(i).carried_distance;
        listOfPoints(count).K_timesOfL = rrt_Structure(i).K_timesOfL;
    end
end
