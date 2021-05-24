function [sum_locationError] = locationErrorFunc(b_a,b_g,g,time)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

locationError = (1.0/2.0)*b_a*time.^2+(1.0/6.0)*g*b_g*time.^3;
sum_locationError = sum(locationError);

end

