function [delta_x] = UpdateDeltaXMinus(C_B2I_estimate,DynamicNavStateParameter.f_b,F_aug,ScenarioParameter,delta_x,GM)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
%Calculate F_aug
F_aug = CalculateF(C_B2I_estimate,DynamicNavStateParameter.f_b);
%   Transformation matrix
Phi = CalculatePhi(F_aug,ScenarioParameter);

delta_x = Phi*delta_x;
end

