function ListofSol=CreateSolution(rrt_Structure)

ListofSol = rrt_Structure(end);
parentID = rrt_Structure(end).parent_id;

while parentID~=0
    ListofSol(end+1)=rrt_Structure(parentID);
    parentID=rrt_Structure(parentID).parent_id;
end
ListofSol=flipud(ListofSol);
end
% ListofSol(end+1,:)=rrt_Structure(1,:);