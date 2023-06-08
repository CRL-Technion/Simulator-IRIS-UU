function [Delta_z] = GetDeltaZ_2(H,NavState,State)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
Delta_z = H*[NavState.X-(State.X+rand_mu_sigma(0,3,3,1)*NavState.SigmaPosInit);...
            NavState.X_dot-(State.X_dot+rand_mu_sigma(0,3,3,1)*NavState.SigmaVelInit);...
            zeros(9,1)]; %   Position measurement error
end