% initial_pos.m
% Generation of initial positions.
% Centro de Investigacion y de Estudios Avanzados del IPN.
% By L. Enrique Ruiz-Fernández, 2020-04.

function [x,y,starts] = initial_pos(n,obs,area)
starts = [];
for i=1:n
    h = 1;
    while h
        x(i) = rand(1)*area(1,2);
        y(i) = rand(1)*area(2,2);
        for j=1:length(obs)
            if dist([x(i) y(i)],obs(j).coord)>obs(j).r
                h = 0;
            else
                h = 1;
                break
            end
        end
    end
    starts = [starts;x(i) y(i) 0];
end
end