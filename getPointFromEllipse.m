function xyz=getPointFromEllipse(x_start,x_goal,c_max,world_bounds)
  while 1
    c_min=norm(x_goal-x_start);
    x_centre=(x_start+x_goal)/2;
    
    roll = atan2(x_goal(2)-x_start(2),x_goal(3)-x_start(3));
    pitch = atan2(x_goal(3)-x_start(3),x_goal(1)-x_start(1));
    yaw = atan2(x_goal(1)-x_start(1),x_goal(2)-x_start(2));
    
% %     C=[cos(pitch)*cos(yaw)      cos(roll)*sin(yaw)+sin(pitch)*cos(yaw)*sin(roll)    sin(roll)*sin(yaw)-cos(roll)*sin(pitch)*cos(yaw);...
% %         -cos(pitch)*sin(yaw)    cos(roll)*cos(yaw)-sin(pitch)*sin(roll)*sin(yaw)    cos(yaw)*sin(roll)+cos(roll)*sin(pitch)*sin(yaw);...
% %         sin(pitch)              -cos(pitch)*sin(roll)                               cos(pitch)*cos(roll);];
    
        R_z=[cos(yaw)       -sin(yaw)        0;...
            sin(yaw)       cos(yaw)        0;...
            0               0               1;];
        R_x=[1              0               0;...
            0               cos(roll)       -sin(roll);...
            0               sin(roll)      cos(roll);];
        R_y=[cos(pitch)     0               sin(pitch);...
            0               1               0;...
            -sin(pitch)     0               cos(pitch);];
    C=R_z*R_y*R_x;
    
    r_1=c_max/2;
    r_2=sqrt(c_max^2-c_min^2)/2;
    r_3=sqrt(c_max^2-c_min^2)/2;
    
    L=diag([r_1;r_2;r_3]);
   
    theta=2*pi*rand(1);
    phi=pi*rand(1);
    rho=rand(1);
    x_ball=[rho*cos(theta)*sin(phi);rho*sin(theta)*sin(phi);rho*cos(phi);];
    
    xyz=C*L*x_ball+x_centre;
    
    %%% For debuging pruporses
%      [x, y, z] = ellipsoid(0,0,0,r_1,r_2,r_3);
%      p = [x(:),y(:),z(:)]; % Rows of p are points' vectors
%      q = p*C; % This rotates all the points
%      xr = q(:,1)+x_centre(1); yr = q(:,2)+x_centre(2); zr = q(:,3)+x_centre(3); % Separate the coordinates
%      xr = reshape(xr,size(x)); % Restore to original array sizes
%      yr = reshape(yr,size(y));
%      zr = reshape(zr,size(z));
%      figure(1)
% %      surf(x, y, z)
% %      hold on;
%     s =surf(xr, yr, zr);
%      hold on;
%     alpha(s,0.1);

    if(((norm(x_start-xyz)+norm(xyz-x_goal))<=c_max)&&(world_bounds(1,1)>xyz(1) && world_bounds(1,2)<xyz(1) && world_bounds(2,1)>xyz(2) && world_bounds(2,2)< xyz(2) && world_bounds(3,1)>xyz(3) && world_bounds(3,2)<xyz(3)))
        break;
    end
    
  end 
end