WCovRegion_POI_palnned = 0;
WOutagesRegion_POI_palnned = 0;

for i = 1:1:length(Command.vertexTrajectoryTempForIndex)
     if isempty(Command.POICell{Command.vertexTrajectoryTempForIndex(i)})
        continue
    end
    isWCovRegion = CheckIsWcovRegion(Command.Pose_des_GF(i,:));
    if (isWCovRegion)
        if (WCovRegion_POI_palnned(1)==0)
            WCovRegion_POI_palnned = Command.POICell{Command.vertexTrajectoryTempForIndex(i)};
        else
            WCovRegion_POI_palnned = [WCovRegion_POI_palnned,Command.POICell{Command.vertexTrajectoryTempForIndex(i)}];
        end
    else
             if (WOutagesRegion_POI_palnned(1)==0)
            WOutagesRegion_POI_palnned = Command.POICell{Command.vertexTrajectoryTempForIndex(i)};
        else
            WOutagesRegion_POI_palnned = [WOutagesRegion_POI_palnned,Command.POICell{Command.vertexTrajectoryTempForIndex(i)}];
        end
    end
end

%%
WCovRegion_POI_SearchSpace = 0;
WOutagesRegion_POI_SearchSpace = 0;

for i = 1:1:length(Command.VerticsPosition(:,1))
    if isempty(Command.POICellVertices{i})
        continue
    end
    isWCovRegion = CheckIsWcovRegion(Command.VerticsPosition(i,:));
    if (isWCovRegion)
                if (WCovRegion_POI_SearchSpace(1)==0)
            WCovRegion_POI_SearchSpace = Command.POICellVertices{i};
        else
            WCovRegion_POI_SearchSpace = [WCovRegion_POI_SearchSpace,Command.POICellVertices{i}];
        end
    else
                  if (WOutagesRegion_POI_SearchSpace(1)==0)
            WOutagesRegion_POI_SearchSpace = Command.POICellVertices{i};
        else
            WOutagesRegion_POI_SearchSpace = [WOutagesRegion_POI_SearchSpace,Command.POICellVertices{i}];
        end
    end
    
    
end


percentageWCovRegion_POI = length(unique(WCovRegion_POI_palnned))/length(unique(WCovRegion_POI_SearchSpace))*100;
percentageWOutagesRegion_POI = length(unique(WOutagesRegion_POI_palnned))/length(unique(WOutagesRegion_POI_SearchSpace))*100;

