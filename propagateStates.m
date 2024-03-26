% propagateStates.m
% Sequential convex optimization application.
% For solving a single agent planning.
% Inteligent Transportation Systems | Intel Labs.
% Written by Leo Campos-Macias, 2015-09.

%% Description
% This function propagates the states of the plant

function [pos_f,vel_f,acc_f,jerk_f,snap_f] = propagateStates(p0,v0,optimization,K,Dimen,h)
    
    acc_f=vec2mat(optimization,K);
    jerk_f(Dimen,K)=0;
    snap_f(Dimen,K)=0;
    vel_f(Dimen,K)=0;
    vel_f(:,1)=transpose(v0);
    pos_f(Dimen,K)=0;
    pos_f(:,1)=transpose(p0);
    
    for i=2:1:K
        jerk_f(:,i)=(acc_f(:,i)-acc_f(:,i-1))/h;
        snap_f(:,i)=(jerk_f(:,i)-jerk_f(:,i-1))/h;
        vel_f(:,i)=vel_f(:,i - 1) + h * acc_f(:,i - 1);
        pos_f(:,i)= pos_f(:,i - 1) + h * vel_f(:,i - 1) + h * h / 2.0 * acc_f(:,i - 1);
    end
end
