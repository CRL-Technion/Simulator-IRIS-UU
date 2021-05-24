 
%% todo output with one file
POIUniqueSimualtion = NumberOfPOIFromVertexFile([IRIS_build_folder,'\',OutputFileName,'_vertex']);
temp = importdata([OutputFolderName,'/testIRIS']);
Inspected_POIs_desire = temp(end,2)*temp(end,3);
% Inspected_POIs_desire = length(Command.POIUnique);
%todo what todo with case of p <1
Planned_Inspected_POIs_simulation = length(intersect(POIUniqueSimualtion,Command.POIUnique));
Total_Inspected_POIs_simulation = length(POIUniqueSimualtion);
Additional_Inspected_POIs_simulation = Total_Inspected_POIs_simulation-Planned_Inspected_POIs_simulation;
Number_of_collision =  GetNumberOfCollisionSimulation([IRIS_build_folder,'\',OutputFileName,'_edge']);
Total_length_planned = GetPathLength(Command.Pose_des_GF);
Total_length_simulation = Path_Length;%GetPathLength(Command.PoseSimulation);
sum_length_in_location_error = sum(length_in_location_error);
min_length_in_location_error = min(length_in_location_error);
max_length_in_location_error = max(length_in_location_error);
avarage_length_in_location_error = mean(length_in_location_error);
tempLocatiionErrorParameter = importdata([OutputFolderName,'LocationErrorParameterFile']);
avarage_velocity =tempLocatiionErrorParameter(3);
minTimeAllowInRiskZone = tempLocatiionErrorParameter(4);
maxTimeAllowInRiskZone = tempLocatiionErrorParameter(5);
multipleCostFunction_c2 = tempLocatiionErrorParameter(6);
%             total_location_error = locationErrorFunc(mean(IMUParameters.b_a),mean(IMUParameters.b_g),ScenarioParameter.g,length_in_location_error./avarage_velocity);
% total_location_error = locationErrorFunc(mean(IMUParameters.b_a),mean(IMUParameters.b_g),ScenarioParameter.g,time_in_location_error);
total_location_error = sum(vecnorm(RecordNavState.X-RecordState.X))*ScenarioParameter.dt;
T = table(seed,num_vertex,initial_p,initial_eps,tightening_rate,method,...
    Inspected_POIs_desire,Total_Inspected_POIs_simulation,...
    Planned_Inspected_POIs_simulation,Additional_Inspected_POIs_simulation,...
    Number_of_collision,Total_length_planned,Total_length_simulation,sum_length_in_location_error,min_length_in_location_error,max_length_in_location_error,avarage_length_in_location_error...
    ,avarage_velocity,minTimeAllowInRiskZone,maxTimeAllowInRiskZone,multipleCostFunction_c2);


writetable(T,[OutputFolderName,'/OutputUAVsimulation.txt'],'WriteMode','Append','WriteVariableNames',true,'WriteRowNames',true)
POI_belong_region;
totalOptimalPOIIRIS = length(unique([WCovRegion_POI_SearchSpace,WOutagesRegion_POI_SearchSpace]));
totalOptimalPOISimulation = length(unique([WOutagesRegion_POI_palnned,WCovRegion_POI_palnned]));

percentageOfPOI = Planned_Inspected_POIs_simulation/Inspected_POIs_desire*100;
percentageLocationError = sum_length_in_location_error/Total_length_simulation*100;
percentage_total_location_error = total_location_error/Total_length_simulation*100;
MainOutputVar = table(seed,num_vertex,initial_p,initial_eps,tightening_rate,method,...
    percentageOfPOI,percentageLocationError,Number_of_collision,percentage_total_location_error,multipleCostFunction_c2,total_location_error...
    ,percentageWCovRegion_POI,percentageWOutagesRegion_POI,totalOptimalPOIIRIS,totalOptimalPOISimulation);
writetable(MainOutputVar,[OutputFolderName,'/OutputUAVsimulationMain.txt'],'WriteMode','Append','WriteVariableNames',true,'WriteRowNames',true)
