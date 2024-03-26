% final_pos.m
% Generate the goals.
% Centro de Investigacion y de Estudios Avanzados del IPN.
% By L. Enrique Ruiz-Fernández, 2020-04.

%% Description 
% This function generates the any agent final position, depends of the shape of the formation 

function g = final_pos_pentagon(x,d)
g(1,1) = ((x(2,1)+d*cos(deg2rad(54)))+(x(5,1)+d*cos(deg2rad(126))))/2; 
g(1,2) = ((x(2,2)+d*sin(deg2rad(54)))+(x(5,2)+d*sin(deg2rad(126))))/2;
g(2,1) = ((x(1,1)+d*cos(deg2rad(216)))+(x(3,1)+d*cos(deg2rad(108))))/2; 
g(2,2) = ((x(1,2)+d*sin(deg2rad(216)))+(x(3,2)+d*sin(deg2rad(108))))/2;
g(3,1) = ((x(2,1)+d*cos(deg2rad(306)))+(x(4,1)+d*cos(deg2rad(180))))/2; 
g(3,2) = ((x(2,2)+d*sin(deg2rad(306)))+(x(4,2)+d*sin(deg2rad(180))))/2;
g(4,1) = ((x(3,1)+d*cos(0))+(x(5,1)+d*cos(deg2rad(234))))/2; 
g(4,2) = ((x(3,2)+d*sin(0))+(x(5,2)+d*sin(deg2rad(234))))/2;
g(5,1) = ((x(4,1)+d*cos(deg2rad(72)))+(x(1,1)+d*cos(deg2rad(324))))/2; 
g(5,2) = ((x(4,2)+d*sin(deg2rad(72)))+(x(1,2)+d*sin(deg2rad(324))))/2;
g(:,3) = zeros(5,1);
end