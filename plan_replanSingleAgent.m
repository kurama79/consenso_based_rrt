function [pos_f,vel_f,acc_f,jerk_f, h, K, ListofSol]=plan_replanSingleAgent(v0,a0,vf,af, Obs, MapSize,start,goal, extParameter, otherAgents )

%% Solving RRT*
Created_Nodes=[];
PathDistance=inf;
[ListofSol, Created_Nodes]=RRT_Star__Imp(Obs, MapSize,start,goal,PathDistance,0,extParameter, Created_Nodes);

%% Creating waypoint list
[way_pointsList] = createWayPoints(ListofSol);

%% Calculating the time ..
amax = [5;5;5];
h = sqrt( (4 * extParameter) / (amax(1) ) );
K = size(way_pointsList, 2);
T = K*h;

%% Solving QP
[pos_f,vel_f,acc_f,jerk_f] = solveSingleAgent(v0,a0,vf,af,way_pointsList,K, h, extParameter, amax);
end