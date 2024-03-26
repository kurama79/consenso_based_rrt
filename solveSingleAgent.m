% solveSingleAgent.m
% Sequential convex optimization application.
% For solving a single agent planning.
% Inteligent Transportation Systems | Intel Labs.
% Written by Leo Campos-Macias, 2015-09.

%% Description
% This function solve the planning for a single agent in nD based on Sequential Convex Programming

function [solved,pos_f,vel_f,acc_f,jerk_f]=solveSingleAgent(v0,a0,vf,af, ListofSol, K, h, extensionParameter, amax,T)
%% Kinematic Constrains
%  **** This is eqn (3) of the Paper and other necesary parameters
%  p0-> is the initial position, v0-> is the initial velocity, a0-> is the initial acceleration
%  pf-> is the final position, vf-> is the final velocity, af-> is the final acceleration
%  Dimen-> number of dimensions
Dimen=3;

p0=ListofSol(:,1);
pf=ListofSol(:,end);


%% Minimize the problem!!
% The problem is formulated as follow
%    Solve quadratic program of the form
% 		min_x 1/2*x'*Q*x + c'*x
%       s.t. A*x <= b
%   	Aeq*x = beq
%       lb <= x <= ub
%       param x Reference to optimal solution

%% First the Matrix Aeq and beq are obtained of the form

for i=1:1:Dimen
    
    Aeq_temp=zeros(4,K);
    beq_temp=zeros(4,1);
    
    %The initial position and initial velocities are implicit.
    %Initial Acc
    Aeq_temp(1,1)=1;
    beq_temp(1)=a0(i);
    
    %Final position
    for j=1:1:K-1
        Aeq_temp(2,j)= h^2/2*(2*K-(2*j+1));
    end
    beq_temp(2)=pf(i)-p0(i)-h*(K-1)*v0(i);
    
    %Final Velocity
    Aeq_temp(3,:)= h*ones(1,K);
    Aeq_temp(3,end)=0;
    beq_temp(3)=vf(i)-v0(i);
    
    %Final Acceleration
    Aeq_temp(4,end)=1;
    beq_temp(4)=af(i);
    
    if i>1
        Aeq=blkdiag(Aeq,Aeq_temp);
    else
        Aeq=Aeq_temp;
    end
    
    if i>1
        beq=cat(1,beq,beq_temp);
    else
        beq=beq_temp;
    end
end


%% Second the matrices A and b are formed
Aposition = [];
bposition = [];
for i=1:1:Dimen
%     K=10;
%     h=1;
    
    A_pos=zeros(K,K);
    b_pos=zeros(1,K);
    b_pos_max=zeros(1,K);
    b_pos_min=zeros(1,K);
    
    for k=2:K-1
        for j=1:k-1
            A_pos(k,j) = (2*k-(2*j+1));
        end
        b_pos(k) = -h * (k-1) * v0(i);
        b_pos_max(k) = b_pos(k) + (ListofSol(i,k) + extensionParameter) - p0(i);
        b_pos_min(k) = b_pos(k) + (ListofSol(i,k) - extensionParameter) - p0(i);        
    end
    A_pos = A_pos*h^2/2;
    Apos = [A_pos; -A_pos];
    bpos = [transpose(b_pos_max); -transpose(b_pos_min)];
    
    Aposition = blkdiag(Aposition,Apos);
    bposition = [bposition; bpos];
    
end

A = [];
b = [];

for i=1:1:Dimen
    
    % Set the size of the inequality constraints
    A_accel = eye(K, K);
    b_accel_max = amax(i)*ones(K, 1);
    b_accel_min = -amax(i)*ones(K, 1);
    
    Atemp = [A_accel; -A_accel];
    btemp = [b_accel_max; -b_accel_min];
    
    A = blkdiag(A,Atemp);
    b = [b;btemp];
    
end
A=[Aposition;A];
b=[bposition;b];

%% Third the matrices Q and c are formed
Aj = [];

for i=1:1:Dimen
    
    % Set the size of the inequality constraints
    A_jerk = (eye(K, K) - diag(ones((K-1),1),1));
    A_jerk(1,1)=0;
    A_jerk=1/h*transpose(A_jerk)*A_jerk;
    
    Aj = blkdiag(Aj,A_jerk);
    
    
end
 
f = zeros(Dimen*K,1);
%  Aj=eye(Dimen*K,Dimen*K);

%% Solving the QP with MatLab Package
x=quadprog(2*Aj,f,A,b,Aeq,beq,[],[],[],[]);

%% Propagate the states...

[pos_f,vel_f,acc_f,jerk_f] = propagateStates(p0,v0,x,K,Dimen,h);

if converged(pos_f,pf)
%                    plotRes(p0,pf,pos_f);
    solved=1;
%    plotTrajectories(pos_f,vel_f,acc_f,jerk_f,T,h);
%     fprintf('converged in step %d\n',i);
%                   return;
end
%    end
end

