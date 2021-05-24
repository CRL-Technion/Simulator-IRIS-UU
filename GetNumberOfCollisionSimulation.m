function [NumberOfCollision] = GetNumberOfCollisionSimulation(EdgeFile)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
edgedata = importdata(EdgeFile);
try
NumberOfCollision = length(edgedata(:,4))-sum(edgedata(:,4));
catch
    NumberOfCollision =0;
end
end

