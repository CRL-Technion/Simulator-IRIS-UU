%%
fid = fopen('C:\Users\davidalpert11\OneDrive\מסמכים\טכניון\תואר שני\תזה\סימולצית רחפנים\סימולציה מעודכנת\IRISOutput\test1_conf_vertex');
tline = fgetl(fid);
vertexCell = cell(1,1);
vertexCell{1} = tline;
index = 0;
POI = 0;
indexPOI = 0;
POICell = cell(1,1);
while ischar(tline)
%     [aa,bb] = find(vertexTrajectory ==index);
%     if (isempty(aa))
%         index=index+1;
%         tline = fgetl(fid);
%         continue
%     end
        
    index=index+1;
    vertexCell{index} = tline;
    aa =str2num(vertexCell{index});
    for j =4:1:length(aa)
        indexPOI = indexPOI+1;
        POI(indexPOI) = aa(j);
    end
    if (length(aa)>3)
        POICell{index} = aa(4:end);
    else
        POICell{index} =[];
    end
    tline = fgetl(fid);
end
fclose(fid);
POIINDEX = 0;
index = 0;
temp = cell(1,1);
for i = 1 : 1:length(POICell)
    i
    for j = 1:1:length(POICell{i})
        index = index+1
        POIINDEX(index) = POICell{i}(j);
    end
%     temp{i} = Command.POICell{Command.vertexTrajectoryTempForIndex(i)}+1;
    
end
length(POIINDEX)
length(unique(POIINDEX))
%%
% function Command = checkPOI(State,Environment,Command)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


