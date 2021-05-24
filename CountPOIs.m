function [visiblePoint,visiblePointIndexCell] = CountPOIs(pose,Environment,CameraParameter)
%%
eps = (1e-6);

% Command.POICell{Command.vertexTrajectoryTempForIndex(1)}
visiblePointIndex = 0;
visiblePoint = 0;
L =length(Environment.p0p1p2);

p0 = Environment.p0;
p1= Environment.p1;
p2 = Environment.p2;

visiblePointIndexCell = cell(1,1);
for i=1:1:length(pose(:,1))
%     i    
    posCommand = pose(i,1:3)+([0,0,-0.049]);
%     posCommand = single(posCommand);
    camera_to_point = Environment.TargetsBridge(:,1:3)-posCommand;
    normCamera_to_point = (vecnorm(camera_to_point'))';
    largeEnough = normCamera_to_point > (CameraParameter.MinDOF-eps);
    smallEnough = normCamera_to_point <= (CameraParameter.MaxDOF+eps);
    camera_to_pointDOF =  camera_to_point(largeEnough & smallEnough,1:3);
    normCamera_to_point = (vecnorm(camera_to_pointDOF'))';
    camera_to_point_normalized = camera_to_pointDOF./normCamera_to_point;
    psi = pose(i,4);
    cameraAngle = pose(i,5);
    CameraTangent = GetCameraTangent(psi,cameraAngle);
    CameraTangentNormalized = CameraTangent/norm(CameraTangent);
    angle = acos(camera_to_point_normalized*CameraTangentNormalized);

    FOV_Condition = (angle<=0.5*CameraParameter.FOV);
    result = [1:1:length(camera_to_point)];
    result = result(largeEnough & smallEnough);
    result = result(FOV_Condition);
    camera_to_point_normalized = camera_to_point_normalized(FOV_Condition,1:3);
    normCamera_to_point = (vecnorm(camera_to_pointDOF(FOV_Condition,1:3)'))';

index_loop = 0;
    for j=1:1:length(camera_to_point_normalized(:,1))
        visible = 1;
        [flag, u, v, t] = rayTriangleIntersection((posCommand'*ones(1,L))', (camera_to_point_normalized(j,:)'*ones(1,L))', p0, p1, p2) ;
        if (flag && sum(t<normCamera_to_point(j)-eps)>0)
            visible = 0;
        end
        if (visible && result(j) <= length(Environment.TargetsBridge(:,1)))
            visiblePointIndex = visiblePointIndex+1;
            visiblePoint(visiblePointIndex) = result(j);
            index_loop = index_loop+1;
        end
    end
    visiblePointIndexCell{i} = visiblePoint(visiblePointIndex-index_loop+1:visiblePointIndex);
end


