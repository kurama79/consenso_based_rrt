function [way_pointsList] = createWayPoints(ListofSol)

way_pointsList = ListofSol(end).coordinates;

for i=size(ListofSol,2):-1:2
    auxiluar=[];
    auxiluar(1,:) = linspace(ListofSol(i).coordinates(1),ListofSol(i-1).coordinates(1),ListofSol(i-1).K_timesOfL);
    auxiluar(2,:) = linspace(ListofSol(i).coordinates(2),ListofSol(i-1).coordinates(2),ListofSol(i-1).K_timesOfL);
    auxiluar(3,:) = linspace(ListofSol(i).coordinates(3),ListofSol(i-1).coordinates(3),ListofSol(i-1).K_timesOfL);
    way_pointsList = [way_pointsList , auxiluar];
end
 way_pointsList =  [way_pointsList , ListofSol(1).coordinates];
end