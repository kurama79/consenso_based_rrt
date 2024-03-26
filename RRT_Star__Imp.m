%% Code setup (Do not modify, but please read) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Obstacles. Each obstacle is a cell in Obs. An obstacle is
% represented as a convex hull of a number of points. These points are
% stored in the cells of Obs.
% First row is x, second is y (position of vertices)

function [ListofSol, Created_Nodes]=RRT_Star__Imp(Obs, MapSize,start,goal,PathDistance,numerofIt,extParameter, Created_Nodes)

numberOfPoints = size(Created_Nodes,2) + 1;
% Structure of RRTStar RRT( XCoordinate, YCoordinate, IDParent, ID,...
%                           Total Distance, timesofDistance(K))
Created_Nodes(numberOfPoints).coordinates = start;
Created_Nodes(numberOfPoints).parent_id = 0;
Created_Nodes(numberOfPoints).my_id = 1;
Created_Nodes(numberOfPoints).carried_distance = 0;
Created_Nodes(numberOfPoints).K_timesOfL = 0;

nearGoal = false; % This will be set to true if goal has been reached

minDistGoal = 0.1; % This is the convergence criterion. We will declare
% success when the tree reaches within 0.25 in distance
% from the goal. DO NOT MODIFY.
%% RRT_Star algorithm
while ~nearGoal
    % Generate Radius
    if PathDistance==inf
        circleRadius=getRadius(3,norm(goal-start),numberOfPoints); %Radius to check the intersection nodes
    else
        circleRadius=getRadius(3,PathDistance,numberOfPoints); %Radius to check the intersection nodes
    end
    % Sample point
    rnd = rand(1);
    % With probability 0.05, sample the goal. This promotes movement to the
    % goal.
    if rnd < 0.05
        xyz = goal;
    else
        if PathDistance==inf
            % Sample from space with probability 0.95
            xyz = (MapSize(:,1) - MapSize(:,2)).*rand(3,1) + MapSize(:,2);
        else
            xyz=getPointFromEllipse(start,goal,PathDistance, MapSize);
        end
    end
    
    %% Find the closest point due a given radius
    listOfPoints = findNodesInCircle(xyz,Created_Nodes,circleRadius);
    minDistance = inf;
    minId = 0;
    
    if(size(listOfPoints,2)~=0)
        for i=1:size(listOfPoints,2)
            %% Check if there exist intersection
            collFree = areTwoPoints_CollisionFree(Obs,xyz,listOfPoints(i).coordinates);
            %  distance=norm(xyz-transpose(listOfPoints(i,1:3)))+rrt_Structure(listOfPoints(i,5),6);
            distance=norm(xyz-listOfPoints(i).coordinates)+listOfPoints(i).carried_distance;
            %           collAgent=collWithOtherAgents(xyz,listOfPoints(i,:),rr_Agent,count,R,ceil(distance/d));
            %             plotSingleNode(xyz,listOfPoints(i,1:3),colors);
            % If it's  collision free, continue with loop
            if (collFree)
                %% Look for the minDistance
                if(distance < minDistance)
                    minDistance = distance;
                    minId = i;
                end
            end
        end
        if minId
            numberOfPoints=numberOfPoints+1;
            
            Created_Nodes(numberOfPoints).coordinates = xyz;
            Created_Nodes(numberOfPoints).parent_id = listOfPoints(minId).my_id;
            Created_Nodes(numberOfPoints).my_id = numberOfPoints;
            Created_Nodes(numberOfPoints).carried_distance = minDistance;
            %Heuristic...
            Created_Nodes(numberOfPoints).K_timesOfL = ceil( (minDistance - listOfPoints(minId).carried_distance) / extParameter);
            %% Check for other points to be redirected
            for i=1:size(listOfPoints,2)
                collFree = areTwoPoints_CollisionFree(Obs,xyz,listOfPoints(i).coordinates);
                %  collAgent=collWithOtherAgents(listOfPoints(i,1:3),rrt_Structure(numberOfPoints,:),rr_Agent,count,R,ceil((norm(xyz-transpose(listOfPoints(i,1:3)))+rrt_Structure(numberOfPoints,6))/d));
                %                 plotSingleNode(xyz,listOfPoints(i,1:3),colors);
                if (collFree)
                    if (norm(xyz-listOfPoints(i).coordinates)+ Created_Nodes(numberOfPoints).carried_distance < Created_Nodes(listOfPoints(i).my_id).carried_distance)
                        
                        Created_Nodes(listOfPoints(i).my_id).parent_id = numberOfPoints;
                        Created_Nodes(listOfPoints(i).my_id).carried_distance = norm(xyz-listOfPoints(i).coordinates)+ Created_Nodes(numberOfPoints).carried_distance;
                        %new Heuristic...
                        Created_Nodes(listOfPoints(i).my_id).K_timesOfL = ceil( (norm(xyz - listOfPoints(i).coordinates)) / extParameter);
                    end
                end
            end
        end
    else
        %% Normal RRT
        closest_vert = closestVertex(Created_Nodes,xyz); % Write this function
        
        collFree = areTwoPoints_CollisionFree(Obs,xyz,closest_vert.coordinates);
        % collAgent=collWithOtherAgents(xyz,closest_vert,rr_Agent,count,R,ceil((closest_vert(6)+norm(xyz-transpose(closest_vert(1:3))))/d));
        %         plotSingleNode(xyz,closest_vert(1:3),colors);
        if (collFree)
            numberOfPoints=numberOfPoints+1;
            Created_Nodes(numberOfPoints).coordinates = xyz;
            Created_Nodes(numberOfPoints).parent_id = closest_vert.my_id;
            Created_Nodes(numberOfPoints).my_id = numberOfPoints;
            Created_Nodes(numberOfPoints).carried_distance = closest_vert.carried_distance + norm(xyz-closest_vert.coordinates);
            %Heuristic...
            Created_Nodes(numberOfPoints).K_timesOfL = ceil( norm(xyz-closest_vert.coordinates) / extParameter);
        end
    end
    if ~collFree
        continue;
    end
    
    % Check if we have reached goal
    if norm(goal-xyz) < minDistGoal
        goal=xyz;
        ListofSol=CreateSolution(Created_Nodes);
        return;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end



end







