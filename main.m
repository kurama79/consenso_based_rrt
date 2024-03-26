clear; clc;
%tic
%% Initiliazing...
MapSize =[0,10.0;0,10.0;0,10;];
radius=[0.01, 0.05];
[Obs]=generate_CylindricalObstacles(radius,MapSize,30);
[start, goal]=generateRandomMission(Obs,MapSize);
start = [0;0;0];
goal=[10.0;10.0;10.0];
%% Solving RRT*
Created_Nodes=[];
PathDistance=inf;
extParameter=0.01;
[ListofSol, Created_Nodes]=RRT_Star__Imp(Obs, MapSize,start,goal,PathDistance,0,extParameter, Created_Nodes);
plotEverithing(ListofSol,start,goal,[1 0 0],Obs);

%% Creating waypoint list
[way_pointsList] = createWayPoints(ListofSol);


amax = [5;5;5];
%% Initial Conditions
v0 = [0;0;0];
vf = [0;0;0];
a0 = [0;0;0];
af = [0;0;0];
count = 0;
figure(2)
while(size(way_pointsList,2) > 200)
way_pointsList = way_pointsList(:,1:200);
%% Calculating the time ..
h = sqrt( (4 * extParameter) / (amax(1) ) );
K = size(way_pointsList, 2);
T = K*h;
%% Solving QP
[solved,pos_f,vel_f,acc_f,jerk_f] = solveSingleAgent(v0,a0,vf,af,way_pointsList,K, h, extParameter, amax,T);
subplot(3,1,1)
hold on;
plot( (count*150):1:size(acc_f,2)-1+(count*150), acc_f(1,:));
hold on;
subplot(3,1,2)       
plot((count*150):1:size(acc_f,2)-1+(count*150),acc_f(2,:));
hold on;
subplot(3,1,3)
hold on;
plot((count*150):1:size(acc_f,2)-1+(count*150),acc_f(3,:));
[ListofSol, Created_Nodes]=RRT_Star__Imp(Obs, MapSize,pos_f(:,150),goal,PathDistance,0,extParameter, Created_Nodes);
% plotEverithing(ListofSol,pos_f,goal,[1 0 0],Obs);
%% Creating waypoint list
[way_pointsList] = createWayPoints(ListofSol);
v0 = vel_f(:,150);
a0 = acc_f(:,150);
count = count + 1;
end
