function plotEverithing(rrt_Structure,xy_start,xy_goal,color,Obs)

% Draw obstacles
figure(1); hold on; clf;
h1 = axes;
set(h1, 'Xdir', 'reverse');

axis equal;

for i = 1:size(Obs,2)
   [X, Y, Z] = cylinder(sqrt(Obs(i).r));
    Z = Z * 10;
    X = X + Obs(i).vXfP1(1);
    Y = Y + Obs(i).vXfP1(2);
    surf(X,Y,Z)
    hold on;
end
 grid on;
    hold on;
    plot3(xy_start(1),xy_start(2),xy_start(3),'bo','MarkerFaceColor','b','MarkerSize',10);
    hold on;
    plot3(xy_goal(1),xy_goal(2),xy_goal(3),'go','MarkerFaceColor','g','MarkerSize',10);
    hold on;
    
    for i=2:size(rrt_Structure,2)
         figure(1)
         hold on;
         plot3(rrt_Structure(i).coordinates(1),rrt_Structure(i).coordinates(2),rrt_Structure(i).coordinates(3),'ko','MarkerFaceColor',color,'MarkerSize',5);
         hold on;
         line([rrt_Structure(i-1).coordinates(1),rrt_Structure(i).coordinates(1)],[rrt_Structure(i-1).coordinates(2),rrt_Structure(i).coordinates(2)],[rrt_Structure(i-1).coordinates(3),rrt_Structure(i).coordinates(3)]);
         hold on;
    end
%  plot(ListofSol(:,1),ListofSol(:,2),'ko','MarkerFaceColor','k','MarkerSize',5);
end