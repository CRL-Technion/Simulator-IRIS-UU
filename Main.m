clc
clear all
close all
addpath InitFunction
addpath ServiceFunction
addpath Control
addpath Command
addpath PostProcess
addpath StepFunction
%% IRIS input arguments
IRIS_build_folder = '\\wsl$\Ubuntu-20.04\home\davidalpert\Projects\IRISUav\build';
CommandToPowershell = ['powershell cd ',IRIS_build_folder,'; wsl '];

MonteCarloRunIRIS = 1;
num_vertex = (20);
file_to_write = 'testIRIS';
file_to_read = file_to_write;
initial_p = (1);
initial_eps = (8);
tightening_rate=(0);
method = (0);

%% Simulation arguments
MonteCarloRunSimulation = 5;
OutputFileName = 'SimulationPath';
CurrentPath = pwd;
CurrentPath(1) = lower(CurrentPath(1));
CurrentPath = ['/mnt/',CurrentPath(1),CurrentPath(3:end)];
CurrentPath(strfind(CurrentPath,'\'))='/';
% IRIS_build_Path_Linux = '/mnt/c/Users/david/AppData/Local/Packages/CanonicalGroupLimited.Ubuntu20.04onWindows_79rhkp1fndgsc/LocalState/rootfs/home/davidalpert/Projects/IRIS/build';
IRIS_build_Path_Windows = 'C:\Users\david\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu20.04onWindows_79rhkp1fndgsc\LocalState\rootfs\home\davidalpert\Projects\IRIS\build';
IRIS_build_Path_Linux = lower(IRIS_build_Path_Windows(1));
IRIS_build_Path_Linux = ['/mnt/',IRIS_build_Path_Linux(1),IRIS_build_Path_Windows(3:end)];
IRIS_build_Path_Linux(strfind(IRIS_build_Path_Linux,'\'))='/';
temp_path = 'C:\Users\david';
RunIRIS_path = '/home/davidalpert/Projects/IRIS/app/Script1.sh';
% build_graph_input = [num2str(seed),' ',num2str(num_vertex),' ',file_to_write];
search_graph_input = ['./app/search_graph ',file_to_read,' ',num2str(initial_p),' ',num2str(initial_eps),' ',num2str(tightening_rate),' ',num2str(method),' ',file_to_read];
% C:\Users\david\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu20.04onWindows_79rhkp1fndgsc\LocalState\rootfs\home\davidalpert\Projects\IRIS\build
LocationErrorParameterFileName = 'LocationErrorParameterFile';
%b_a_milli_g,b_g_degPerHr,avarageVelocity,minTimeAllowInRistZone,multipleCostFunction - c2
LocationErrorParameter = ...
    [10,10,1,1,0;
    10,10,8,1000,0];

%      10,10,1,1,0];
%    [10,10,1,0,1;
% 10,10,1,0,5;
% 10,10,1,0,10;
% 10,10,1,0,15;
% 10,10,1,0,20;
% 10,10,1,2,1;
% 10,10,1,2,5;
% 10,10,1,2,10;
% 10,10,1,2,15;
% 10,10,1,2,20;
% 10,10,1,5,1;
% 10,10,1,5,5;
% 10,10,1,5,10;
% 10,10,1,5,15;
% 10,10,1,5,20];
minTimeRiskZone = [66:-2:0]';
% minTimeRiskZone = [51:5:150]';

L = ones(length(minTimeRiskZone),1);
% LocationErrorParameter = [10*L,10*L,1*L,minTimeRiskZone,0*L];
ResultFolder = [pwd,'\Results\'];
a =datestr((now));
OutputFolderTemp = [ResultFolder,a(1:11),'_'];
temp = split(a(13:end),':');
OutputFolder = [OutputFolderTemp,temp{1},temp{2},temp{3}];
mkdir(OutputFolder);

%% Run IRIS
SizeLocationErrorParameter =size(LocationErrorParameter);
indexFolder =0;
for indexLocationErrorParameter=1:1:SizeLocationErrorParameter(1)
    indexFolder = indexFolder+1;
    CurrentOutputFolder = ['\runNumber',num2str(indexFolder)];
    OutputFolderCurrent = [OutputFolder,CurrentOutputFolder];
    mkdir(OutputFolderCurrent)
    for IndexMonteCarloRunIRIS = 1:1:MonteCarloRunIRIS
       
        %Location Error Parameter
        WriteLocationErrorParameterFile([IRIS_build_folder,'\',LocationErrorParameterFileName],LocationErrorParameter(indexLocationErrorParameter,:));%
        
        %Run build_graph
        seed = (IndexMonteCarloRunIRIS);
        build_graph_command = ['./app/build_graph ',num2str(seed),' ',num2str(num_vertex),' ',file_to_write];
        system([CommandToPowershell,build_graph_command])
        
        %Run search_graph
        system([CommandToPowershell,search_graph_input])

        Command = InitCommand(file_to_write,IRIS_build_folder);
        POI_belong_region;
        totalOptimalPOIIRIS = length(unique([WCovRegion_POI_SearchSpace,WOutagesRegion_POI_SearchSpace]));
        totalOptimalPOISimulation = length(unique([WOutagesRegion_POI_palnned,WCovRegion_POI_palnned]));
        totalOptimalPOIIRIS-totalOptimalPOISimulation
        %             if (totalOptimalPOISimulation<totalOptimalPOIIRIS)
        %                 continue;
        %             end
        %% Run Simulation with IRIS path
        
        %         addpath InitFunction
        %         addpath ServiceFunction
        %         addpath Control
        %         addpath Command
        %         addpath PostProcess
        %         addpath StepFunction
        %% Initilize
        for IndexMonteCarloRunSimulation=1:1:MonteCarloRunSimulation
            %         while(IndexMonteCarloRunSimulation <= MonteCarloRunSimulation)
            %             IndexMonteCarloRunSimulation = IndexMonteCarloRunSimulation+1;
            ScenarioParameter = InitScenario;
            IMUParameters = InitIMU(ScenarioParameter);
            Quad = InitQuad;
            Control = InitControl;
            Command = InitCommand(file_to_write,IRIS_build_folder);
            [State,Command] = InitState(IMUParameters,Command,ScenarioParameter.ScenarioMode);
            [NavState,Command] = InitNavState(Command,State,ScenarioParameter);
            
            Command.PoseSimulation = [State.X',State.psi,State.theta,NavState.theta,0];
            
            EKF = InitEKF(NavState,IMUParameters,ScenarioParameter);
            DynamicStateParameter = InitDynamic(ScenarioParameter,State);
            SensorMeas = GetSensorMeas(DynamicStateParameter,IMUParameters);
            DynamicNavStateParameter = UpdateNavDynamic(SensorMeas,NavState);
            State = UpdateTrueIMUBias(SensorMeas,DynamicStateParameter,State);
            
            %% Step
            InitRecordParameter;%[RecordState,RecordNavState,RecordEKF,RecordCommand,RecordScenarioParameter]= InitRecordParameter(State,NavState,EKF,1);
            time = 0;
            t = 0;
            Path_Length = 0;
            length_in_location_error = 0;
            time_in_location_error = 0;
            temp_length_in_location_error=0;
            temp_time_in_location_error = 0;
            for i=1:1:(ScenarioParameter.FinalTime/ScenarioParameter.dt)
                
                %   Update State
                State = UpdateState(ScenarioParameter,State,DynamicStateParameter.f_b,DynamicStateParameter.w_b);
                NavState = UpdateNavState(ScenarioParameter,NavState,DynamicNavStateParameter.f_b,DynamicNavStateParameter.w_b,IMUParameters);
                
                %   EKF update
                ScenarioParameter.isGPSAvailable = checkGPSAvailable(State);
                
                if (ScenarioParameter.IdealIMU==0)
                    [NavState,EKF] = EKFStep(ScenarioParameter,NavState,State,DynamicNavStateParameter,EKF,i);
                end
                
                if (ScenarioParameter.ScenarioMode>0)% not static
                    %   Implement Controller
                    Control = UpdateControl(Control,NavState,Command.X_des_GF,Command.psi_des,DynamicNavStateParameter,Quad,ScenarioParameter.g,ScenarioParameter.dt);
                    Control.init=1;
                end
                %   DynamicsAndKinematic
                DynamicStateParameter = UpdateDynamic(ScenarioParameter,DynamicStateParameter,State,Control,Quad,time);
                SensorMeas = GetSensorMeas(DynamicStateParameter,IMUParameters);
                DynamicNavStateParameter = UpdateNavDynamic(SensorMeas,NavState);
                State = UpdateTrueIMUBias(SensorMeas,DynamicStateParameter,State);
                
                if (Command.Finish_pose_command )
                    break;
                end
                if (ScenarioParameter.ScenarioMode>0)% not static
                    
                    [Command,Control]=UpdateCommandAndInitlizeControl(State,Command,Control,NavState,ScenarioParameter.ScenarioMode,i);
                end
                %         checkPOI;%Command = checkPOI(State,Environment,Command);
                %         CheckCollision;%Environment= CheckCollision(Environment,State,time);
                
                %Record
                RecordParameter
                if (i>1)
                    additional_path_length = norm(RecordState.X(:,i)-RecordState.X(:,i-1));
                    Path_Length = Path_Length + additional_path_length;
                    
                    if (ScenarioParameter.isGPSAvailable==0)
                        if (RecordScenarioParameter.isGPSAvailable(:,i-1) == 1)
                            if(length_in_location_error(1)<1e-6)
                                length_in_location_error = temp_length_in_location_error;
                            else
                                length_in_location_error = [length_in_location_error,temp_length_in_location_error];
                            end
                            temp_length_in_location_error = 0;
                        end
                        temp_length_in_location_error =temp_length_in_location_error+additional_path_length;
                        
                    end
                    if (Command.Finish_pose_command && ScenarioParameter.isGPSAvailable==0 &&RecordScenarioParameter.isGPSAvailable(:,i-1) == 0)
                        if(length_in_location_error(1)<1e-6)
                            length_in_location_error = temp_length_in_location_error;
                        else
                            length_in_location_error = [length_in_location_error,temp_length_in_location_error];
                        end
                    end
                    
                    
                    
                    if (ScenarioParameter.isGPSAvailable==0)
                        if (RecordScenarioParameter.isGPSAvailable(:,i-1) == 1)
                            if(time_in_location_error(1)<1e-6)
                                time_in_location_error = temp_time_in_location_error;
                            else
                                time_in_location_error = [time_in_location_error,temp_time_in_location_error];
                            end
                            temp_time_in_location_error = 0;
                        end
                        temp_time_in_location_error =temp_time_in_location_error+ScenarioParameter.dt;
                        
                    end
                    if (Command.Finish_pose_command && ScenarioParameter.isGPSAvailable==0 &&RecordScenarioParameter.isGPSAvailable(:,i-1) == 0)
                        if(time_in_location_error(1)<1e-6)
                            time_in_location_error = temp_time_in_location_error;
                        else
                            time_in_location_error = [time_in_location_error,temp_time_in_location_error];
                        end
                    end
                    
                end
                
                
                time = time+ScenarioParameter.dt;
                
            end
            time = t;
            %% PostProcees - Output path for testing
            
            %             thetaTrueSimulation = 0;
            %             thetaNavSimulation = 0;
            %             thetaCamera = 0;
            %             PoseUpdateTheta = zeros(1,5);
            %
            thetaTrueSimulation = Command.PoseSimulation(:,5);
            thetaNavSimulation = Command.PoseSimulation(:,6);
            thetaCamera = Command.Pose_des_GF(:,5) -  thetaNavSimulation + thetaTrueSimulation;
            PoseUpdateTheta = [Command.PoseSimulation(:,1:4),thetaCamera];
            %             for i=1:1:length(Command.PoseSimulation)
            %                 thetaTrueSimulation(i) = Command.PoseSimulation(i,5);
            %                 thetaNavSimulation(i) = Command.PoseSimulation(i,6);
            %                 thetaCamera(i) = Command.Pose_des_GF(i,5) -  thetaNavSimulation(i) + thetaTrueSimulation(i);
            %                 PoseUpdateTheta(i,:) = [Command.PoseSimulation(i,1:4),thetaCamera(i)];
            %             end
            
            % Creating file to be written to
            fileName = fopen([IRIS_build_folder,'\',OutputFileName,'_',file_to_write],'w');
            % fileName = fopen([OutputFileName,'_',file_to_write],'w');
            % Writing data to file
            fprintf(fileName, '%f %f %f %f %f\n', PoseUpdateTheta');
            % Closing
            fclose(fileName)
            
            %% check collision and POIs number
            %Run checkPOIandCollision
            system([CommandToPowershell,'./app/checkPOIandCollision ',OutputFileName,'_',file_to_write])
                        
            %% todo ouput with one file
            POIUniqueSimualtion = NumberOfPOIFromVertexFile([IRIS_build_folder,'\',OutputFileName,'_',file_to_write,'_vertex']);
            LastName = {'Scarion number 1'};
            Inspected_POIs_desire = length(Command.POIUnique);
            Planned_Inspected_POIs_simulation = length(intersect(POIUniqueSimualtion,Command.POIUnique));
            Total_Inspected_POIs_simulation = length(POIUniqueSimualtion);
            Additional_Inspected_POIs_simulation = Total_Inspected_POIs_simulation-Planned_Inspected_POIs_simulation;
            Number_of_collision =  GetNumberOfCollisionSimulation([IRIS_build_folder,'\',OutputFileName,'_',file_to_write,'_edge']);
            Total_length_planned = GetPathLength(Command.Pose_des_GF);
            Total_length_simulation = Path_Length;%GetPathLength(Command.PoseSimulation);
            sum_length_in_location_error = sum(length_in_location_error);
            min_length_in_location_error = min(length_in_location_error);
            max_length_in_location_error = max(length_in_location_error);
            avarage_length_in_location_error = mean(length_in_location_error);
            avarage_velocity =LocationErrorParameter(indexLocationErrorParameter,3);
            minTimeAllowInRistZone = LocationErrorParameter(indexLocationErrorParameter,4);
            multipleCostFunction_c2 = LocationErrorParameter(indexLocationErrorParameter,5);
            %             total_location_error = locationErrorFunc(mean(IMUParameters.b_a),mean(IMUParameters.b_g),ScenarioParameter.g,length_in_location_error./avarage_velocity);
            total_location_error = locationErrorFunc(mean(IMUParameters.b_a),mean(IMUParameters.b_g),ScenarioParameter.g,time_in_location_error);
            
            T = table(seed,num_vertex,initial_p,initial_eps,tightening_rate,method,...
                Inspected_POIs_desire,Total_Inspected_POIs_simulation,...
                Planned_Inspected_POIs_simulation,Additional_Inspected_POIs_simulation,...
                Number_of_collision,Total_length_planned,Total_length_simulation,sum_length_in_location_error,min_length_in_location_error,max_length_in_location_error,avarage_length_in_location_error...
                ,avarage_velocity,minTimeAllowInRistZone,multipleCostFunction_c2);
            
            
            writetable(T,[OutputFolderCurrent,'/OutputUAVsimulation.txt'],'WriteMode','Append','WriteVariableNames',true,'WriteRowNames',true)
            
            percentageOfPOI = Planned_Inspected_POIs_simulation/Inspected_POIs_desire*100;
            percentageLocationError = sum_length_in_location_error/Total_length_simulation*100;
            percentage_total_location_error = total_location_error/Total_length_simulation*100;
            MainOutputVar = table(seed,num_vertex,initial_p,initial_eps,tightening_rate,method,...
                percentageOfPOI,percentageLocationError,Number_of_collision,percentage_total_location_error,multipleCostFunction_c2,total_location_error...
                ,percentageWCovRegion_POI,percentageWOutagesRegion_POI,totalOptimalPOIIRIS,totalOptimalPOISimulation);
            writetable(MainOutputVar,[OutputFolderCurrent,'/OutputUAVsimulationMain.txt'],'WriteMode','Append','WriteVariableNames',true,'WriteRowNames',true)
            
        end
    end
end

%% PostProcess
% folderResult = 'C:\Users\david\OneDrive\DocumentsProjects\Thesis\results_ref';
% dataOutputwithHeader = readtable([folderResult,'\OutputUAVsimulationMain.txt']);
% dataOutputRef = dataOutputwithHeader(1:2:end,:) ;
%
% folderResult = 'C:\Users\david\OneDrive\DocumentsProjects\Thesis\result_test1';
% dataOutputwithHeader = readtable([folderResult,'\OutputUAVsimulationMain.txt']);
% dataOutputTest1= dataOutputwithHeader(1:2:end,:) ;
%
%
% figure(1)
% hold on; box on; grid on;
% title('PercentageLocationError Vs. PercentageOfPOI')
% xlabel('PercentageLocationError[%]')
% ylabel('PercentageOfPOI[%]')
% plot(dataOutputRef.percentageLocationError,dataOutputRef.percentageOfPOI,'b*')
% plot(dataOutputTest1.percentageLocationError,dataOutputTest1.percentageOfPOI,'r*')
% legend('Ref','Test1')
%
% figure(2)
% hold on; box on; grid on;
% title('PercentageLocationError Vs. NumberOfCollision')
% xlabel('PercentageLocationError[%]')
% ylabel('NumberOfCollision')
% plot(dataOutputRef.percentageLocationError,dataOutputRef.Number_of_collision,'b*')
% plot(dataOutputTest1.percentageLocationError,dataOutputTest1.Number_of_collision,'r*')
% legend('Ref','Test1')

% boxplot([dataOutputRef.percentageLocationError,dataOutputTest1.percentageLocationError])
%%
% [visiblePointSimulation,visiblePointIndexCellSimulation] = CountPOIs(PoseUpdateTheta,Environment,CameraParameter);
% length(unique(visiblePointSimulation))
% [visiblePointIRIS,visiblePointIndexCellIRIS] = CountPOIs(Command.Pose_des_GF,Environment,CameraParameter);
% length(unique(visiblePointIRIS))
% length(unique(visiblePointSimulation))/length(unique(visiblePointIRIS))
%%
% SaveResults =0;
% PlotEKFResult(RecordState,RecordNavState,RecordEKF,IMUParameters,t,SaveResults);
% % plotDataNew(RecordState,RecordNavState,Command,RecordCommand,RecordScenarioParameter,IMUParameters,ScenarioParameter,t);
% plotDataNew
% save([pwd,'\Results\RecordResult'])
%%
%% Post process

% Environment = GetEnvironmentMission(ScenarioParameter.Rootfolder);
% CameraParameter = InitCamera;
% [POIInspectedCell,collisionCheck] = GetInspectedPOIandCollision(ScenarioParameter.Rootfolder);

%%
%  Plot_Trajectory