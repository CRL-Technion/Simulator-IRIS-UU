% function Command = checkPOI(State,Environment,Command)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
POIChecked_Validation = zeros(size(Command.POIChecked));
FOV =0;
A = [cos(State.psi)*cos(State.theta),sin(State.psi)*cos(State.theta),-sin(State.theta)]';
for i=1:1:length(Command.Pose_des_GF(:,1))

B = Environment.TargetsBridge(Command.POIUnique,:)-Command.Pose_des_GF(i,1:3);
normB = (vecnorm(B'))';
POIChecked = abs(B*A)./(norm(A).*normB) > FOV;
[aa,bb] = find(POIChecked > POIChecked_Validation);
if (~isempty(aa))
    [cc,dd] = find(normB(aa)<10);
    if (~isempty(cc))
        C = Environment.BridgeObstaclePoint-Command.Pose_des_GF(i,1:3);
        normC = vecnorm(C')';
        [ee,ff] = find(normC<=max(normB(aa(cc))'));
        obstacleCheck = (C(ee,1:3)./normC(ee))*(B(aa(cc),1:3)'./normB(aa(cc))');
        y = Environment.RadiusObstacle; x = normC(ee); 
        FOVObstacle = cos(atan2(y,x));
        [hh,ii] = find(obstacleCheck>FOVObstacle);
        jj = ones(size(unique(ii)))';
        POIChecked_Validation(aa(cc(unique(ii))),bb(dd(ff(jj)))) = POIChecked(aa(cc(unique(ii))),bb(dd(ff(jj))));


%         return;
    end
end
end
sum(POIChecked_Validation)
% end


