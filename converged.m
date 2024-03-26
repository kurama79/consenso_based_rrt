% converged.m
% Sequential convex optimization application.
% For solving a single agent planning.
% Inteligent Transportation Systems | Intel Labs.
% Written by Leo Campos-Macias, 2015-09.

%% Description
% This function calculates the convergence of the position

function [value] = converged(position,pf)

  
%% Cheking the final condition..
    temp=position(:,end) - pf;
    if(norm(temp)>0.1)
        value = 0;
        return
    end
    value = 1;
end