TargetPoint = zeros(1,3);
index =0;
for i=1:1:length(Environment.BridgeObjRaw(:,1))
    v = Environment.BridgeObjRaw(i,:);
    if i==1
        index = index +1;
        TargetPoint(index,:) = v;
    else
        [~,index_min] = min(vecnorm((TargetPoint-v)'));
        if (norm(TargetPoint(index_min,:)-v)<1e-3)
            continue;
        end
        index = index +1;
        TargetPoint(index,:) = v;
    end
end
length(TargetPoint)
% Environment.TargetsBridge = single(TargetPoint);
Environment.TargetsBridge = (TargetPoint);
%%
POIINDEX = 0;
index = 0;
temp = cell(1,1);
for i = 1 : 1:length(Command.vertexTrajectoryTempForIndex)
    for j = 1:1:length(Command.POICell{Command.vertexTrajectoryTempForIndex(i)})
        index = index+1;
        POIINDEX(index) = Command.POICell{Command.vertexTrajectoryTempForIndex(i)}(j);
    end
    temp{i} = Command.POICell{Command.vertexTrajectoryTempForIndex(i)}+1;
    
end
length(POIINDEX)
length(unique(POIINDEX))
%%
eps = (1e-6);

% Command.POICell{Command.vertexTrajectoryTempForIndex(1)}
visiblePointIndex = 0;
visiblePoint = 0;
FOV =94;
POI10 = 0;
lengthPOI = 0;
lengthCheckedPOI = 0;
p0p1p2 = Environment.p0p1p2;
L =length(Environment.p0p1p2);
% p0 = Environment.p0p1p2{1}(1,:);
% p1= Environment.p0p1p2{1}(2,:);
% p2 = Environment.p0p1p2{1}(3,:);
% for i=2:1:L
%     p0(i,:) = p0p1p2{i}(1,:);
%     p1(i,:) = p0p1p2{i}(2,:);
%     p2(i,:) = p0p1p2{i}(3,:); 
% end
p0 = Environment.p0;
p1= Environment.p1;
p2 = Environment.p2;
% p0 = single(p0);
% p1 = single(p1);
% p1 = single(p1);

visiblePointIndexCell = cell(1,1);
for i=1:1:length(Command.Pose_des_GF(:,1))
    i
%     Command.Pose_des_GF(i,1:3) = single(Command.Pose_des_GF(i,1:3));
pos = Command.Pose_des_GF(i,1:3);    
posCommand = (Command.Pose_des_GF(i,1:3)+([0,0,-0.0489999987]));
%         posCommand = single(Command.Pose_des_GF(i,1:3))+single([0,0,-0.049]);
%         posCommand = single(Command.Pose_des_GF(i,1:3))+single([0,0,-0.049]);

%     posCommand = single(posCommand);
%     posCommand = [-101.116753   -9.554846  -24.042088-0.0489999987];
    %     Environment.BridgeObjRaw
    camera_to_point = Environment.TargetsBridge(:,1:3)-posCommand;
%         camera_to_point = Environment.BridgeObjRaw(:,1:3)-posCommand;
%         camera_to_point = single(camera_to_point);
%     camera_to_point = single(camera_to_point);
normCamera_to_point = (vecnorm(camera_to_point'))';
%     normCamera_to_point = single(normCamera_to_point);
    largeEnough = normCamera_to_point > (CameraParameter.MinDOF-eps);
    smallEnough = normCamera_to_point <= (CameraParameter.MaxDOF+eps);
    camera_to_pointDOF =  camera_to_point(largeEnough & smallEnough,1:3);
%     camera_to_pointDOF = single(camera_to_pointDOF);
%     length(camera_to_pointDOF)
    normCamera_to_point = (vecnorm(camera_to_pointDOF'))';
    camera_to_point_normalized = camera_to_pointDOF./normCamera_to_point;
%     camera_to_point_normalized = single(camera_to_point_normalized);
    psi = Command.Pose_des_GF(i,4);
    cameraAngle = Command.Pose_des_GF(i,5);
        psi = single(psi);
cameraAngle = single(cameraAngle);
%     psi = -0.049089;
%     cameraAngle = 0.502143;
    CameraTangent = GetCameraTangent(psi,cameraAngle);
%     CameraTangent = single(CameraTangent);
    CameraTangentNormalized = CameraTangent/norm(CameraTangent);
%     CameraTangentNormalized = single(CameraTangentNormalized);
    angle = acos(camera_to_point_normalized*CameraTangentNormalized);
%         angle = single(angle);

    FOV_Condition = (angle<=0.5*CameraParameter.FOV);
    result = [1:1:length(camera_to_point)];
    result = result(largeEnough & smallEnough);
    result = result(FOV_Condition);
%     result =  int64(result);
    camera_to_point_normalized = camera_to_point_normalized(FOV_Condition,1:3);
%     camera_to_point_normalized = single(camera_to_point_normalized);
    normCamera_to_point = (vecnorm(camera_to_pointDOF(FOV_Condition,1:3)'))';
%     normCamera_to_point = single(normCamera_to_point);
%     length(camera_to_point_normalized(:,1))
index_loop = 0;
    for j=1:1:length(camera_to_point_normalized(:,1))
        visible = 1;
        %         for k=1:1:L%(Environment.BridgeObjFaces)
        %         [p0p1p2] = Environment.BridgeObjRaw(Environment.BridgeObjFaces(k,:),:);
        %         p0 = p0p1p2(1,:);
        %         p1 = p0p1p2(2,:);
        %         p2 = p0p1p2(3,:);
        %             p0 = p0p1p2{k}(1,:);
        %             p1 = p0p1p2{k}(2,:);
        %             p2 = p0p1p2{k}(3,:);
        %             [flag, u, v, t] = rayTriangleIntersection(posCommand, camera_to_point_normalized(j,:), p0(k,:), p1(k,:), p2(k,:)) ;

        [flag, u, v, t] = rayTriangleIntersection((posCommand'*ones(1,L))', (camera_to_point_normalized(j,:)'*ones(1,L))', p0, p1, p2) ;
%         t = single(t);
        if (flag && sum(t<normCamera_to_point(j)-eps)>0)
            visible = 0;
        end
        %         end
        if (visible && result(j) <= length(Environment.TargetsBridge(:,1)))
            visiblePointIndex = visiblePointIndex+1;
            visiblePoint(visiblePointIndex) = result(j);
            index_loop = index_loop+1;
            
        end
        
        %     Obstacle2Point = Environment.BridgeObstaclePoint-posCommand;
        %     normObstacle2Point = (vecnorm(Obstacle2Point'))';
        %
        %     camera2point = Environment.TargetsBridge(result(i),1:3)-posCommand;
        %     normCamera2point =norm(camera2point);
        %     camera2point_normalize = camera2point/normCamera2point;
        %     DistanceFilter = normObstacle2Point<normCamera2point;
        %     Obstacle2Point_DistanceFilter = Obstacle2Point(DistanceFilter,1:3);
        %     normObstacle2Point_DistanceFilter = (vecnorm(Obstacle2Point_DistanceFilter'))';
        %     Obstacle2Point_DistanceFilter_normalize = Obstacle2Point_DistanceFilter./normObstacle2Point_DistanceFilter;
        %
        %     y = Environment.RadiusObstacle; x = normObstacle2Point_DistanceFilter;
        %     FOVObstacle = (atan2(y,x));
        %     angle = acos(Obstacle2Point_DistanceFilter_normalize*camera2point_normalize');
        %     FOV_Condition = (angle<=0.5*FOVObstacle);
        %     if (sum(FOV_Condition))
        %         stay(j) = 0;
        %     else
        %         stay(j) = 1;
        %     end
    end
    visiblePointIndexCell{i} = visiblePoint(visiblePointIndex-index_loop+1:visiblePointIndex);
    length(visiblePoint)
%     visiblePoint
end
length((visiblePoint))
length(uniquetol(visiblePoint))
% save('visiblePoint_reg', 'visiblePoint')
%
%     %%
%     visible_points = GetVisiblePointIndices(CameraPos,Psi,CameraAngleTheta,FOV,MinDOF,MaxDOF);
%
%     normA = (vecnorm(CameraTangent))';
%     CosTheta = (camera_to_point*CameraTangent)./(normA.*normCamera_to_point);
%     ThetaInDegrees = real(acosd(CosTheta));
%     POIChecked = ThetaInDegrees <FOV;
%     %     POIChecked = abs(B*A)./(norm(A).*normB) > FOV;
%     %     CosTheta = max(min(dot(B,A)/((norm(A).*normB)),1),-1);
%     %     ThetaInDegrees = real(acosd(CosTheta));
%     %
%     [aa,bb] = find(POIChecked > 0);
%     if (~isempty(aa))
%         [cc,dd] = find(normCamera_to_point(aa)<200);
%         if (~isempty(cc))
%             POI10 = POI10+length(cc);
%             lengthCheckedPOI(i) = length(cc);
%
%         else
%             lengthCheckedPOI(i) = 0;
%         end
%         lengthPOI(i) = length(Command.POICell{Command.vertexTrajectoryTempForIndex(i)});
%     end
% end
% POI10
% lengthCheckedPOI
% figure(1)
% plot(lengthCheckedPOI,lengthPOI,'*')
% %%
% % normB = (vecnorm(B'))';
% % POIChecked = abs(B*A)./(norm(A).*normB) > FOV;
% % [aa,bb] = find(POIChecked > POIChecked_Validation);
% % if (~isempty(aa))
% %     [cc,dd] = find(normB(aa)<10);
% %     if (~isempty(cc))
% %         C = Environment.BridgeObstaclePoint-posCommand;
% %         normC = vecnorm(C')';
% %         [ee,ff] = find(normC<=max(normB(aa(cc))'));
% %         obstacleCheck = (C(ee,1:3)./normC(ee))*(B(aa(cc),1:3)'./normB(aa(cc))');
% %         y = Environment.RadiusObstacle; x = normC(ee);
% %         FOVObstacle = cos(atan2(y,x));
% %         [hh,ii] = find(obstacleCheck>FOVObstacle);
% %         jj = ones(size(unique(ii)))';
% %         POIChecked_Validation(aa(cc(unique(ii))),bb(dd(ff(jj)))) = POIChecked(aa(cc(unique(ii))),bb(dd(ff(jj))));
% %
% %
% %         %         return;
% %     end
% % end
% % end
% % sum(POIChecked_Validation)
%
% % end
%
%
