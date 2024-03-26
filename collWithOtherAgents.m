function collFree=collWithOtherAgents(xyz, xyparent,Agents, myIndex, virualK)
for i=1:size(Agents(myIndex).ObsStruct,2)
    
    xVirtual=linspace(xyz(1), xyparent.coordinates(1),virualK);
    yVirtual=linspace(xyz(2), xyparent.coordinates(2),virualK);
    
    if( xyparent.K_timesOfL == 0)
        index = 0;
    else
        index = xyparent.K_timesOfL - 1;
    end
    
    for kk=1:min( virualK, (size(Agents(myIndex).ObsStruct(i).posPredicted,2) - index ) )
        
        diff=[Agents(myIndex).ObsStruct(i).posPredicted(1,index+kk); Agents(myIndex).ObsStruct(i).posPredicted(2,index+kk)]-[xVirtual(kk);yVirtual(kk)];
        if( norm(diff) <= (Agents(myIndex).minBall + Agents(myIndex).ObsStruct(i).minBall) )
            collFree=false;
            return;
        end
    end
end
collFree=true;
end